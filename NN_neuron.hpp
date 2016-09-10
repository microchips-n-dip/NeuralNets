#include "NN_NeuronUpdateRule.hpp"

class Neuron {
    private:
    double nv = 0.0; // Value of neuron
    double nvt = 0.0; // Temporary value storage

    NeuronUpdateRule *updateRule;

    public: // Helper functions
    double getNeuronValue() {return nv;} // Output value of neuron
    double getNeuronTemp() {return nvt;} // Output temporary value of neuron
    void forceAddNeuronTemp(double addNeuron) {nvt += addNeuron;} // Add to nvt
    void forceSetNeuronTemp(double NewValue) {nvt = NewValue;}
    void forceSetNeuronValue(double NewValue) {nv = NewValue;} // Force set neuron value
    void setUpdateRule(NeuronUpdateRule *newUpdateRule) {updateRule = newUpdateRule;} // Set update rule
    void update() {updateRule->update(*this);} // Iteratively update neuron value

    /*{
	if(Abs(baseline-NeuronValue) < decay) NeuronValue = baseline; // Overshoot compensation
	else if(NeuronValue < baseline) NeuronValue += decay; // Less than case
	else if(NeuronValue > baseline) NeuronValue -= decay; // Greater than case
    }*/
};
