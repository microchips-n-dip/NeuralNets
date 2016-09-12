#include <string>
#include "NN_neuron.hpp"
#include "NN_synapse.hpp"
#include "NN_network.hpp"

void MemoryUpdate(Network& network, Neuron *NeuronTarget)
{
    for(unsigned int i = 0; i < network.getSynapseCount(); i++)
    if(network.getSynapse(i).getTarget() == NeuronTarget) {
	network.getSynapse(i).setW();
    }
}

int main(void)
{
    Network network;

    
}
