#include <cmath>
#include <vector>
using namespace std;


int n_neurons = 0;
int n_synapses = 0;
int n_procs = 1;


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


class Network {
  public:
    vector<Neuron*> proc_neur;
    vector<Synapse*> proc_syn;

    void addNeuron(Neuron *neuron)
    {
	// The owner process will be the modulus of the number of neurons and the number of processes
	int owner = n_neurons % n_procs;

	int w_rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &w_rank);
	if(w_rank == owner) proc_neur.push_back(neuron);

	n_neurons++;
    }

    void addSynapse(Synapse *synapse)
    {
	int owner = n_synapses % n_procs;

	int w_rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &w_rank);
	if(w_rank == owner) proc_syn.push_back(synapse);

	n_synapses++;
    }
};
