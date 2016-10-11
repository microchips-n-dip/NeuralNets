#include <cmath>
#include <vector>
using namespace std;


// Some global variables
// These will be for deciding process ownership
int proc_neurons = 0;
int proc_synapses = 0;
int n_procs;


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
	// Decay in the direction of the baseline
	if(nv > baseline) nv -= decay;
	else if(nv < baseline) nv += decay;
	if(fabs(nv - baseline) < decay) nv = decay; // Overshoot compensation

	// Adding the input, then resetting
	nv += nvt;
	nvt = 0.0;
    }
};

class NeuronLocale {
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

class SynapseLocale {
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

    void addNeuron(NeuronLocale *neuronLocale) // Determining an owner and assigning the neuron
    {
	int owner = (*neuronLocale).my_owner;

	int w_rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &w_rank);

	if (w_rank == owner) {
	    printf("This neuron belongs to process %i\n", w_rank);

	    Neuron *neuron = (*neuronLocale).neuron;
//	    proc_neur.resize(proc_neur.size() + 1);
//	    proc_neur.at(proc_neur.size() - 1) = neuron;
	}
    }

    void addSynapse(SynapseLocale *synapseLocale) // Determining an owner and assigning the synapse
    {
	int owner = (*synapseLocale).my_owner;

	int w_rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &w_rank);

	if (w_rank == owner) {
	    Synapse *synapse = (*synapseLocale).synapse;
	    proc_syn.push_back(synapse);
	}
    }
};
