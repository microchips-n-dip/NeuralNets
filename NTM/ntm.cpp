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

    lambda.at(layer_idx) = h;

    Tensor<double, 2> w_i_gate = ntm_ig_weights.at(layer_idx);
    Tensor<double, 2> w_f_gate = ntm_fg_weights.at(layer_idx);
    Tensor<double, 2> w_o_gate = ntm_og_weights.at(layer_idx);
    Tensor<double, 2> w_u_gate = ntm_ug_weights.at(layer_idx);

    std::array<IndexPair<int>, 1> ctr_0_0 = {IndexPair<int>(0, 0)};
    Tensor<double, 1> i_gate = sigmoid(tco(h, w_i_gate, ctr_0_0));
    Tensor<double, 1> f_gate = sigmoid(tco(h, w_f_gate, ctr_0_0));
    Tensor<double, 1> o_gate = sigmoid(tco(h, w_o_gate, ctr_0_0));
    Tensor<double, 1> u_gate = tanh(tco(h, w_u_gate, ctr_0_0));

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

  return output_list.back();
}

void NTM::heads_update()
{
  std::array<IndexPair<int>, 1> ctr_0_0 = {IndexPair<int>(0, 0)};
  std::array<IndexPair<int>, 1> ctr_0_1 = {indexPair<int>(0, 1)};
  std::array<IndexPair<int>, 1> ctr_1_1 = {IndexPair<int>(1, 1)};

  double beta = tco(output_list.back(), head_beta_weights, ctr_0_0)();
  double g = tco(output_list.back(), head_g_weights, ctr_0_0)();
  Tensor<double, 1> s = tco(output_list.back(), head_s_weights, ctr_0_0);
  double gamma = tco(output_list.back(), head_gamma_weights, ctr_0_0)();

  Tensor<double, 1> w;

  double norm_k = tco(k, k, ctr_0_0)();
  Tensor<double, 1> norm_M(mem_length);
  Tensor<double, 2> _norm_M = tco(Memory, Memory, ctr_1_1);
  for (unsigned int i = 0; i < mem_length; ++i) {
    norm_M(i) = _norm_M(i, i);
  }

  Tensor<double, 1> wc1 = beta * tco(k, Memory, ctr_0_1) / (norm_k * norm_M);
  Tensor<double, 1> wc(mem_length);
  double b_norm = 0;
  for (unsigned int i = 0; i < mem_length; ++i) {
    wc1(i) = exp(wc1(i));
    b_norm += wc1(i);
  }
  wc = wc1 / b_norm;

  Tensor<double, 1> wg = g * wc + (1 - g) * prev_w_head;

  Tensor<double, 1> w1(mem_length);
  for (unsigned int i = 0; i < mem_length; ++i) {
    for (unsigned int j = 0; j < mem_length; ++j) {
      w1(i) += wg(j) * s((i - j) % mem_length);
    }
  }

  Tensor<double, 1> w2 = w1.pow(gamma);
  w = w2 / w2.sum();
  prev_w_head = w;
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

    std::array<IndexPair<int>, 1> ctr_0_0 = {IndexPair<int>(0, 0)};

    double zeta_u = tco(ph, zu.at(layer_idx), ctr_0_0)(0);
    double zeta_o = tco(ph, zo.at(layer_idx), ctr_0_0)(0);

    Tensor<double, 1> delta_o = zeta_u * sigmoid_prime(tco(lambda.at(layer_idx), w_o_gate, ctr_0_0));
    Tensor<double, 1> dudq = tanh_prime(tco(lambda.at(layer_idx), w_u_gate, ctr_0_0));
    Tensor<double, 1> delta_u = zeta_o * tco(tCu, i_gate, ctr_0_0) * dudq;
    Tensor<double, 1> didq = sigmoid_prime(tco(lambda.at(layer_idx), w_i_gate, ctr_0_0));
    Tensor<double, 1> delta_i = zeta_o * tco(tCu, u_gate, ctr_0_0) * didq;
    Tensor<double, 1> dfdq = sigmoid_prime(tco(lambda.at(layer_idx), w_f_gate, ctr_0_0));
    Tensor<double, 1> delta_f = zeta_o * tco(tCu, prev_C, ctr_0_0) * dfdq;

    std::array<IndexPair<int>, 0> no_ctr = {};
    Tensor<double, 2> dhdWo = tco(delta_o, lambda.at(layer_idx), no_ctr);
    Tensor<double, 2> dhdWu = tco(delta_u, lambda.at(layer_idx), no_ctr);
    Tensor<double, 2> dhdWi = tco(delta_i, lambda.at(layer_idx), no_ctr);
    Tensor<double, 2> dhdWf = tco(delta_f, lambda.at(layer_idx), no_ctr);

    ntm_og_weights.at(layer_idx) -= dhdWo;
    ntm_ug_weights.at(layer_idx) -= dhdWu;
    ntm_ig_weights.at(layer_idx) -= dhdWi;
    ntm_fg_weights.at(layer_idx) -= dhdWf;

    std::array<IndexPair<int>, 1> ctr_0_1 = {IndexPair<int>(0, 1)};
    Tensor<double, 1> delta_l;
    delta_l += tco(delta_o, w_o_gate, ctr_0_1);
    delta_l += tco(delta_u, w_u_gate, ctr_0_1);
    delta_l += tco(delta_i, w_i_gate, ctr_0_1);
    delta_l += tco(delta_f, w_f_gate, ctr_0_1);

    for (unsigned int i = cell_width; i < input_sz; ++i) {
      ph(i - cell_width) = delta_l(i);
    }
  }
}

