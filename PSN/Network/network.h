#ifndef PSN_NETWORK_H
#define PSN_NETWORK_H

extern const unsigned int n_samples;
extern const unsigned int NumAllowedCycles;

class Network
{
  public:

  NetworkConfiguration* ncfg;

  std::vector<Nodeon*> nodeons;

  double last_cost;
  double last_fitness;

  double saved_cost;
  bool saved_cost_valid;
  double saved_fitness;
  bool saved_fitness_valid;

  double dopamine;
  double network_time;

  unsigned int global_i;
  std::vector<unsigned int> m_input;
  unsigned int global_j;
  std::vector<unsigned int> m_output;
  std::vector<unsigned int> t_output;


  Network(NetworkConfiguration& ncfg);
  ~Network();

  unsigned int c_input(unsigned int idx);
  void c_output(unsigned int data);

  void net_run(double time);

  double cost();

  double fitness();

  void run(unsigned int cycles);
};

#endif

