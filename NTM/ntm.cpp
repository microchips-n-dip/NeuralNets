#include "ntm.h"
#include "tensorops.h"

using namespace Eigen;

Tensor<double, 1> NTM::forward(Tensor<double, 1> x)
{
  Tensor<double, 1> prev_C;
  prev_Cs = Cs;
  Cs = std::vector<Tensor<double, 1>>(layers);

  Tensor<double, 1> prev_o;
  prev_output_list = output_list;
  output_list = std::vector<Tensor<double, 1>>(layers);

  Tensor<double, 1> concat_input;
  concat_input = concat_input.concatenate(x, 0);
  concat_input = concat_input.concatenate(rh, 0);

  Tensor<double, 1> h;
  h = concat_input;

  for (unsigned int layer_idx = 0; layer_idx < layers; ++layer_idx) {
    prev_o = prev_output_list.at(layer_idx);
    h = h.concatenate(prev_o, 0);

    Tensor<double, 2> w_i_gate = ntm_ig_weights.at(layer_idx);
    Tensor<double, 2> w_f_gate = ntm_fg_weights.at(layer_idx);
    Tensor<double, 2> w_o_gate = ntm_og_weights.at(layer_idx);
    Tensor<double, 2> w_u_gate = ntm_ug_weights.at(layer_idx);

    std::array<IndexPair<int>, 1> ctr1 = {IndexPair<int>(0, 0)};
    Tensor<double, 1> i_gate = sigmoid(tco(h, w_i_gate, ctr1));
    Tensor<double, 1> f_gate = sigmoid(tco(h, w_f_gate, ctr1));
    Tensor<double, 1> o_gate = sigmoid(tco(h, w_o_gate, ctr1));
    Tensor<double, 1> u_gate = tanh(tco(h, w_u_gate, ctr1));

    ntm_i_gate.at(layer_idx) = i_gate;
    ntm_f_gate.at(layer_idx) = f_gate;
    ntm_o_gate.at(layer_idx) = o_gate;
    ntm_u_gate.at(layer_idx) = u_gate;

    Tensor<double, 1> C;
    prev_C = prev_Cs.at(layer_idx);
    C = (prev_C * f_gate) + (i_gate * u_gate);
    Cs.at(layer_idx) = C * o_gate;

    zu.at(layer_idx) = C;
    zo.at(layer_idx) = o_gate;

    h = tanh(C);
    output_list.at(layer_idx) = h;
  }
}

void NTM::backprop()
{
  Tensor<double, 1> ph;

  for (unsigned int layer_idx = layers - 1; layer_idx > 0; layer_idx--) {
    Tensor<double, 2> w_i_gate = ntm_ig_weights.at(layer_idx);
    Tensor<double, 2> w_f_gate = ntm_fg_weights.at(layer_idx);
    Tensor<double, 2> w_u_gate = ntm_ug_weights.at(layer_idx);
    Tensor<double, 2> w_o_gate = ntm_og_weights.at(layer_idx);

    Tensor<double, 1> i_gate = ntm_i_gate.at(layer_idx);
    Tensor<double, 1> f_gate = ntm_f_gate.at(layer_idx);
    Tensor<double, 1> o_gate = ntm_o_gate.at(layer_idx);
    Tensor<double, 1> u_gate = ntm_u_gate.at(layer_idx);

    Tensor<double, 1> Cu = Cs.at(layer_idx);
    Tensor<double, 1> tCu = tanh_prime(Cu);

    Tensor<double, 1> prev_C = prev_Cs.at(layer_idx);

    std::array<IndexPair<int>, 1> ctr1 = {IndexPair<int>(0, 0)};

    double zeta_u = tco(ph, zu.at(layer_idx), ctr1)(0);
    double zeta_o = tco(ph, zo.at(layer_idx), ctr1)(0);

    Tensor<double, 1> delta_o = zeta_u * sigmoid_prime(tco(lambda, w_o_gate, ctr1));
    Tensor<double, 1> dudq = tanh_prime(tco(lambda, w_u_gate, ctr1));
    Tensor<double, 1> delta_u = zeta_o * tco(tCu, i_gate, ctr1) * dudq;
    Tensor<double, 1> didq = sigmoid_prime(tco(lambda, w_i_gate, ctr1));
    Tensor<double, 1> delta_i = zeta_o * tco(tCu, u_gate, ctr1) * didq;
    Tensor<double, 1> dfdq = sigmoid_prime(tco(lambda, w_f_gate, ctr1));
    Tensor<double, 1> delta_f = zeta_o * tco(tCu, prev_C, ctr1) * dfdq;

    std::array<IndexPair<int>, 0> ctr2 = {};
    Tensor<double, 2> dhdWo = tco(delta_o, lambda, ctr2);
    Tensor<double, 2> dhdWu = tco(delta_u, lambda, ctr2);
    Tensor<double, 2> dhdWi = tco(delta_i, lambda, ctr2);
    Tensor<double, 2> dhdWf = tco(delta_f, lambda, ctr2);

    std::array<IndexPair<int>, 1> ctr3 = {IndexPair<int>(0, 1)};
    Tensor<double, 1> delta_l;
    delta_l += tco(delta_o, w_o_gate, ctr3);
    delta_l += tco(delta_u, w_u_gate, ctr3);
    delta_l += tco(delta_i, w_i_gate, ctr3);
    delta_l += tco(delta_f, w_f_gate, ctr3);

    ph = delta_l;
  }
}
