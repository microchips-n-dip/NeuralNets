#if CUDA_SUPPORT 1
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
    cudaSynapses<<<getNeuronCount()/TPB_NET, TBP_NET>>>(dev_net);
    cudaNeurons<<<getNeuronCount()/TPB_NET, TBP_NET>>>(dev_net);
}
#endif
