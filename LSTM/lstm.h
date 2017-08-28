#ifndef NTM_H
#define NTM_H

#include <vector>
#include <random>
#include <unsupported/Eigen/CXX11/Tensor>

using Eigen::Tensor;

class LSTM
{
  public:

  typedef Tensor<double, 1> FlowType;
  typedef Tensor<double, 2> WeightType;

  LSTMStates<FlowType> states;
  LSTMWeights<WeightType> weights;

  FlowType forward(FlowType x);
  LSTM();
};

#endif
