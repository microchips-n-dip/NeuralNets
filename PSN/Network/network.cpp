#include "../psn.h"

const unsigned int n_samples = 1;
const unsigned int NumAllowedCycles = 64;

Network::Network(NetworkConfiguration& ncfg_)
{
  ncfg = &ncfg_;

  unsigned int nsz = ncfg->nc.size();
  for (unsigned int i = 0; i < nsz; ++i) {
    nodeons.push_back(new Nodeon(this));
    nodeons.at(i)->ntype = ncfg->nc.at(i).ntype;
  }

  std::vector<ConnectonConfiguration>::iterator connecton_it;
  for (connecton_it = ncfg->cc.begin(); connecton_it < ncfg->cc.end(); ++connecton_it) {
    new Connecton(nodeons.at(connecton_it->src), nodeons.at(connecton_it->dst), this, true);
  }

  last_cost = ncfg->cost;
  saved_cost = ncfg->cost;
  saved_cost_valid = false;

  last_fitness = ncfg->fitness;
  saved_fitness = ncfg->fitness;
  saved_fitness_valid = false;
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

  std::vector<Nodeon*>::iterator node_it;
  for (node_it = nodeons.begin(); node_it < nodeons.end(); ++node_it) {
    (*node_it)->self_destruct();
  }
}

// Simulate each nodeon
void Network::net_run(double time)
{
  double stime = network_time;
  for (; network_time < stime + time; network_time += 0.1) {
    for (unsigned int i = 0; i < nodeons.size(); ++i) {
      nodeons.at(i)->lf(network_time);
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
      unsigned int sz_sample = load_sample(&m_input, &output, &m_output, i);
      // Run the network for some cycles
      net_run(NumAllowedCycles);

      // Calculate the misalignment of the outputs
      for (unsigned int j = 0; j < sz_sample; ++j) {
        misaligned += std::fabs(output[j] - m_output[j]);
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
    double ret = 1 - exp(-last_cost / c_cost);
    last_cost = c_cost;

    // Save and validate the fitness
    saved_fitness = ret;
    saved_fitness_valid = true;

    return ret;
  }
}

// Run the network with STDP for some cycles
void Network::run(unsigned int cycles)
{
  std::vector<unsigned int> o = m_output;
  for (unsigned int i = 0; i < cycles - 1; ++i) {
    dopamine = fitness();
    saved_cost_valid = false;
    saved_fitness_valid = false;
  }
  m_output = o;
  net_run(NumAllowedCycles);
}
