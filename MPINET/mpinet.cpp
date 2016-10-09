#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include "mpinet.hpp"

#include <iostream>
using namespace std;

int main(void)
{
    MPI_Init(NULL, NULL);
    int rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    int n_neur = 5;

    Network network;
    if(rank == 0) {
	for(int i = 0; i < n_neur; i++) network.neur.push_back(new NeuronDecay(0.1, 0.0));
	for(int i = 0; i < n_neur; i++) {
	    for(int j = 0; j < n_neur; j++) {
		network.syn.push_back(new Synapse(1.0, network.neur.at(i), network.neur.at(j)));
	    }
	}
	for(int i = 0; i < n_neur; i++) (*network.neur.at(i)).nv = 0.1;
    }

    for(int i = 0; i < 1; i++) network.propagate();

//    if(rank == 0) for(int i = 0; i < n_neur; i++) cout << (*network.neur.at(i)).nv << endl;

    MPI_Finalize();
}
