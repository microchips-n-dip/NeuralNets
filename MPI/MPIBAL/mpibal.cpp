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
    Parallel mpi = Parallel();
    Toroid nt = Toroid(mpi);
  
    printf("Created a toroid of %i processes\n", mpi.nprocs);
    printf("dx = %i\n", nt.dx);
    printf("dz = %i\n", nt.dz);
}

#endif
