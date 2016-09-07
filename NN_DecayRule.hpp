class DecayRule: public NeuronUpdateRule {
    public:
    double decay = 0.0;
    double baseline = 0.0;

    public:
    void setDecay(double newDecay)
    {
	decay = newDecay;
    }

    void setBase(double newBaseline)
    {
	baseline = newBaseline;
    }

    void update(Neuron neuron)
    {
	if(Abs(this->baseline-neuron.getNeuronValue()) < this->decay) neuron.forceSetNeuronValue(this->baseline); // Overshoot compensation
        else if(neuron.getNeuronValue() < this->baseline) neuron.forceSetNeuronValue(neuron.getNeuronValue() + this->decay); // Less than case
        else if(neuron.getNeuronValue() > this->baseline) neuron.forceSetNeuronValue(neuron.getNeuronValue() - this->decay); // Greater than case
	neuron.forceSetNeuronValue(neuron.getNeuronValue() + neuron.getNeuronTemp());
	neuron.forceSetNeuronTemp(0);
    }
};
