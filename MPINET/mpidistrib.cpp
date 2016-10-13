#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#include <vector>
#include <iostream>

#include "parallel.hpp"

int main(void)
{
    MPI_Init(NULL, NULL);
    Parallel mpi();
    
    int local_count;
    
    if (mpi.rank == 0)
    {
        local_count = 3;
    }
    
    else if (mpi.rank == 1)
    {
        local_count = 2;
    }
    
    else if (mpi.rank == 2)
    {
        local_count = 0;
    }
    
    else if (mpi.rank == 3)
    {
        local_count = 3;
    }
}
