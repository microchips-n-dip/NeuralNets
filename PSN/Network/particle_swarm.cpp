#include "../psn.h"

void ParticleSwarm::path_reset()
{
  std::vector<Network*>::iterator net_it;
  for (net_it = paths.begin(); net_it < paths.end(); ++net_it) {
    (*net_it)->net_copy(c_net);
  }
}

void ParticleSwarm::path_branch()
{
  std::vector<Network*>::iterator net_it;
  for (net_it = paths.begin(); net_it < paths.end(); ++net_it) {
    (*net_it)->mutate();
  }

  for (net_it = paths.begin(); net_it < paths.end(); ++net_it) {
    if ((*net_it)->net_fitness() >= c_net->net_fitness()) {
      c_net->net_copy(*net_it);
    }
  }
}

void ParticleSwarm::init()
{
  n_paths = 20;
  for (unsigned int i = 0; i < n_paths; ++i) {
    paths.push_back(new Network());
  }
}

ParticleSwarm::ParticleSwarm()
{
  init();
}
