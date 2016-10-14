#ifdef env_mpi

#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

class Node
{
  public:
    int nprocs;
    int rank;

    vector<int> data;

    Node(Parallel &mpi)
    {
	nprocs = mpi.nprocs;
	rank = mpi.rank;
    }

    void distribute()
    {
	int *send_data = (int *) calloc(diff/(nprocs-1), sizeof(int));

	for (int i = 0; i < nprocs; i++) if (i != rank)
	{
	    
	}
    }
};
