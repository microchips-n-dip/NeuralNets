#ifdef env_mpi

class Parallel
{
  public:
    int rank;
    int nprocs;
    
    Parallel()
    {
        MPI_Comm_rank(MPI_COMM_WORLD,&rank);
        MPI_Comm_size(MPI_COMM_WORLD,&nprocs);
    }
    
    void say_hello()
    {
        printf("rank %i: hello!\n",rank);
    }
};


#endif
