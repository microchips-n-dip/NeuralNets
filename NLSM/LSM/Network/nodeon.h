#ifndef EVN_NODEON_H
#define EVN_NODEON_H

extern const double pi;
extern const double npi;

class Nodeon
{
 public:
  std::vector<Connecton*> src_connectons;
  std::vector<Connecton*> dst_connectons;

  double a;
  double b;
  double c;
  double d;
  double u;
  double v;

  double inp;
  bool spike;
  bool respike;
  double m_llft;

  unsigned int loc_in_net;

  Network* network;


  Nodeon();

  void self_destruct();

  void lf(double t);
};

#endif
