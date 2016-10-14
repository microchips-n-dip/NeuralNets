#ifdef env_mpi

class Parallel
{
    int nprocs;
    int rank;

    Parallel()
    {
	MPI_Comm_size(MPI_COMM_WORLD, &nprocs);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    }
};

#endif
