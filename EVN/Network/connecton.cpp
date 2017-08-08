#include "../evn.h"

const double w_A_plus = 0.1;
const double w_A_minus = 0.15;
const double w_T_plus = 0.02;
const double w_T_minus = 0.11;
const double c_tau = 0.2;

Connecton::Connecton(Nodeon* _src, Nodeon* _dst, Network* _network, bool need_set_src)
{
  src = _src;
  dst = _dst;

  network = _network;

  network->mu.reset_ud(-1.0, 1.0);
  weight = network->mu.get_ud();
  pending = 0;

  c = 0;

  loc_in_src = src->src_connectons.size();
  loc_in_dst = dst->dst_connectons.size();
  loc_in_net = network->connectons.size();

  if (need_set_src)
    src->src_connectons.push_back(this);
  else
    --loc_in_src;
  // We know that src has already added this
  dst->dst_connectons.push_back(this);
  network->connectons.push_back(this);

  //printf("Created new connecton\n");
}

void Connecton::self_destruct()
{
  src->src_connectons.at(loc_in_src) = *(src->src_connectons.end() - 1);
  src->src_connectons.pop_back();

  dst->dst_connectons.at(loc_in_dst) = *(dst->dst_connectons.end() - 1);
  dst->dst_connectons.pop_back();

  network->connectons.at(loc_in_net) = *(network->connectons.end() - 1);
  network->connectons.pop_back();
}

void Connecton::transmit()
{
  dst->m_inp += weight * pending;
  pending = src->m_activation;
}

void Connecton::stdp()
{
  double dt = dst->m_llft - src->m_llft;

  double dc;
  if (dt >= 0)
    dc = w_A_plus * exp(-dt / w_T_plus);
  else
    dc = w_A_minus * exp(dt / w_T_minus);

  dc -= c / c_tau;
  c += dc;
  weight += network->dopamine * c;
}
