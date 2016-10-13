#ifdef env_mpi

#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <vector>
#include <iostream>

#include "parallel.hpp"

double log2(double a)
{
    return log(a) / log(2);
}

void tree(Parallel &mpi, int idata)
{
    int *data;
    if (mpi.rank == 0) data = &idata;
    
    for (int layer = 0; layer <= log2(nprocs); layer++)
    {
        if (mpi.rank < pow(2, layer))
        {
            recv = mpi.rank + pow(2, layer-1);
            MPI_Send(data, 1, MPI_INT, recv, 0, MPI_COMM_WORLD);
        }
        
        else if (mpi.rank >= pow(2, layer) && mpi.rank < pow(2, layer + 1))
        {
            send = mpi.rank - pow(2, layer);
            MPI_Recv(data, 1, MPI_INT, send, 0, MPI_COMM_WORLD);
            printf("Process %i just got the message\n", mpi.rank);
            printf("Received value of %i\n", *data);
        }
    }
}

int main(void)
{
    MPI_Init(NULL, NULL);
    Parallel mpi();
    
    int number;
    
    if (mpi.rank == 0)
    {
        number = 3;
    }
    
    // Now for the tree
    tree(mpi, number, 0);

    MPI_Finalize();
}

#endif
