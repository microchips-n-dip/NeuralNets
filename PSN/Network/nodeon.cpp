#include "../psn.h"

const double pi = acos(-1);
const double npi = std::sqrt(0.25 * pi);

// Nodeon constructor
Nodeon::Nodeon(Network* _network, std::vector<unsigned int>& ntypes)
{
  // Set the internal pointer to the network
  network = _network;

  loc_in_net = network->nodeons.size() - 1;

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

  std::vector<Nodeon*>::iterator node_it;
  node_it = network->nodeons.begin() + loc_in_net;
  network->nodeons.erase(node_it);

  delete this;
}

// Nodeon activation function
void Nodeon::lf(double t)
{
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
