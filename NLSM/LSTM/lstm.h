#ifndef NTM_H
#define NTM_H

#include <vector>
#include <random>
#include <unsupported/Eigen/CXX11/Tensor>

using Eigen::Tensor;

class LSTM
{
  public:

  unsigned int layers;
  std::vector<unsigned int> cell_widths;

  std::vector<Tensor<double, 1>> Cs;
  std::vector<Tensor<double, 1>> prev_Cs;

  std::vector<Tensor<double, 2>> lstm_fg_weights;
  std::vector<Tensor<double, 2>> lstm_ig_weights;
  std::vector<Tensor<double, 2>> lstm_ug_weights;
  std::vector<Tensor<double, 2>> lstm_og_weights;

  std::vector<Tensor<double, 1>> lstm_f_gate;
  std::vector<Tensor<double, 1>> lstm_i_gate;
  std::vector<Tensor<double, 1>> lstm_u_gate;
  std::vector<Tensor<double, 1>> lstm_o_gate;

  std::vector<Tensor<double, 1>> zu;
  std::vector<Tensor<double, 1>> zo;

  std::vector<Tensor<double, 1>> output_list;
  std::vector<Tensor<double, 1>> prev_output_list;

  std::vector<Tensor<double, 1>> lambda;

  Tensor<double, 1> forward(Tensor<double, 1> x);
  void backprop();

  template <typename A>
  LSTM(unsigned int _layers,
    std::initializer_list<A> _cell_widths);
};

#endif
