#include "../evn.h"

const unsigned int n_samples = 1;
const unsigned int NetNumAllowedCycles = 1024;
const unsigned int EvNumAllowedCycles = 256;

unsigned int Network::c_input()
{
  return m_input.at(global_i);
}

void Network::c_output(unsigned int number)
{
  m_output.at(global_j) = number;
  ++global_j;
}

void Network::remove_random_nodeon()
{
  unsigned int nsz = nodeons.size();
  mu.reset_ud(0, nsz);
  nodeons.at(mu.get_ud())->self_destruct();
}

void Network::mutate()
{
  // Sizes
  unsigned int nsz = nodeons.size();
  unsigned int csz = connectons.size();
  
  // Reset for nodeon drift
  mu.reset_nd(nsz, 0.3);
  int nodeon_drift = mu.get_nd();
	// Normalize
	if (nodeon_drift > 2)
		nodeon_drift = 2;
	if (nodeon_drift < -2)
		nodeon_drift = -2;
	
  nodeon_drift = (nsz + nodeon_drift > 0) ? nodeon_drift : -nsz;
  
  // Add/remove nodeons until satisfied
  while (nsz + nodeon_drift != nodeons.size()) {
    if (nsz + nodeon_drift - nodeons.size() > 0)
      nodeons.push_back(new Nodeon(this));
    else if (nsz + nodeon_drift - nodeons.size() < 0)
      remove_random_nodeon(); // Handles any connectons attached
  }
  
  for (unsigned int i = 0; i < nodeons.size(); ++i) {
    nodeons.at(i)->node_mutate();
  }
	
	fit_saved_valid = false;
	cost_saved_valid = false;
}

void Network::net_run(double time)
{
  double stime = network_time;
  for (; network_time < stime + time; network_time += 0.1) {
    for (unsigned int i = 0; i < nodeons.size(); ++i) {
      nodeons.at(i)->lf(network_time);
    }
  }
}

double Network::net_cost()
{
	if (cost_saved_valid)
		return cost_saved;
	else {
		double misaligned = 0;
		for (unsigned int i = 0; i < n_samples; ++i) {
			std::vector<unsigned int> output;
			unsigned int sz_sample = load_sample(&m_input, &output, &m_output, i);
			net_run(NetNumAllowedCycles);
    
			for (unsigned int j = 0; j < sz_sample; ++j) {
				if (output[j] != m_output[j]) {
					misaligned += 1.0;
				}
			}
		}
		
		cost_saved = misaligned;
		cost_saved_valid = true;
  
		return misaligned;
	}
}

double Network::net_fitness()
{
	if (fit_saved_valid)
		return fit_saved;
	else {
		double c_cost = net_cost();
		double ret = 1 - exp(-m_net_last_cost / c_cost);
		m_net_last_cost = c_cost;
	
		fit_saved = ret;
		fit_saved_valid = true;
	
		return ret;
	}
}

void Network::run(unsigned int cycles)
{
  std::vector<unsigned int> o = m_output;
  for (unsigned int i = 0; i < cycles - 1; ++i) {
    dopamine = net_fitness();
  }
  m_output = o;
  net_run(NetNumAllowedCycles);
}

Network::Network()
{
	mu = Mutator<double>();
	
  global_i = 0;
  global_j = 0;
  
  network_time = 0;
  
  m_net_last_cost = std::numeric_limits<double>::infinity();
  m_ev_last_cost = std::numeric_limits<double>::infinity();
	
	dopamine = 0;
}
