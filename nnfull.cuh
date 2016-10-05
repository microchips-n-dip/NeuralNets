// The neuron classes
class Neuron {
  public:
    double nv = 0.0; // Value of neuron
    double nvt = 0.0; // Temporary value of synaptic input
    
    virtual void update() = 0; // Empty function, defined in other neuron classes
};

class NeuronDecay: public Neuron {
  public:
    double baseline; // Baseline value of neuron
    double decay; // Rate of decay towards baseline
    
    void update() // Defining the update rule
    {
        if(fabs(nv-baseline) < decay) nv = baseline; // Overshoot compensation
        else if(nv > baseline) nv -= decay; // Decay towards baseline
        else if(nv < baseline) nv += decay; // Decay towards baseline
        
        nv += nvt; // Incorporate temp value
        nvt = 0.0; // Reset temp value
    }
};


// Now for the synapses
class Synapse {
  public:
    double w; // Weight value of synapse
    Neuron* Source; // Pointer to source neuron of synapse
    Neuron* Target; // Pointer to target neuron of synapse
    
    void transmit() // Propagating the source neuron value through the synapse
    {
        (*Target).nvt += w * (*Source).nv; // Incrementing the target neuron by the product of the source value and the weight
    }
};


// And finally the network
class Network {
  public:
    Neuron** neur; // Pointer for the neuron array
    Neuron*** dev_neur; // Device copy of neur
    Synapse** syn; // Pointer for the synapse array
    Synapse*** dev_syn; // Device copy of syn
    
    unsigned int n_neur; // Number of neurons in the network
    unsigned int n_syn; // Number of synapses in the network
    // Note: I would use vectors, but I need to copy the arrays to the GPGPU, and I feel this would be a better way

    void addNeuron(Neuron* neuron)
    {
	Neuron** temp_neur = (Neuron**) malloc(n_neur * sizeof(Neuron*)); // Create temp to store current neurons
	for(int i = 0; i < n_neur; i++) temp_neur[i] = neur[i]; // Copy neurons to temp
	free(neur);

	neur = (Neuron**) malloc((n_neur + 1) * sizeof(Neuron*));
	for(int i = 0; i < n_neur; i++) neur[i] = temp_neur[i];
	neur[n_neur] = neuron;

	n_neur++;
    }
    
#if CUDA_SUPPORT == 1
    __global__ void cudaNeuron(Neuron ***neuron) // Use the GPU to update neurons
    {
        int n = threadIdx.x + (blockIdx.x * blockDim.x); // Thread index (neuron number)
        (*((*neuron)[n])).update(); // Update the neuron at the thread index
    }
    
    __global__ void cudaSynapse(Synapse ***synapse) // Use the GPU to update synapses
    {
        int n = threadIdx.x + (blockIdx.x * blockDim.x); // Thread index (synapse number)
        (*((*synapse)[n])).transmit(); // Update the synapse at the thread index
    }
    
    void propagate()
    {
        cudaNeuron<<<>>>();
        cudaSynapse<<<>>>();
    }
#endif

#if CUDA_SUPPORT == 0
    void propagate() // Propagate data through the network
    {
        for(int n = 0; n < n_syn; n++) { // Iterate over all synapses
            (*(syn[n])).transmit(); // Update the synapse for this iteration
        }
        
        for(int n = 0; n < n_neur; n++) { // Iterate over all neurons
            (*(neur[n])).update(); // Update the neuron for this iteration
        }
    }
#endif
};
