#ifndef EVN_NETWORK_H
#define EVN_NETWORK_H

extern const unsigned int n_samples;
extern const unsigned int NetNumAllowedCycles;
extern const unsigned int EvNumAllowedCycles;

class Network
{
 public:
  Mutator<double> mu;
  
  std::vector<Nodeon*> nodeons;
  std::vector<Connecton*> connectons;
  
  unsigned int global_i;
  unsigned int global_j;
  
  std::vector<unsigned int> m_input;
  std::vector<unsigned int> m_output;
  
  double network_time;
  double m_net_last_cost;
  double m_ev_last_cost;
  double dopamine;
	
	double fit_saved;
	bool fit_saved_valid;
	double cost_saved;
	bool cost_saved_valid;
  
  
  unsigned int c_input();
  
  void c_output(unsigned int number);
  
  void remove_random_nodeon();
  
  void mutate();
  
  void net_run(double time);
  
  // Network cost function
  double net_cost();
  
  // Network fitness function
  double net_fitness();
  
  void run(unsigned int cycles);
	
  Network();
};

#endif
