namespace cellsim {

struct OpKernel
{
  virtual void Compute() = 0;
};

}