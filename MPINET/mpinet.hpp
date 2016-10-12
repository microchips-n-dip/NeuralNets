#ifdef env_mpi

#include <cmath>
#include <vector>

#include "parallel.hpp"

/// these are not "global" - each process has a completely separate instance of these
// Some global variables
// These will be for deciding process ownership
// int proc_neurons = 0;
// int proc_synapses = 0;
// int n_procs;


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

/** NeuronLocale was completely redundant and actually problematic:
 * -it returned a NULL on every process that didn't match the "owner"
 * -returned pointer (NEVER return a pointer like that!) was promptly
 *  dereferenced on each process
 * -it required synchronization and communication to instantiate something
 *  locally (sloppy and inefficient)
 * -it was always asking for the rank of the calling process: this info is best
 *  kept in a persistent object somewhere and passed-by-reference to the
 *  function (now done with 'Parallel') or if it's only basic info, set as
 *  static members of the base class (Neuron)
 */

class Synapse {
  public:
    double w = 0.0;
    
    /** These have to go: it's super erroneous (and doesn't make sense)
     * to use pointers to objects on other processes
     * Replace with source/target rank & list index?
     */
//     NeuronLocale *Source;
//     NeuronLocale *Target;
};

/// see above for why SynapseLocale was removed

class Network {
    
    unsigned int local_count;
    unsigned int *global_count;
    unsigned int total_count;
    int nprocs;
    
  public:
    std::vector<Neuron*> proc_neur;
    std::vector<Synapse*> proc_syn;
    
    Network(Parallel &mpi)
    {
        local_count = 0;
        total_count = 0;
        nprocs = mpi.nprocs;
        global_count = (unsigned int*)calloc(mpi.nprocs,sizeof(unsigned int));
    }
    ~Network()
    {
        // destructor frees allocated memory
        if (global_count != NULL) free(global_count);
    }
    
    // Member function prototypes
    void addNeuron(Neuron *neuron);
    void addSynapse(Synapse *synapse);
    void update_global_count();
    void distribute(Parallel &mpi);
};


#endif
