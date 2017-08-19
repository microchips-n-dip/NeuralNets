#include "../psn.h"

const unsigned int n_samples = 1;
const unsigned int NumAllowedCycles = 64;

Network::Network(NetworkConfiguration& ncfg_)
{
  ncfg = &ncfg_;

  printf("Number of nodeons: %d\n", ncfg->nc.size());
  printf("Number of connectons: %d\n", ncfg->cc.size());

  unsigned int nsz = ncfg->nc.size();
  nodeons.reserve(nsz);
  nodeons.resize(nsz);

  std::vector<Nodeon*>::iterator node_it;
  for (node_it = nodeons.begin(); node_it < nodeons.end(); ++node_it) {
    *node_it = new Nodeon(this);
  }

  printf("Finished creating nodes\n");

  std::vector<ConnectonConfiguration>::iterator connecton_it;
  for (connecton_it = ncfg->cc.begin(); connecton_it < ncfg->cc.end(); ++connecton_it) {
    new Connecton(nodeons.at(connecton_it->src), nodeons.at(connecton_it->dst), this, true);
  }
  printf("Finished making new network\n");

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

  printf("Destroying network\n");

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

  printf("Copied connecton data\n");

  ncfg->cost = cost();
  ncfg->fitness = fitness();

  while (nodeons.size() > 0) {
    (*nodeons.begin())->self_destruct();
  }

  printf("Finished destructing network\n");
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

    for (unsigned int i = n_inputs; i < n_inputs + n_outputs; ++i) {
      if (nodeons.at(i)->spike) {
        c_output(i - n_inputs);
        break;
      }
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
void Network::run(unsigned int cycles = n_samples + 1)
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
