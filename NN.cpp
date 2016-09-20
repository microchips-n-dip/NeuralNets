#include <string>
#include "NN_neuron.hpp"
#include "NN_synapse.hpp"
#include "NN_network.hpp"

/*void MemoryUpdate(Network& network, Neuron *NeuronTarget)
{
    for(unsigned int i = 0; i < network.getSynapseCount(); i++)
    if(network.getSynapse(i).getTarget() == NeuronTarget) {
	network.getSynapse(i).getTarget().update();
	network.getSynapse(i).setW();
    }
}*/

void rewardSystem(Network& network)
{
//    NeuronClamped stimulus(1.0);
    NeuronDecay compulsor(0.1, 0.0);
    NeuronDecay Time(0.01, 1.0);

//    Synapse StimulusCompulsor(&stimulus, &compulsor, 1.0);
    Synapse TimeCompulsor(&Time, &compulsor, 1.0);

//    network.addNeuron(&stimulus);
    network.addNeuron(&Time);
    network.addNeuron(&compulsor);

//    network.addSynapse(&StimulusCompulsor);
    network.addSynapse(&TimeCompulsor);
}

int main(void)
{
    Network network;

    rewardSystem(network);
    network.propagate();
    network.propagate();
}
