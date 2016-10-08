#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include "mpinet.hpp"

int main(void)
{
    MPI_Init(NULL, NULL);
    int rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    if(rank == 0) {
	Network network;
	for(int i = 0; i < 1024; i++) network.neur.push_back(new NeuronDecay);
	for(int i = 0; i < 1024; i++) {
	    for(int j = 0; j < 1024; j++) {
		network.syn.push_back(new Synapse(1.0, network.neur.at(i), network.neur.at(j)));
	    }
	}
	network.propagate();
    }
    MPI_Finalize();
}
