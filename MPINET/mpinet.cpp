#ifdef env_mpi

#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include "mpinet.hpp"

#include <iostream>

int main(void)
{
    MPI_Init(NULL, NULL);
    
    Parallel mpi_info = Parallel();
    mpi_info.say_hello();   // test function
    
    Network procnet(mpi_info);
    procnet.update_global_count();
    procnet.addNeuron(new NeuronDecay(0.1, 0.0));
    
    /// add Neurons, Synapses wherever
    // code to add these
    
    //    for(int i = 0; i < 7; i++) procnet.addNeuron(createNeuron(new NeuronDecay(0.1, 0.0)));
    //    printf("Process %i has %i neurons\n", w_rank, procnet.proc_neur.size());
    
    /// begin loop
    
    /// do things to the Neurons locally (including create new ones, if you want)
    // code to do things locally
    
    /// prepare any info for communication and communicate it
    // parallel code here
    
    /// do load balancing Network::distribute will do this currently
    procnet.distribute(mpi_info);
    
    /// end loop
    
    MPI_Finalize();
}

/*********************************************************************/
/*********** Network class member function implementations ***********/
/*********************************************************************/
void Network::addNeuron(Neuron *neuron)
{
    /** removed all the redundant code: very messy doing a reduction
     * just to instantiate an object locally
     * add objects to the list locally and do any load balancing at the
     * end of a loop (way more efficient)
     */
    proc_neur.push_back(neuron);    // Just add the thing to the list
    
}

void Network::addSynapse(Synapse *synapse)
{
    /// see Network::addNeuron()
    proc_syn.push_back(synapse);    // Just add the thing to the list
}

void Network::update_global_count()
{
    // Separate function to compute counts whenever needed
    MPI_Allreduce(&local_count,global_count,1,MPI_UNSIGNED,MPI_SUM,MPI_COMM_WORLD);
    
    for (unsigned int i=nprocs; i--;) total_count += global_count[i];
    local_count = proc_neur.size(); // update the local count while we're here
}

void Network::distribute(Parallel &mpi)
{
    // Make sure the counts are up to date
//     update_global_count();
    
    unsigned int nn_avg = total_count/nprocs;   // Average neuron count
    unsigned int nn_rem = total_count%nprocs;   // Remainder
    
    int diff = local_count-nn_avg;  // Difference between local and average counts
    
    /// Leave this alone for now: a parallel algorithm is needed for load balancing -GB
    if (diff>0)
    {
        /// stuff to do
    }
    
}

// How I see distribute
void distribute(Parallel &mpi)
{
    // This stuff makes plenty of sense, it's just for figuring out how many times to do the send/recv
    // thing. I'm implementing that
    unsigned int nn_avg = total_count / nprocs;
    unsigned int nn_rem = total_count % nprocs;
    int diff =  local_count - nn_avg;
    
    if(diff > 0) 
    {
        for(int i = 0; i < diff; i++)
        {
            MPI_Send(&proc_neur[i], );
        }
    }
}
#endif
