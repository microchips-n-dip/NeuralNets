#ifndef EVN_CONNECTON_H
#define EVN_CONNECTON_H

extern const double w_A_plus;
extern const double w_A_minus;
extern const double w_T_plus;
extern const double w_T_minus;
extern const double c_tau;

class Connecton
{
 public:
  Nodeon* src;
  Nodeon* dst;

  unsigned int loc_in_src;
  unsigned int loc_in_dst;

  double weight;
  bool pending;

  double c; // Eligibility

  Network* network;



  Connecton(Nodeon* _src, Nodeon* _dst, Network* _network, bool need_set_src = true);

  void self_destruct();

  void transmit();

  void stdp();
};

#endif
