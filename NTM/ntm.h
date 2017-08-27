#ifndef NTM_H
#define NTM_H

#include <vector>
#include <random>
#include <unsupported/Eigen/CXX11/Tensor>

using Eigen::Tensor;

class NTM
{
  public:

  unsigned int layers;
  unsigned int cell_width;
  unsigned int input_sz;
  unsigned int head_sz;
  unsigned int mem_length;

  Tensor<double, 1> rh;

  std::vector<Tensor<double, 1>> Cs;
  std::vector<Tensor<double, 1>> prev_Cs;

  std::vector<Tensor<double, 2>> ntm_fg_weights;
  std::vector<Tensor<double, 2>> ntm_ig_weights;
  std::vector<Tensor<double, 2>> ntm_ug_weights;
  std::vector<Tensor<double, 2>> ntm_og_weights;

  std::vector<Tensor<double, 1>> ntm_f_gate;
  std::vector<Tensor<double, 1>> ntm_i_gate;
  std::vector<Tensor<double, 1>> ntm_u_gate;
  std::vector<Tensor<double, 1>> ntm_o_gate;

  std::vector<Tensor<double, 1>> zu;
  std::vector<Tensor<double, 1>> zo;

  std::vector<Tensor<double, 1>> output_list;
  std::vector<Tensor<double, 1>> prev_output_list;

  std::vector<Tensor<double, 1>> lambda;

  Tensor<double, 2> Memory;

  Tensor<double, 2> head_beta_weights;
  Tensor<double, 2> head_g_weights;
  Tensor<double, 2> head_s_weights;
  Tensor<double, 2> head_gamma_weights;

  Tensor<double, 1> prev_w_head;

  Tensor<double, 2> head_key_weights;
  Tensor<double, 2> head_erase_weights;
  Tensor<double, 2> head_add_weights;

  Tensor<double, 1> forward(Tensor<double, 1> x);
  void heads_update();
  void backprop();

  NTM(unsigned int _layers,
    unsigned int _cell_width,
    unsigned int _input_sz,
    unsigned int _head_sz,
    unsigned int _mem_length);
};

#endif
