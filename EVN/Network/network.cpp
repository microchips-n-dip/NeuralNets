#include "../evn.h"

const unsigned int n_samples = 1;
const unsigned int NetNumAllowedCycles = 1024;
const unsigned int EvNumAllowedCycles = 256;

// Get the current input at the location indicated by global_i
unsigned int Network::c_input()
{
  return m_input.at(global_i);
}

// Write to the current output
void Network::c_output(unsigned int number)
{
  m_output.at(global_j) = number;
  // It is assumed that a network is never allowed to change the output it has written
  ++global_j;
}

// Remove a nodeon
void Network::remove_random_nodeon()
{
  unsigned int nsz = nodeons.size();
  mu.reset_ud(0, nsz);
  nodeons.at(mu.get_ud())->self_destruct();
}

// Add or remove some number of nodeons given by nodeon_drift,
// then mutate each nodeon
void Network::mutate()
{
  // Sizes
  // (it's much more convenient to type three letters)
  unsigned int nsz = nodeons.size();
  unsigned int csz = connectons.size();

  // Normal limits
  // A way of making sure a network doesn't randomly occupy all the available memory
  // after the first generation
  const int nlim = 2;

  // Reset for nodeon drift
  mu.reset_nd(nsz, 0.3);
  int nodeon_drift = mu.get_nd();
  // Normalize
  if (nodeon_drift > nlim)
    nodeon_drift = nlim;
  if (nodeon_drift < -nlim)
    nodeon_drift = -nlim;

  printf("nodeon_drift: %d\n", nodeon_drift);
  // Double check that there is no underflow problem, otherwise the program will take more than 224 GB
  nodeon_drift = (int(nsz) > -nodeon_drift) ? nodeon_drift : 1 - nsz;

  // Add/remove nodeons until satisfied
  while (nsz + nodeon_drift != nodeons.size()) {
    if (nsz + nodeon_drift > nodeons.size())
      nodeons.push_back(new Nodeon(this));
    else if (nsz + nodeon_drift < nodeons.size())
      remove_random_nodeon(); // Handles any connectons attached
  }

  // Mutate each node
  for (unsigned int i = 0; i < nodeons.size(); ++i) {
    nodeons.at(i)->node_mutate();
  }

  // Invalidate the saved values
  fit_saved_valid = false;
  cost_saved_valid = false;
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
double Network::net_cost()
{
  // Check for valid saved value, if so return that (massive time saver)
  if (cost_saved_valid)
    return cost_saved;
  // If not compute cost from scratch
  else {
    double misaligned = 0;
    // Compute cost for each sample
    for (unsigned int i = 0; i < n_samples; ++i) {
      std::vector<unsigned int> output;
      // Load the sample
      unsigned int sz_sample = load_sample(&m_input, &output, &m_output, i);
      // Run the network for some cycles
      net_run(NetNumAllowedCycles);

      // Calculate the misalignment of the outputs
      for (unsigned int j = 0; j < sz_sample; ++j) {
        misaligned += output[j] - m_output[j];
      }
    }

    // Save and validate the cost
    cost_saved = std::fabs(misaligned);
    cost_saved_valid = true;

    return std::fabs(misaligned);
  }
}

// Calculate the fitness of the network
// Fitness is measured as the networks ability to improve
double Network::net_fitness()
{
  // If there is a valid saved value, return that
  if (fit_saved_valid)
    return fit_saved;
  else {
    // Compute the cost
    double c_cost = net_cost();
    // Compare the current cost to the last one
    double ret = 1 - exp(-m_net_last_cost / c_cost);
    m_net_last_cost = c_cost;

    // Save and validate the fitness
    fit_saved = ret;
    fit_saved_valid = true;

    return ret;
  }
}

// Run the network with STDP for some cycles
void Network::run(unsigned int cycles)
{
  std::vector<unsigned int> o = m_output;
  for (unsigned int i = 0; i < cycles - 1; ++i) {
    dopamine = net_fitness();
    cost_saved_valid = false;
    fit_saved_valid = false;
  }
  m_output = o;
  net_run(NetNumAllowedCycles);
}

Network::Network()
{
  global_i = 0;
  global_j = 0;

  network_time = 0;

  // Set the last costs to infinity, to avoid false results
  m_net_last_cost = std::numeric_limits<double>::infinity();
  m_ev_last_cost = std::numeric_limits<double>::infinity();

  dopamine = 0;
}
