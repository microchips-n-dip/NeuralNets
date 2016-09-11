// Includes

/*********************************************************************/
/*************************** Neuron base class ***********************/
/*********************************************************************/
class Neuron
{
  protected:
    double nv = 0.0; // Value of neuron
    double nvt = 0.0; // Temporary value storage
    
  public:
    
    Neuron()
    {
        // Do nothing
    };
    ~Neuron(){};
    
    // Why not just make the appropriate members public and access directly?
    double getNeuronValue() {return nv;} // Output value of neuron
    double getNeuronTemp() {return nvt;} // Output temporary value of neuron
    void forceAddNeuronTemp(double addNeuron) {nvt += addNeuron;} // Add to nvt
    void forceSetNeuronTemp(double NewValue) {nvt = NewValue;}
    void forceSetNeuronValue(double NewValue) {nv = NewValue;} // Force set neuron value
    
    virtual void update() = 0;
};

/*********************************************************************/
/*************************** Derived Classes *************************/
/*********************************************************************/

/* New classes, so far, only need a definition of update() and any
 * specific private members.
 */

/*********************************************************************/
class NeuronDecay: public Neuron
{
    double decay;
    double baseline;
    
  public:
    NeuronDecay(){};
    NeuronDecay(double d, double b)
    {
        decay = d;
        baseline = b;
    }
    ~NeuronDecay(){}
    
    void update()
    {
        if(fabs(baseline-nv) < decay)
            nv = baseline; // Overshoot compensation
        else if(nv < baseline)
            nv = nv + decay; // Less than case
        else if(nv > baseline)
            nv = nv - decay; // Greater than case
            
        nv = nv + nvt;
        nvt = 0;
    }
    
    /* These are probably clumsy. Use the constructor to set initial values
     * and update as you want.
     */
    void setDecay(double d){decay = d;}
    void setBaseline(double b){baseline = b;}
};


/*********************************************************************/
// Class to use a placeholder while I fixed things
class NeuronEmpty: public Neuron
{
  public:
      void update()
      {
          printf("Nothing for an empty neuron to do!\n");
      }
};
