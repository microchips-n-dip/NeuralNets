namespace Japetus {

using namespace Eigen;

struct Functor
{
  std::vector<Variable& /* ? */> inputs;

  void gather_inputs()
  {
    for (auto var : inputs) {
      (*var.src_func).run();
    }
  }

  virtual void run();
  virtual Functor* gradient();
};

struct SigmoidFunctor : public Functor
{
  void run()
  {
    gather_inputs();
    return sigmoid(inputs.at(0).tensor);
  }

  Functor* gradient()
  {
    return new SigmoidGradient(inputs);
  }
};

struct TanhFunctor : public Functor
{
  void run()
  {
    gather_inputs();
    return tanh(inputs.at(0).tensor);
  }

  Functor* gradient()
  {
    return new TanhGradient(inputs);
  }
};

struct 

}
