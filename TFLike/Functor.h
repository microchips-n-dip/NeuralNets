#ifndef JAPETUS_FUNCTOR_H
#define JAPETUS_FUNCTOR_H

namespace Japetus {

using namespace Eigen;

template <typename VariableType>
struct Functor
{
  typedef Functor<VariableType> Self;

  std::vector<VariableType& /* ? */> inputs;
  VariableType& output;

  void gather_inputs()
  {
    for (auto var : inputs) {
      (*var.src_func).run();
    }
  }

  virtual void run() = 0;
  virtual Self* gradient() = 0;
};

template <typename VariableType>
struct SigmoidFunctor :
  public Functor<VariableType>
{
  void run()
  {
    gather_inputs();
    output.tensor = sigmoid(inputs.at(0).tensor);
  }

  Self* gradient()
  {
    return new SigmoidGradient<VariableType>(inputs);
  }
};

template <typename VariableType>
struct TanhFunctor :
  public Functor<VariableType>
{
  void run()
  {
    gather_inputs();
    output.tensor tanh(inputs.at(0).tensor);
  }

  Self* gradient()
  {
    return new TanhGradient<VariableType>(inputs);
  }
};

template <typename VariableType>
struct HadamardProductFunctor :
  public Functor<VariableType>
{
  void run()
  {
    gather_inputs();
    output.tensor = inputs.at(0).tensor * \
      inputs.at(1).tensor;
  }
};

}

#endif
