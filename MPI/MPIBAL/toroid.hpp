#ifdef env_mpi

class Toroid
{
  public:
    int nprocs;
    int dx, dz;

    int xlocal;
    int zlocal;
  
    Toroid(Parallel &mpi)
    {
        nprocs = mpi.nprocs;
        
        dz = sqrt(nprocs);
        dx = ceil(nprocs / dz) + (nprocs % dz);

	xlocal = floor(mpi.rank / dx);
	zlocal = mpi.rank % dx;
    }
};

#endif
