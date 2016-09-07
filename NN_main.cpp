#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "Math.hpp"

using namespace std;

class Neuron;
class Synapse;
class Network;

class NeuronUpdateRule;
class DecayRule;

#include "NN_NeuronUpdateRule.hpp"
//#include "NN_SDR.hpp"
#include "NN_neuron.hpp"
#include "NN_DecayRule.hpp"
#include "NN_synapse.hpp"
#include "NN_network.hpp"

int main(void)
{
    DecayRule generalRule;

    Network network;
    Neuron neuron1, neuron2, neuron3;

    neuron1.setUpdateRule(&generalRule);

    network.addNeuron(neuron1);
    network.addNeuron(neuron2);
    network.addNeuron(neuron3);

    network.printPointers();
}
