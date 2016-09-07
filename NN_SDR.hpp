void configureSDR(NeuronUpdateRule& rule, double baseline, double decay)
{
    rule.update(Neuron neuron)
    {
	if(Abs(baseline-NeuronValue) < decay) NeuronValue = baseline; // Overshoot compensation
        else if(NeuronValue < baseline) NeuronValue += decay; // Less than case
        else if(NeuronValue > baseline) NeuronValue -= decay; // Greater than case
    }
}
