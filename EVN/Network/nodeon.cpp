#include "../evn.h"

const double pi = acos(-1);
const double npi = std::sqrt(0.25 * pi);

Nodeon::Nodeon(Network* _network)
{
  network = _network;

  // Default type of nodeon
  ntype = 0;

  m_inp = 0;
  m_activation = 0;
  m_llft = 0;
}

void Nodeon::self_destruct()
{
  while (src_connectons.size() > 0)
    (*src_connectons.begin())->self_destruct();
  while (dst_connectons.size() > 0)
    (*dst_connectons.begin())->self_destruct();
}

void Nodeon::add_connecton_with_random_nodes()
{
  // Get sizes
  unsigned int nsz = network->nodeons.size();

  if (nsz > 0) {
    // Reset for destination nodeon number
    network->mu.reset_ud(0, nsz);
    unsigned int node_number = network->mu.get_ud();

    src_connectons.push_back(new Connecton(this, network->nodeons[node_number], network, false));
  }
}

void Nodeon::remove_random_connecton()
{
  unsigned int csz = src_connectons.size();

  if (csz > 0) {
    network->mu.reset_ud(0, csz);
    unsigned int connecton_number = network->mu.get_ud();
    src_connectons.at(connecton_number)->self_destruct();
  }
}

void Nodeon::node_mutate()
{
  // Reset for type change
  network->mu.reset_nd(ntype, 0.2);
  ntype += network->mu.get_nd();
  // Renormalization
  if (ntype > 2) ntype = 2;
  if (ntype < -2) ntype = -2;

  if (ntype != 0) {
    network->mu.reset_nd(number, 0.4);
    number += network->mu.get_nd();
  }

  unsigned int csz = src_connectons.size();
  // Reset for connecton drift
  network->mu.reset_nd(csz, 0.5);
  int connecton_drift = network->mu.get_nd();
	// Normalize
	if (connecton_drift > 5)
		connecton_drift = 5;
	if (connecton_drift < -5)
		connecton_drift = -5;

	connecton_drift = (csz + connecton_drift > 0) ? connecton_drift : -csz;

  // Add/remove connectons until satisfied
  while (csz + connecton_drift != src_connectons.size()) {
    if (csz + connecton_drift - src_connectons.size() > 0)
      add_connecton_with_random_nodes();
    else if (csz + connecton_drift - src_connectons.size() < 0)
      remove_random_connecton();
  }
}

void Nodeon::lf(double t)
{
  m_activation = erf(npi * m_inp);

  m_spike_happened = false;
  m_inp = 0;

  if (m_activation > 0.5) {
    if (ntype == INP_NODE) {
      if (number == network->c_input())
        m_activation = 1.0;
      else
        m_activation = 0.0;
    }
    else if (ntype == OUT_NODE) {
      network->c_output(number);
    }
    else if (ntype == INC_NODE) {
      ++(network->global_i);
    }
    else if (ntype == DEC_NODE) {
      --(network->global_i);
    }
  }

  if (m_activation > 0.5) {
    m_llft = t;
    m_spike_happened = true;
  }

  unsigned int csz = src_connectons.size();
  for (unsigned int i = 0; i < csz; ++i) {
    src_connectons.at(i)->transmit();
  }

  csz = dst_connectons.size();
  for (unsigned int i = 0; i < csz; ++i) {
    dst_connectons.at(i)->stdp();
  }
}
