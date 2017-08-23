#include "ntm.h"

using Eigen::Tensor;

Tensor<double, 1> forward(Tensor<double, 1> x)
{
  Tensor<double, 1> prev_C;
  std::list<Tensor<double, 1>> prev_Cs = Cs;

  // Clear state
  Cs = std::list<Tensor<double, 1>>(layers);

  Tensor<double, 1> concat_input;
  concat_input = concat_input.concatenate(x);
  concat_input = concat_input.concatenate(prev_Cs.at(0));
  concat_input = concat_input.concatenate(rh);

  Tensor<double, 1> h;
  h = concat_input;

  for (unsigned int layer_idx = 1; layer_idx < layers; ++layer_idx) {
    Tensor<double, 2> w_i_gate = ntm_ig_weights.at(layer_idx);
    Tensor<double, 2> w_f_gate = ntm_fg_weights.at(layer_idx);
    Tensor<double, 2> w_o_gate = ntm_og_weights.at(layer_idx);
    Tensor<double, 2> w_u_gate = ntm_ug_weights.at(layer_idx);

    std::array<IndexPair<int>, 1> ctr1 = {IndexPair<int>(0, 0)};
    Tensor<double, 1> i_gate = sigmoid(tco(h, w_i_gate, ctr1));
    std::array<IndexPair<int>, 1> ctr2 = {IndexPair<int>(0, 0)};
    Tensor<double, 1> f_gate = sigmoid(tco(h, w_g_gate, ctr2));
    std::array<IndexPair<int>, 1> ctr3 = {IndexPaur<int>(0, 0)};
    Tensor<double, 1> o_gate = sigmoid(tco(h, w_o_gate, ctr3));
    std::array<IndexPair<int>, 1> ctr4 = {IndexPair<int>(0, 0)};
    Tensor<double, 1> u_gate = tanh(tco(h, w_u_gate, ctr4));

    Tensor<double, 1> C;
    prev_C = prev_Cs.at(layer_idx);
    C = (prev_C * f_gate) + (i_gate * u_gate);
    Cs.at(layer_idx) = C;

    h = tanh(C);
    output_list.at(layer_idx) = h;
  }
}
