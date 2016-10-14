#ifdef env_mpi

#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctime>

#include <vector>
#include <iostream>

#include "../parallel.hpp"

double log2(double a)
{
    return log(a) / log(2);
}

void tree(Parallel &mpi, int *data)
{
    int recv;
    int send;
    
    for (int layer = 0; layer < log2(mpi.nprocs); layer++)
    {
//	printf("Starting layer %i\n", layer);
        if (mpi.rank < pow(2, layer))
        {
            recv = mpi.rank + pow(2, layer);
	    if (recv < mpi.nprocs)
            MPI_Send(data, 1, MPI_INT, recv, 0, MPI_COMM_WORLD);
        }
        
        else if (mpi.rank >= pow(2, layer) && mpi.rank < pow(2, layer + 1))
        {
            send = mpi.rank - pow(2, layer);
            MPI_Recv(data, 1, MPI_INT, send, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            printf("Process %i received %i\n", mpi.rank, *data);
        }
    }
}

int main(void)
{
    MPI_Init(NULL, NULL);
    Parallel mpi = Parallel();
    
    int number;
    
    if (mpi.rank == 0)
    {
	std::cout << "Input a number to send around the network\n> ";
        std::cin >> number;
    }
    
    // Now for the tree
    clock_t start_time;
    if (mpi.rank == 0) start_time = clock();
    tree(mpi, &number);
    if (mpi.rank == 0) printf("Finished in %f seconds\n", (double)(clock() - start_time)/1000.0);

    MPI_Finalize();
}

#endif
