#include "../psn.h"

const unsigned int n_samples = 1;
const unsigned int NumAllowedCycles = 1024;

Network::Network(NetworkConfiguration& ncfg_)
{
  ncfg = &ncfg_;

  unsigned int nsz = ncfg->nc.size();
  nodeons.reserve(nsz);

  while (nodeons.size() < nsz) {
    construct_nodeon(this);
  }

  std::vector<ConnectonConfiguration>::iterator connecton_it;
  for (connecton_it = ncfg->cc.begin(); connecton_it < ncfg->cc.end(); ++connecton_it) {
    construct_connecton(nodeons.at(connecton_it->src), nodeons.at(connecton_it->dst), this);
  }

  last_cost = ncfg->cost;
  saved_cost = ncfg->cost;
  saved_cost_valid = false;

  last_fitness = ncfg->fitness;
  saved_fitness = ncfg->fitness;
  saved_fitness_valid = false;

  sno = 0;
  ssz = load_sample(&m_input, &t_output, &m_output, 0);
}

Network::~Network()
{
  unsigned int nsz = ncfg->nc.size();

  std::vector<ConnectonConfiguration>::iterator connecton_it;
  std::vector<unsigned int> loc_in_src_(nsz);
  for (connecton_it = ncfg->cc.begin(); connecton_it < ncfg->cc.begin(); ++connecton_it) {
    unsigned int node_id = connecton_it->src;
    unsigned int loc_in_src = loc_in_src_.at(node_id);

    double weight = nodeons.at(node_id)->src_connectons.at(loc_in_src)->weight;
    double c = nodeons.at(node_id)->src_connectons.at(loc_in_src)->c;

    connecton_it->weight = weight;
    connecton_it->c = c;

    ++loc_in_src_.at(node_id);
  }

  ncfg->cost = cost();
  ncfg->fitness = fitness();

  while (!nodeons.empty()) {
    destroy_nodeon(nodeons.front());
  }
}

unsigned int Network::c_input(unsigned int idx)
{
  return m_input.at(idx);
}

void Network::c_output(unsigned int data)
{
  m_output.at(global_j) = data;
  ++global_j;
}

// Simulate each nodeon
void Network::net_run(double time)
{
  double stime = network_time;
  for (; network_time < stime + time; network_time += 0.1) {
    if (global_i < m_input.size()) {
      nodeons.at(c_input(global_i))->spike = true;
      nodeons.at(c_input(global_i))->respike = false;
      ++global_i;
    }

    for (unsigned int i = 0; i < nodeons.size(); ++i) {
      nodeons.at(i)->lf(network_time);
    }

    unsigned int gj = global_j;

    for (unsigned int i = n_inputs; i < n_inputs + n_outputs; ++i) {
      if (nodeons.at(i)->spike) {
        c_output(i - n_inputs);
      }
    }

    double misaligned = 0;
    for (unsigned int i = gj; i < global_j; ++i) {
      misaligned -= std::fabs(m_output.at(i) - t_output.at(i));
    }

    dopamine += (1 + erf(misaligned)) * 10;
    if (dopamine < 0) {
      dopamine = 0;
    }

    if (global_j >= ssz) {
      global_j = 0;
      ++sno;

      if (sno >= n_samples) {
        break;
      }

      ssz = load_sample(&m_input, &t_output, &m_output, sno);
    }
  }
}

// Compute the cost value the network
double Network::cost()
{
  // Check for valid saved value, if so return that (massive time saver)
  if (saved_cost_valid)
    return saved_cost;
  // If not compute cost from scratch
  else {
    double misaligned = 0;
    // Compute cost for each sample
    for (unsigned int i = 0; i < n_samples; ++i) {
      std::vector<unsigned int> output;
      // Load the sample
      unsigned int sz_sample = load_sample(&m_input, &t_output, &m_output, i);
      // Run the network for some cycles
      net_run(NumAllowedCycles);

      // Calculate the misalignment of the outputs
      for (unsigned int j = 0; j < sz_sample; ++j) {
        misaligned += std::fabs(t_output[j] - m_output[j]);
      }
    }

    // Save and validate the cost
    saved_cost = misaligned;
    saved_cost_valid = true;

    return misaligned;
  }
}

double Network::fitness()
{
  // If there is a valid saved value, return that
  if (saved_fitness_valid)
    return saved_fitness;
  else {
    // Compute the cost
    double c_cost = cost();
    // Compare the current cost to the last one
/*    double ret = 1 - exp(-last_cost / c_cost);
    last_cost = c_cost;
*/

    double ret = 1.0 / (c_cost + 1);
    // Save and validate the fitness
    saved_fitness = ret;
    saved_fitness_valid = true;

    return ret;
  }
}

// Run the network with STDP for some cycles
/*void Network::run(unsigned int cycles = n_samples + 1)
{
  std::vector<unsigned int> o = m_output;
  for (unsigned int i = 0; i < cycles - 1; ++i) {
    dopamine 
    saved_cost_valid = false;
    saved_fitness_valid = false;

    dopamine -= 0.1;
    if (dopamine < 0) {
      dopamine = 0;
    }
  }
  m_output = o;
  net_run(NumAllowedCycles);
}*/
