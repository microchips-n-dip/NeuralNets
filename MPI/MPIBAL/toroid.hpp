#ifdef env_mpi

class Toroid
{
  public:
    int nprocs;
    int dx, dz;
  
    Toroid(Parallel &mpi)
    {
        nprocs = mpi.nprocs;
        
        dz = sqrt(nprocs);
        dx = ceil(nprocs / dz) + (nprocs % dz);
    }
};

#endif
