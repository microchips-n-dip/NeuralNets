class Network {
    private:
    unsigned int nneurons = 0;
    Neuron *nnet;

    unsigned int nsynapses = 0;
    Synapse *snet;

    public:
    void addNeuron(Neuron neuron)
    {
	Neuron *temp = (Neuron *) malloc(nneurons*sizeof(Neuron));
	if(nneurons > 0) {
	    for(unsigned int i = 0; i < nneurons; i++) temp[i] = nnet[i];
	    free(nnet);
	}

	nnet = (Neuron *) malloc((nneurons+1)*sizeof(Neuron));
	for(unsigned int i = 0; i < nneurons; i++) nnet[i] = temp[i];
	free(temp);

	nneurons++;
	nnet[nneurons-1] = neuron;
    }

    void printPointers()
    {
	printf("Neuron: %p\n", nnet);
	printf("Synapse: %p\n", snet);
    }
};
