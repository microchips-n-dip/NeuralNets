#ifndef EVN_NODEON_H
#define EVN_NODEON_H

extern const double pi;
extern const double npi;

enum {
  STD_NODE = 0,
  INP_NODE = -1,
  OUT_NODE = 1,
  INC_NODE = -2,
  DEC_NODE = 2
};

class Nodeon
{
 public:
  int ntype;
  
  std::vector<Connecton*> src_connectons;
  std::vector<Connecton*> dst_connectons;
  
  double m_inp;
  double m_activation;
  double m_llft;
  unsigned int number;
  bool m_spike_happened;
  
  Network* network;
  
  
  Nodeon(Network* _network);
  
  void self_destruct();
  
  void add_connecton_with_random_nodes();
  
  void remove_random_connecton();
  
  void node_mutate();
  
  void lf(double t);
};

#endif
