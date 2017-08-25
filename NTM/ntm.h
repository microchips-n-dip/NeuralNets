#ifndef NTM_H
#define NTM_H

using Eigen::Tensor;

class NTM
{
  public:

  std::list<Tensor<double, 1>> Cs;
  std::list<Tensor<double, 1>> prev_Cs;

  std::list<Tensor<double, 2>> ntm_fg_weights;
  std::list<Tensor<double, 2>> ntm_ig_weights;
  std::list<Tensor<double, 2>> ntm_ug_weights;
  std::list<Tensor<double, 2>> ntm_og_weights;

  std::list<Tensor<double, 1>> ntm_f_gate;
  std::list<Tensor<double, 1>> ntm_i_gate;
  std::list<Tensor<double, 1>> ntm_u_gate;
  std::list<Tensor<double, 1>> ntm_o_gate;

  std::list<Tensor<double, 1>> zu;
  std::list<Tensor<double, 1>> zo;

  std::list<Tensor<double, 1>> output_list;
  std::list<Tensor<double, 1>> prev_output_list;

  Tensor<double, 1> forward(Tensor<double, 1> x);
  void backpropagate();
};

#endif
