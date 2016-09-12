#include "NN_neuron.hpp"
#include "NN_synapse.hpp"
#include "NN_network.hpp"

void Memory(Network& network)
{
    network.addNeuron(new DecayNeuron);
    network.addNeuron(new DecayNeuron);
}

int main(void)
{
    Network network;

    
}
