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
  path_reset();

  std::vector<NetworkConfiguration>::iterator net_it;
  for (net_it = paths.begin(); net_it < paths.end(); ++net_it) {
    net_permute(*net_it);
    Network* net = new Network(*net_it);
    Network* optnet = new Network(c_net);

    net->net_run(2048);
    optnet->net_run(2048);

    if (net->fitness() > optnet->fitness()) {
      c_net = *net_it;
    }

    delete net;
    delete optnet;
  }

  fs.open("./extract_cnet.txt", std::fstream::in | std::fstream::out | std::fstream::trunc);

  for (unsigned int i = 0; i < c_net.cc.size(); ++i) {
    unsigned int src = c_net.cc.at(i).src;
    unsigned int dst = c_net.cc.at(i).dst;
    double weight = c_net.cc.at(i).weight;

    fs << "(" << src << ", " << dst << "): " << weight << std::endl;
  }

  fs.close();
  printf("Extracted optimal network\n");
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
