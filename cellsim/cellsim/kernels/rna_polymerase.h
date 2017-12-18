namespace cellsim {

struct OpRNAPolymerase : public OpKernel
{
  void Compute(WorldState* ws) override;
};

}