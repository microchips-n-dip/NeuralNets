#include "../psn.h"

const double w_A_plus = 0.1;
const double w_A_minus = 0.15;
const double w_T_plus = 0.02;
const double w_T_minus = 0.11;
const double c_tau = 0.2;

// Connecton constructor
Connecton::Connecton()
{
  pending = false;
  c = 0;
}

// Transmit function, transmit from source to destination and apply weight
void Connecton::transmit()
{
  if (pending) dst->inp += weight;
  pending = src->spike;
}

// STDP modulation for learning
void Connecton::stdp()
{
  // Calculate the difference in firing times
  double dt = dst->m_llft - src->m_llft;

  // Modify the eligibility trace
  double dc;
  if (dt >= 0)
    dc = w_A_plus * exp(-dt / w_T_plus);
  else
    dc = w_A_minus * exp(dt / w_T_minus);

  dc -= c / c_tau;
  c += dc;

  // Modify the weight according to the dopamine level and eligibility trace
  weight += network->dopamine * c;
}

void construct_connecton(Nodeon* src, Nodeon* dst, Network* net)
{
  Connecton* c = new Connecton();

  c->src = src;
  c->dst = dst;
  c->network = net;

  src->src_connectons.push_back(c);
  dst->dst_connectons.push_back(c);

  c->loc_in_src = src->src_connectons.size() - 1;
  c->loc_in_dst = dst->dst_connectons.size() - 1;
}

void destroy_connecton(Connecton* c)
{
  Nodeon* src = c->src;
  Nodeon* dst = c->dst;

  Connecton* end;

  end = src->src_connectons.back();
  end->loc_in_src = c->loc_in_src;
  src->src_connectons.at(c->loc_in_src) = end;
  src->src_connectons.pop_back();

  end = dst->dst_connectons.back();
  end->loc_in_dst = c->loc_in_dst;
  dst->dst_connectons.at(c->loc_in_dst) = end;
  dst->dst_connectons.pop_back();

  delete c;
}
