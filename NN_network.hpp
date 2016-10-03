#include <vector>

//#include "NN_synapse.hpp"
#define TPB_NET 1

class Network
{
  private:
      // You can't set members like this. Use a constructor!
      
//     unsigned int nneurons = 0;
//     Neuron *nnet;
    std::vector<Neuron*> neur;
    
//     unsigned int nsynapses = 0;
//     Synapse *snet;
    std::vector<Synapse*> syn;

  public:
    
    // Constructor/destructor
    Network(){};
    ~Network(){};
    
    
    void addNeuron(Neuron *neuron)
    {
        
//         Neuron *temp = (Neuron *) malloc(nneurons*sizeof(Neuron));
//         
//         if(nneurons > 0)
//         {
//             for(unsigned int i = 0; i < nneurons; i++) temp[i] = nnet[i];
//             free(nnet);
//         }
//         
//         nnet = (Neuron *) malloc((nneurons+1)*sizeof(Neuron));
//         for(unsigned int i = 0; i < nneurons; i++) nnet[i] = temp[i];
//         free(temp);
//         
//         nneurons++;
//         nnet[nneurons-1] = *neuron;
//         
        // Why re-invent the wheel??
        neur.push_back(neuron);
        
    }

    void addSynapse(Synapse *synapse)
    {
	syn.push_back(synapse);
    }

    
    // Request a pointer to a particular Neuron or Synapse
    Neuron* getNeuron(long unsigned int id){return neur.at(id);}
    Synapse* getSynapse(long unsigned int id){return syn.at(id);}
    
    // Request list sizes
    unsigned int getNeuronCount(){return neur.size();}
    unsigned int getSynapseCount(){return syn.size();}
    
    // Delete a particular Neuron or Synapse
    void deleteNeuron(size_t &id)
    {
        // Move it to the end first, otherwise it's less efficient (in big lists)
        Neuron *temp = neur.at(id);     // Temporary copy of i-th Neuron
        neur.at(id) = neur.back();      // Copy the last one to the i-th spot
        
        /* Need to move the temp to the end BEFORE we delete, so there's
         * no memory leak or double free.
         */
        neur.back() = temp;     // Put it on top of the last element (already copied)
        neur.pop_back();        // Erase it (will call its destructor and free memory)
        
    }
    void deleteSynapse(size_t &id)
    {
        // Move it to the end first, otherwise it's less efficient (in big lists)
        Synapse *temp = syn.at(id);     // Temporary copy of i-th Synapse
        syn.at(id) = syn.back();      // Copy the last one to the i-th spot
        
        /* Need to move the temp to the end BEFORE we delete, so there's
         * no memory leak or double free.
         */
        syn.back() = temp;     // Put it on top of the last element (already copied)
        syn.pop_back();        // Erase it (will call its destructor and free memory)
        
    }

    void cudaPropagate() = 0; 
	
    void propagate()
    {
	for(unsigned int i = 0; i < syn.size(); i++) {
	    (*syn.at(i)).transmit();
	}

	for(unsigned int i = 0; i < neur.size(); i++) {
	    (*neur.at(i)).update();
	}
    }
    
    void printPointers()
    {
        // wtf?
//         printf("Neuron: %p\n", nnet);
//         printf("Synapse: %p\n", snet);
    }
};

	
// CUDA implementation
__global__ void cudaNeurons(Network** network)
{
    int n = threadIdx.x + (blockIdx.x * blockDimx.x);
    (*(**network).getNeuron(n)).update();
}
	
__global__ void cudaSynapses(Network** network)
{
    int s = threadIdx.x + (blockId.x * blockDimx.x);
    (*(**network).getSynapse(s)).transmit();
}

Network::cudaPropagate()
{
    Network** dev_net;
    int size = sizeof(Network*);
    cudaMemcpy(dev_net, &this, size, cudaMemcpyHostToDevice);
    cudaNeurons<<<getNeuronCount()/TPB_NET, TBP_NET>>>(dev_net);
    cudaSynapses<<<getNeuronCount()/TPB_NET, TBP_NET>>>(dev_net);
}
