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
    double w;
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

	int neur_per_proc = ceil((double)(neur.size())/(double)(n_proc));
	int syn_per_proc = ceil((double)(syn.size())/(double)(n_proc));
	int neur_offset = world_rank * neur_per_proc;
	int syn_offset = world_rank * syn_per_proc;

	for(int i = 0; i < syn_per_proc; i++) {
	    (*syn.at(i+syn_offset)).transmit();
	}

	for(int i = 0; i < neur_per_proc; i++) {
	    (*neur.at(i+neur_offset)).update();
	}
    }
};
