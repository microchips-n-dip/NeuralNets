#include <string>
#include "NN_neuron.hpp"
#include "NN_synapse.hpp"
#include "NN_network.hpp"

// CUDA implementation inclusion
#define CUDA_SUPPORT 0 // I did this conditional stuff a bit lazily
#if CUDA_SUPPORT 1
#include "netCUDA.cu"
#endif


int main(void)
{
    Network network;

    // Impulses
    NeuronDecay 
}
