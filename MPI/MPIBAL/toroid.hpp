#ifdef env_mpi

class Toroid
{
  public:
    int nprocs;
    int rank;

    int dx, dz;
    int xlocal;
    int zlocal;

    vector<int> friends;
  
    Toroid(Parallel &mpi)
    {
        nprocs = mpi.nprocs;
	rank = mpi.rank;
        
        dz = sqrt(nprocs);
        dx = ceil(nprocs / dz) + (nprocs % dz);

	xlocal = floor(rank / dx);
	zlocal = rank % dx;

	
    }
};

#endif
