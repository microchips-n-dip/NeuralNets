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
    Neuron** dev_neur; // Device copy of neur
    Synapse** syn; // Pointer for the synapse array
    Synapse** dev_syn; // Device copy of syn
    
    unsigned int n_neur; // Number of neurons in the network
    unsigned int n_syn; // Number of synapses in the network
    // Note: I would use vectors, but I need to copy the arrays to the GPGPU, and I feel this would be a better way

    void addNeuron(Neuron* neuron)
    {
	Neuron** temp_neur = (Neuron**) malloc(n_neur * sizeof(Neuron*)); // Create temp to store current neurons
	for(int i = 0; i < n_neur; i++) temp_neur[i] = neur[i]; // Copy neurons to temp
	free(neur); // Free up neurons, will allocate again later

	neur = (Neuron**) malloc((n_neur + 1) * sizeof(Neuron*)); // Allocate the new neuron array
	for(int i = 0; i < n_neur; i++) neur[i] = temp_neur[i]; // Copy the temp back to the neuron array
	neur[n_neur] = neuron; // Add the new neuron to the neuron array

	n_neur++; // Increment the size
    }
	
    void addSynapse(Synapse* synapse)
    {
	Synapse** temp_syn = (Synapse**) malloc(n_syn * sizeof(Synapse*)); // Create temp to store current synapses
	for(int i = 0; i < n_syn; i++) temp_syn[i] = syn[i]; // Copy synapses to temp
	free(syn); // Free up synapses, will allocate again later

	syn = (Synapse**) malloc((n_syn + 1) * sizeof(Synapse*)); // Allocate the new synapse array
	for(int i = 0; i < n_syn; i++) syn[i] = temp_syn[i]; // Copy the temp back to the synapse array
	syn[n_syn] = synapse; // Add the new synapse to the synapse array

	n_syn++; // Increment the size
    }
    
#if CUDA_SUPPORT == 1
	int n_gpu = 1; // Default number of GPUs
	
    __global__ void cudaNeuron(Neuron **neuron) // Use the GPU to update neurons
    {
        int n = threadIdx.x + (blockIdx.x * blockDim.x); // Thread index (neuron number)
        (*(neuron[n])).update(); // Update the neuron at the thread index
    }
    
    __global__ void cudaSynapse(Synapse **synapse) // Use the GPU to update synapses
    {
        int n = threadIdx.x + (blockIdx.x * blockDim.x); // Thread index (synapse number)
        (*(synapse[n])).transmit(); // Update the synapse at the thread index
    }
    
    void propagate() // Propagate data through the network using the GPU(s)
    {
		// Note: Multiple streams not yet implemented
		cudaStream_t* streams = (cudaStream_t*) malloc(n_gpu*sizeof(cudaStream_t)); // Array to store CUDA streams
		cudaEvent_t* events = (cudaEvent_t*) malloc(n_gpu*sizeof(cudaStream_t)); // Array to store CUDA events
		
		cudaMalloc((void***)&dev_neur, n_neur*sizeof(Neuron*)); // Allocate the neuron array on the GPU(s)
		cudaMalloc((void***)&dev_syn, n_syn*sizeof(Synapse*)); // Allocate the synapse array on the GPU(s)
		
		cudaMemcpy(dev_neur, neur, n_neur*sizeof(Neuron*), cudaMemcpyHostToDevice); // Copy the neuron array to the GPU(s)
		cudaMemcpu(dev_syn, syn, n_syn*sizeof(Synapse*), cudaMemcpyHostToDevice); // Copy the synapse array to the GPU(s)
		
		cudaSynapse<<<n_syn, 1>>>(dev_syn); // Execute the synapse updates on the GPU(s)
        cudaNeuron<<<n_neur, 1>>>(dev_neur); // Execute the neuron updates on the GPU(s)
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
