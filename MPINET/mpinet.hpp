#include <cmath>
#include <vector>
using namespace std;

<<<<<<< HEAD

int n_neurons = 0;
int n_synapses = 0;
int n_procs = 1;
=======
// Some global variables
// These will be for deciding process ownership
int proc_neurons;
int proc_synapses;
int n_procs;
>>>>>>> 627a114578b6bce9569b897b9d782d1b512837b9


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
	// Decay in the direction of the baseline
	if(nv > baseline) nv -= decay;
	else if(nv < baseline) nv += decay;
	if(fabs(nv - baseline) < decay) nv = decay; // Overshoot compensation

	// Adding the input, then resetting
	nv += nvt;
	nvt = 0.0;
    }
};

struct NeuronLocale {
  public:
    int my_owner;
    Neuron *neuron;
};

NeuronLocale *createNeuron(Neuron *neuron)
{
    NeuronLocale *neuronLocale;

    int n_neurons;
    MPI_Allreduce(&proc_neurons, &n_neurons, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD);
    int owner = n_neurons % n_procs;
    proc_neurons++;

    int w_rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &w_rank);

    (*neuronLocale).my_owner = owner;
    (*neuronLocale).neuron = neuron;

    if (w_rank == owner) {
	return neuronLocale;
    } else {
	return NULL;
    }
}


class Synapse {
  public:
    double w = 0.0;
    NeuronLocale *Source;
    NeuronLocale *Target;
};

struct SynapseLocale {
  public:
    int my_owner;
    Synapse *synapse;
};

SynapseLocale *createSynapse(Synapse *synapse)
{
    SynapseLocale *synapseLocale;

    int n_synapses;
    MPI_Allreduce(&proc_synapses, &n_synapses, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD);
    int owner = n_synapses % n_procs;
    proc_synapses++;

    int w_rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &w_rank);

    (*synapseLocale).my_owner = owner;
    (*synapseLocale).synapse = synapse;

    if (w_rank == owner) {
	return synapseLocale;
    } else {
	return NULL;
    }
}


class Network {
  public:
    vector<Neuron*> proc_neur;
    vector<Synapse*> proc_syn;

<<<<<<< HEAD
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
=======
    void addNeuron(NeuronLocale *neuronLocale) // Determining an owner and assigning the neuron
    {
	int owner = (*neuronLocale).my_owner;

	int w_rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &w_rank);

	if (w_rank == owner) {
	    Neuron *neuron = (*neuronLocale).neuron;
	    neur.push_back(neuron);
	}
    }

    void addSynapse(SynapseLocale *synapseLocale) // Determining an owner and assigning the synapse
    {
	int owner = (*synapseLocale).my_owner;

	int w_rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &w_rank);

	if (w_rank == owner) {
	    Synapse *synapse = (*synapseLocale).synapse;
	    syn.push_back(synapse);
	}
>>>>>>> 627a114578b6bce9569b897b9d782d1b512837b9
    }
};
