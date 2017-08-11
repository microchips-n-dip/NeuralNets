#include "evn.h"
#include "sort.h"
#include <iostream>
#include <stdio.h>

int main(void)
{
  printf("Size of Nodeon: %d\n", sizeof(Nodeon));
  printf("Size of Connecton: %d\n", sizeof(Connecton));

  static const unsigned int NumNets = 100;
  std::vector<Network*> networks;
  for (unsigned int i = 0; i < NumNets; ++i) {
    networks.push_back(new Network());
  }

  // Sort, kill, reproduce and mutate
  while (1) {
    unsigned int n_generations;
    std::cout << "Number of generations to iterate:> ";
    std::cin >> n_generations;

    for (unsigned int i = 0; i < n_generations; ++i) {
      for (unsigned int j = 0; j < NumNets / 2; ++j)
        networks.at(j)->run(1);
      sort(networks);
      for (unsigned int j = 0; j < NumNets / 2; ++j)
        networks.at(j) = networks.at(j + NumNets / 2);
      for (unsigned int j = 0; j < NumNets; ++j)
        networks.at(j)->mutate();

      double avg_connectons = 0;
      for (unsigned int i = 0; i < NumNets; ++i)
        avg_connectons += networks.at(i)->connectons.size();
      printf("Average of %f connectons per network\n", avg_connectons / NumNets);
    }

    for (unsigned int j = 0; j < NumNets / 2; ++j)
      networks.at(j)->run(1);
    sort(networks);
    printf("Best fitness: %.32f\n", networks.at(NumNets - 1)->net_fitness());
    printf("Best cost: %.32f\n", networks.at(NumNets - 1)->net_cost());
    printf("Best network has %d nodeons and %d connectons\n", networks.at(NumNets - 1)->nodeons.size(), networks.at(NumNets - 1)->connectons.size());
  }
}
