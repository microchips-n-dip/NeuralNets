#include "psn.h"
#include <iostream>

const unsigned int n_inputs = 8;
const unsigned int n_outputs = 8;

int main(void)
{
  ParticleSwarm ps;

  while (true) {
    unsigned int n_gens;
    std::cout << "Number of generations:> ";
    std::cin >> n_gens;

    for (unsigned int i = 0; i < n_gens; ++i) {
      ps.path_branch();
    }

    printf("Optimal network contains %d nodesons and %d connectons\n", ps.c_net.nc.size(), ps.c_net.cc.size());
  }
}
