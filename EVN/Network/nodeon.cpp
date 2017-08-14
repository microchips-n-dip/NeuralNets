#include "../evn.h"

const double pi = acos(-1);
const double npi = std::sqrt(0.25 * pi);

// Nodeon constructor
Nodeon::Nodeon(Network* _network)
{
  // Set the internal pointer to the network
  network = _network;

  // Default type of nodeon
  ntype = 0;

  m_inp = 0;
  m_activation = 0;
  m_llft = 0;
}

// Remove all attached connectons
void Nodeon::self_destruct()
{
  while (src_connectons.size() > 0)
    (*src_connectons.begin())->self_destruct();
  while (dst_connectons.size() > 0)
    (*dst_connectons.begin())->self_destruct();
}

// Make a new connecton connected to a random node
void Nodeon::add_connecton_with_random_nodes()
{
  // Get sizes
  unsigned int nsz = network->nodeons.size();
  bool no_duplicates = true;

  if (nsz > 0) {
    // Reset for destination nodeon number
    network->mu.reset_ud(0, nsz);
    std::vector<Nodeon*>::iterator dst_node;
    std::vector<Connecton*>::iterator it;

    dst_node = network->nodeons.begin() + network->mu.get_ud();

    // Check for duplicates
    for (it = src_connectons.begin(); it < src_connectons.end(); ++it) {
      if ((*it)->dst == *dst_node) {
        no_duplicates = false;
        break;
      }
    }

    // If no duplicates are found, create the new connecton
    if (no_duplicates)
      src_connectons.push_back(new Connecton(this, *dst_node, network, false));
  }
}

// Remove a random connecton
void Nodeon::remove_random_connecton()
{
  unsigned int csz = src_connectons.size();

  if (csz > 0) {
    network->mu.reset_ud(0, csz);
    unsigned int connecton_number = network->mu.get_ud();
    src_connectons.at(connecton_number)->self_destruct();
  }
}

// Mutate the node,
// add or remove connectons given by connecton_drift
void Nodeon::node_mutate()
{
  // Mutate the nodeon type
  // Reset for type change
  network->mu.reset_nd(ntype, 0.2);
  ntype += network->mu.get_nd();
  // Renormalization
  if (ntype > 2) ntype = 2;
  if (ntype < -2) ntype = -2;

  // Mutate the number
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

  // Make sure there is no underflow error
  connecton_drift = (int(csz) > -connecton_drift) ? connecton_drift : 1 - csz;

  // Add/remove connectons until satisfied
  while (csz + connecton_drift != src_connectons.size()) {
    if (csz + connecton_drift > src_connectons.size())
      add_connecton_with_random_nodes();
    else if (csz + connecton_drift < src_connectons.size())
      remove_random_connecton();
  }
}

// Nodeon activation function
void Nodeon::lf(double t)
{
  // Compute the activation as the sigmoid of the input
  m_activation = erf(npi * m_inp);

  // Reset some internal variables
  m_spike_happened = false;
  m_inp = 0;

  // Do type dependent activation jobs
  if (m_activation > 0.5) {
    // Get an input
    if (ntype == INP_NODE) {
      if (number == network->c_input())
        m_activation = 1.0;
      else
        m_activation = 0.0;
    }
    // Output a number
    else if (ntype == OUT_NODE) {
      network->c_output(number);
    }
    // Increment global_i
    else if (ntype == INC_NODE) {
      ++(network->global_i);
    }
    // Decrement global_i
    else if (ntype == DEC_NODE) {
      --(network->global_i);
    }
  }

  // Log last firing time and set spike boolean
  if (m_activation > 0.5) {
    m_llft = t;
    m_spike_happened = true;
  }

  // Transmit the activation across all connectons with this nodeon as a source
  unsigned int csz = src_connectons.size();
  for (unsigned int i = 0; i < csz; ++i) {
    src_connectons.at(i)->transmit();
  }

  // Do STDP modulation on all connectons with this nodeon as a destination
  csz = dst_connectons.size();
  for (unsigned int i = 0; i < csz; ++i) {
    dst_connectons.at(i)->stdp();
  }
}
