#ifdef env_mpi

#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include "mpinet.hpp"

#include <iostream>
using namespace std;

int main(void)
{
    MPI_Init(NULL, NULL);

    int w_rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &w_rank);
    MPI_Comm_size(MPI_COMM_WORLD, &n_procs);

    Network procnet;
    procnet.addNeuron(createNeuron(new NeuronDecay(0.1, 0.0)));

//    for(int i = 0; i < 7; i++) procnet.addNeuron(createNeuron(new NeuronDecay(0.1, 0.0)));
//    printf("Process %i has %i neurons\n", w_rank, procnet.proc_neur.size());

    MPI_Finalize();
}

#endif
