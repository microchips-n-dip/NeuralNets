class Synapse
{
    private:
    double w;

    Neuron *SourceNeuron;
    Neuron *TargetNeuron;

    public:
    Synapse(Neuron source, Neuron target, double w = 0)
    {
	SourceNeuron = source;
	TargetNeuron = target;
    }

    void transmit() {TargetNeuron->forceAddNeuronTemp(w * SourceNeuron->getNeuronValue());}
    void setW(double new_W) {w = new_W;}
    double getW() {return w;}
    Neuron* getTarget() {return TargetNeuron;}
};
