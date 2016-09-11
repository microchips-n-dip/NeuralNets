#include <cmath>
// No idea wtf this is supposed to do... doesn't make much sense

void configureSDR(NeuronUpdateRule& rule, double baseline, double decay)
{
    rule.update(Neuron neuron)  // huh??
    {
        if(fabs(baseline-NeuronValue) < decay) NeuronValue = baseline; // Overshoot compensation
        else if(NeuronValue < baseline) NeuronValue += decay; // Less than case
        else if(NeuronValue > baseline) NeuronValue -= decay; // Greater than case
    }
}
