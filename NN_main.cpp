#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "Math.hpp"

// using namespace std;

// class Neuron;
// class Synapse;
// class Network;
//class Neuron;
//class Synapse;
//class Network;
// 
// class NeuronUpdateRule;
// class DecayRule;

//#include "NN_NeuronUpdateRule.hpp"
//#include "NN_SDR.hpp"
#include "NN_neuron.hpp"
// #include "NN_Rule.hpp"
#include "NN_synapse.hpp"
#include "NN_network.hpp"

int main(void)
{
    Network network;
    
    /* There will be a cascade of destructor calls when this is freed,
     * which will free the objects allocated by each call to new
     */
    network.addNeuron(new NeuronDecay());
    network.addNeuron(new NeuronEmpty());
    network.addNeuron(new NeuronEmpty());

//     network.printPointers();
}