NTM::NTM(unsigned int _layers,
  unsigned int _cell_width,
  unsigned int _input_sz,
  unsigned int _head_sz)
{
  std::random_device generator;
  std::uniform_real_distribution<double> ud(-1.0, 1.0);

  layers = _layers;
  cell_width = _cell_width;
  input_sz = _input_sz;
  head_sz = _head_sz;

  Cs = std::vector<Tensor<double, 1>>(layers);
  prev_Cs = std::vector<Tensor<double, 1>>(layers);

  output_list = std::vector<Tensor<double, 1>>(layers);
  prev_output_list = std::vector<Tensor<double, 1>>(layers);

  ntm_fg_weights = std::vector<Tensor<double, 2>>(layers);
  ntm_ig_weights = std::vector<Tensor<double, 2>>(layers);
  ntm_ug_weights = std::vector<Tensor<double, 2>>(layers);
  ntm_og_weights = std::vector<Tensor<double, 2>>(layers);

  ntm_f_gate = std::vector<Tensor<double, 1>>(layers);
  ntm_i_gate = std::vector<Tensor<double, 1>>(layers);
  ntm_u_gate = std::vector<Tensor<double, 1>>(layers);
  ntm_o_gate = std::vector<Tensor<double, 1>>(layers);

  zu = std::vector<Tensor<double, 1>>(layers);
  zo = std::vector<Tensor<double, 1>>(layers);

  lambda = std::vector<Tensor<double, 1>>(layers);

  for (unsigned int i = 0; i < layers; ++i) {
    Cs.at(i) = Tensor<double, 1>(cell_width);
    prev_Cs.at(i) = Tensor<double, 1>(cell_width);

    output_list.at(i) = Tensor<double, 1>(cell_width);
    prev_output_list.at(i) = Tensor<double, 1>(cell_width);

    if (i == 0) {
      input_sz = input_sz + head_size + cell_width;
    }
    else {
      input_sz = 2 * cell_width;
    }

    ntm_fg_weights.at(i) = Tensor<double, 2>(input_sz, cell_width);
    ntm_ig_weights.at(i) = Tensor<double, 2>(input_sz, cell_width);
    ntm_ug_weights.at(i) = Tensor<double, 2>(input_sz, cell_width);
    ntm_og_weights.at(i) = Tensor<double, 2>(input_sz, cell_width);

    for (unsigned int j = 0; j < input_sz * cell_width; ++j) {
      ntm_fg_weights.at(i).coeffRef(j) = ud(generator);
      ntm_ig_weights.at(i).coeffRef(j) = ud(generator);
      ntm_ug_weights.at(i).coeffRef(j) = ud(generator);
      ntm_og_weights.at(i).coeffRef(j) = ud(generator);
    }

    ntm_f_gate.at(i) = Tensor<double, 1>(cell_width);
    ntm_i_gate.at(i) = Tensor<double, 1>(cell_width);
    ntm_u_gate.at(i) = Tensor<double, 1>(cell_width);
    ntm_o_gate.at(i) = Tensor<double, 1>(cell_width);

    zu.at(i) = Tensor<double, 1>(cell_width);
    zo.at(i) = Tensor<double, 1>(cell_width);

    lambda.at(i) = Tensor<double, 1>(input_sz);
  }

  input_sz = _input_sz + head_sz + cell_width;
}
