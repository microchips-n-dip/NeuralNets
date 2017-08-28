#include "../psn.h"

const double pi = acos(-1);
const double npi = std::sqrt(0.25 * pi);

// Nodeon constructor
Nodeon::Nodeon()
{
  inp = 0;
  spike = false;
  respike = true;
  m_llft = 0;

  Mutator<double> mu;

  a = 0.2;
  b = 0.02;

  double r = mu.get_ud(0.0, 1.0);
  c = 15 * r * r - 65;
  d = 8 - 6 * r * r;
}

// Nodeon activation function
void Nodeon::lf(double t)
{
  if (respike) {
    double dv = (0.04 * v + 5) * v + 140 - u + inp;
    double du = a * (b * v - u);
    v += 0.1 * dv;
    u += 0.1 * du;

    spike = false;

    if (v >= 30) {
      u += d;
      v = c;

      spike = true;
      m_llft = t;
    }
  }

  else {
    respike = true;
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

  spike = false;
  inp = 0;
}

void construct_nodeon(Network* net)
{
  Nodeon* n = new Nodeon();

  net->nodeons.push_back(n);
  n->loc_in_net = net->nodeons.size() - 1;
  n->network = net;
}

void destroy_nodeon(Nodeon* n)
{
  Network* net = n->network;

  Nodeon* end;

  while (!n->src_connectons.empty()) {
    destroy_connecton(n->src_connectons.front());
  }

  while (!n->dst_connectons.empty()) {
    destroy_connecton(n->dst_connectons.front());
  }

  end = net->nodeons.back();
  end->loc_in_net = n->loc_in_net;
  net->nodeons.at(n->loc_in_net) = end;
  net->nodeons.pop_back();

  delete n;
}
