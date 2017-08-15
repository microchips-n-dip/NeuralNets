#ifndef PSN_PARTICLE_SWARM_H
#define PSN_PARTICLE_SWARM_H

class ParticleSwarm
{
  public:

  Mutator<double> mu;

  Network* c_net;
  unsigned int n_paths;
  std::vector<Network*> paths;

  void path_reset();
  void path_branch();
  void init();

  ParticleSwarm();
};

#endif

