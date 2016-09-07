class Synapse {
    private:
    double w;

    Neuron SourceNeuron;
    Neuron TargetNeuron;

    public:
    void transmit()
    {
	TargetNeuron.forceAddNeuronTemp(w * SourceNeuron.getNeuronValue());
    }

    void setW(double new_W)
    {
	w = new_W;
    }

    double getW()
    {
	return w;
    }
};
