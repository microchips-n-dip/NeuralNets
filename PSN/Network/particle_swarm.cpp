#include "../psn.h"

void ParticleSwarm::path_reset()
{
  std::vector<NetworkConfiguration>::iterator net_it;
  for (net_it = paths.begin(); net_it < paths.end(); ++net_it) {
    *net_it = c_net;
  }
}

void ParticleSwarm::path_branch()
{
  std::vector<NetworkConfiguration>::iterator net_it;
  for (net_it = paths.begin(); net_it < paths.end(); ++net_it) {
    net_permute(*net_it);
    Network* net = new Network(*net_it);
    Network* optnet = new Network(c_net);

    net->run(32);
    optnet->run(32);

    if (net->fitness() >= optnet->fitness()) {
      c_net = *net_it;
    }

    delete net;
    delete optnet;
  }
}

void ParticleSwarm::init()
{
  n_paths = 20;
  for (unsigned int i = 0; i < n_paths; ++i) {
    paths.push_back(NetworkConfiguration());
  }
  net_permute(c_net);
}

ParticleSwarm::ParticleSwarm()
{
  init();
}
