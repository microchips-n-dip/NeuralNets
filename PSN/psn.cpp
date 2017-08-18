#include "psn.h"
#include <iostream>

int main(void)
{
  ParticleSwarm ps;
  ps.init();

  while (true) {
    unsigned int n_gens;
    std::cout << "Number of generations:> ";
    std::cin >> n_gens;

    for (unsigned int i = 0; i < n_gens; ++i) {
      ps.path_branch();
    }

    printf("Optimal network contains %d nodesons and %d connectons\n", ps.c_net->nodeons.size(), ps.c_net->connectons.size());
  }
}
