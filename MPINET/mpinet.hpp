#include <cmath>
#include <vector>
using namespace std;

class Neuron {
  public:
    double nv = 0.0; // Value of the neuron
    double nvt = 0.0; // Temporary value of the input

    virtual void update() = 0; // Empty function to be defined later
};

class NeuronDecay: public Neuron {
  public:
    double decay = 0.0; // Decay rate towards the baseline
    double baseline = 0.0; // The baseline

    NeuronDecay(double d, double b) // The constructor for setting values
    {
	decay = d; // Set the decay rate
	baseline = b; // Set the baseline
    }

    void update() // Defined update funtion
    {
	if(nv > baseline) nv -= decay; // Greater than case
	else if(nv < baseline) nv += decay; // Less than case
	if(fabs(nv-baseline) < decay) nv = baseline; // Overshoot compensation

	nv += nvt; // Add the temporary input value
	nvt = 0; // Reset the temporary input value
    }
};


// Synapses
class Synapse {
  public:
    double w = 0.0; // Weight on the synapse
    Neuron* Source; // Source neuron
    Neuron* Target; // Target neuron

    Synapse(double new_w, Neuron* newSource, Neuron* newTarget) // Constuctor for configuring the synapse
    {
	w = new_w; // Set the weight
	Source = newSource; // Set the source neuron
	Target = newTarget; // Set the target neuron
    }

    void transmit() // Propagating values across the synapse
    {
	(*Target).nvt += w * (*Source).nv; // Increment the target input
    }
};


// Network
class Network {
  public:
    vector<Neuron*> neur; // Neuron vector
    vector<Synapse*> syn; // Synapse vector

    void propagate() // Propagating the network
    {
	int n_proc, world_rank; // MPI variables
	MPI_Comm_size(MPI_COMM_WORLD, &n_proc); // Get the number of processes
	MPI_Comm_rank(MPI_COMM_WORLD, &world_rank); // Get the world rank of this process

	MPI_Barrier(MPI_COMM_WORLD); // Sync all processes

	int *neur_per_proc; // Pointer to the array storing the number of neurons per process
	if(world_rank == 0) neur_per_proc = (int*) malloc(n_proc*sizeof(int)); // Allocate on the root
	MPI_Bcast(neur_per_proc, n_proc, MPI_INT, 0, MPI_COMM_WORLD); // Broadcast the array to the other processes

	neur_per_proc[world_rank] = floor((double)(neur.size())/(double)(n_proc)); // Set the initial value for the number of neurons per process
	if(world_rank < (neur.size() % neur_per_proc[world_rank])) neur_per_proc[world_rank] += 1; // Add the remainders

	MPI_Barrier(MPI_COMM_WORLD); // Sync all processes

	int *syn_per_proc; // Pointer to the array storing the number of synapses per process
	if(world_rank == 0) syn_per_proc = (int*) malloc(n_proc*sizeof(int)); // Allocate on the root
	MPI_Bcast(syn_per_proc, n_proc, MPI_INT, 0, MPI_COMM_WORLD); // Broadcast the array to the other processes

	syn_per_proc[world_rank] = floor((double)(syn.size())/(double)(n_proc)); // Set the initial value for the numver of synapses per process
	if(world_rank < (syn.size() % syn_per_proc[world_rank])) syn_per_proc[world_rank] += 1; // Add the remainders
    }
};
