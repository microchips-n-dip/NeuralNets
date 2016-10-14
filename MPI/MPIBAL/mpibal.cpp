#ifdef env_mpi

#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cmath>

#include "parallel.hpp"
#include "toroid.hpp"

int main(void)
{
    MPI_Init(NULL, NULL);
    Parallel mpi = Parallel();
    Toroid nt = Toroid(mpi);

    for (int i = 0; i < mpi.nprocs; i++) if (mpi.rank == i)
    printf("Process %i is at (%i, %i)\n", mpi.rank, nt.xlocal, nt.zlocal);

    MPI_Finalize();
}

#endif
