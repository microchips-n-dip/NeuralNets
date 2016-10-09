#include <cmath>
#include <vector>
using namespace std;

class Neuron {
  public:
    double nv = 0.0;
    double nvt = 0.0;

    virtual void update() = 0;
};

class NeuronDecay: public Neuron {
  public:
    double decay = 0.0;
    double baseline = 0.0;

    NeuronDecay(double d, double b)
    {
	decay = d;
	baseline = b;
    }

    void update()
    {
	if(nv > baseline) nv -= decay;
	else if(nv < baseline) nv += decay;
	if(fabs(nv-baseline) < decay) nv = baseline;

	nv += nvt;
	nvt = 0;
    }
};


// Synapses
class Synapse {
  public:
    double w = 0.0;
    Neuron* Source;
    Neuron* Target;

    Synapse(double new_w, Neuron* newSource, Neuron* newTarget)
    {
	w = new_w;
	Source = newSource;
	Target = newTarget;
    }

    void transmit()
    {
	(*Target).nvt += w * (*Source).nv;
    }
};


// Network
class Network {
  public:
    vector<Neuron*> neur;
    vector<Synapse*> syn;

    void propagate()
    {
	int n_proc, world_rank;
	MPI_Comm_size(MPI_COMM_WORLD, &n_proc);
	MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

	int *neur_per_proc = (int*) malloc(n_proc*sizeof(int));
	neur_per_proc[world_rank] = floor((double)(neur.size())/(double)(n_proc));
	if(world_rank < (neur.size() % neur_per_proc[world_rank])) neur_per_proc[world_rank] += 1;

	int *syn_per_proc = (int*) malloc(n_proc*sizeof(int));
	syn_per_proc[world_rank] = floor((double)(syn.size())/(double)(n_proc));
	if(world_rank < (syn.size() % syn_per_proc[world_rank])) syn_per_proc[world_rank] += 1;

	int neur_offset = 0;
	int syn_offset = 0;
	for(int i = 0; i < world_rank; i++) {
	    neur_offset += neur_per_proc[i];
	    syn_offset += neur_per_proc[i];
	}

//	if(world_rank == 0) {
	printf("Neuron updates per process: %i\n", neur_per_proc[world_rank]);
	printf("Synapse updates per process: %i\n", syn_per_proc[world_rank]);
	printf("Number of processes: %i\n", n_proc);
//	}

	for(int i = 0; i < syn_per_proc[world_rank]; i++) {
	    (*syn.at(i+syn_offset)).transmit();
	}

	for(int i = 0; i < neur_per_proc[world_rank]; i++) {
	    (*neur.at(i+neur_offset)).update();
	}

	free(neur_per_proc);
	free(syn_per_proc);
    }
};
