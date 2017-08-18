#ifndef PSN_PARTICLE_SWARM_H
#define PSN_PARTICLE_SWARM_H

class ParticleSwarm
{
  public:

  NetworkConfiguration c_net;
  unsigned int n_paths;
  std::vector<NetworkConfiguration> paths;

  void path_reset();
  void path_branch();
  void init();

  ParticleSwarm();
};

#endif

