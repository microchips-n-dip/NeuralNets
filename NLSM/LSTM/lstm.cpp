#include "lstm.h"
#include "tensorops.h"

using namespace Eigen;

Tensor<double, 1> LSTM::forward(Tensor<double, 1> x)
{
  std::array<IndexPair<int>, 1> ctr_0_0 = {IndexPair<int>(0, 0)};

  Tensor<double, 1> prev_C;
  prev_Cs = Cs;
  Cs = std::vector<Tensor<double, 1>>(layers);

  Tensor<double, 1> prev_o;
  prev_output_list = output_list;
  output_list = std::vector<Tensor<double, 1>>(layers);

  Tensor<double, 1> h = x;

  for (unsigned int layer_idx = 0; layer_idx < layers; ++layer_idx) {
    prev_o = prev_output_list.at(layer_idx);
    h = h.concatenate(prev_o, 0);

    lambda.at(layer_idx) = h;

    Tensor<double, 2> w_i_gate = lstm_ig_weights.at(layer_idx);
    Tensor<double, 2> w_f_gate = lstm_fg_weights.at(layer_idx);
    Tensor<double, 2> w_o_gate = lstm_og_weights.at(layer_idx);
    Tensor<double, 2> w_u_gate = lstm_ug_weights.at(layer_idx);

    Tensor<double, 1> i_gate = sigmoid(tco(h, w_i_gate, ctr_0_0));
    Tensor<double, 1> f_gate = sigmoid(tco(h, w_f_gate, ctr_0_0));
    Tensor<double, 1> o_gate = sigmoid(tco(h, w_o_gate, ctr_0_0));
    Tensor<double, 1> u_gate = tanh(tco(h, w_u_gate, ctr_0_0));

    lstm_i_gate.at(layer_idx) = i_gate;
    lstm_f_gate.at(layer_idx) = f_gate;
    lstm_o_gate.at(layer_idx) = o_gate;
    lstm_u_gate.at(layer_idx) = u_gate;

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

void LSTM::backprop()
{
  std::array<IndexPair<int>, 0> no_ctr = {};
  std::array<IndexPair<int>, 1> ctr_0_0 = {IndexPair<int>(0, 0)};
  std::array<IndexPair<int>, 1> ctr_0_1 = {IndexPair<int>(0, 1)};

  Tensor<double, 1> ph;

  for (unsigned int layer_idx = layers - 1; layer_idx > 0; layer_idx--) {
    Tensor<double, 2> w_i_gate = lstm_ig_weights.at(layer_idx);
    Tensor<double, 2> w_f_gate = lstm_fg_weights.at(layer_idx);
    Tensor<double, 2> w_u_gate = lstm_ug_weights.at(layer_idx);
    Tensor<double, 2> w_o_gate = lstm_og_weights.at(layer_idx);

    Tensor<double, 1> i_gate = lstm_i_gate.at(layer_idx);
    Tensor<double, 1> f_gate = lstm_f_gate.at(layer_idx);
    Tensor<double, 1> o_gate = lstm_o_gate.at(layer_idx);
    Tensor<double, 1> u_gate = lstm_u_gate.at(layer_idx);

    Tensor<double, 1> Cu = Cs.at(layer_idx);
    Tensor<double, 1> tCu = tanh_prime(Cu);

    Tensor<double, 1> prev_C = prev_Cs.at(layer_idx);

    double zeta_u = tco(ph, zu.at(layer_idx), ctr_0_0)(0);
    double zeta_o = tco(ph, zo.at(layer_idx), ctr_0_0)(0);

    Tensor<double, 1> delta_o = zeta_u * sigmoid_prime(tco(lambda.at(layer_idx), w_o_gate, ctr_0_0));
    Tensor<double, 1> dudq = tanh_prime(tco(lambda.at(layer_idx), w_u_gate, ctr_0_0));
    Tensor<double, 1> delta_u = zeta_o * tco(tCu, i_gate, ctr_0_0) * dudq;
    Tensor<double, 1> didq = sigmoid_prime(tco(lambda.at(layer_idx), w_i_gate, ctr_0_0));
    Tensor<double, 1> delta_i = zeta_o * tco(tCu, u_gate, ctr_0_0) * didq;
    Tensor<double, 1> dfdq = sigmoid_prime(tco(lambda.at(layer_idx), w_f_gate, ctr_0_0));
    Tensor<double, 1> delta_f = zeta_o * tco(tCu, prev_C, ctr_0_0) * dfdq;

    Tensor<double, 2> dhdWo = tco(delta_o, lambda.at(layer_idx), no_ctr);
    Tensor<double, 2> dhdWu = tco(delta_u, lambda.at(layer_idx), no_ctr);
    Tensor<double, 2> dhdWi = tco(delta_i, lambda.at(layer_idx), no_ctr);
    Tensor<double, 2> dhdWf = tco(delta_f, lambda.at(layer_idx), no_ctr);

    lstm_og_weights.at(layer_idx) -= dhdWo;
    lstm_ug_weights.at(layer_idx) -= dhdWu;
    lstm_ig_weights.at(layer_idx) -= dhdWi;
    lstm_fg_weights.at(layer_idx) -= dhdWf;

    Tensor<double, 1> delta_l;
    delta_l += tco(delta_o, w_o_gate, ctr_0_1);
    delta_l += tco(delta_u, w_u_gate, ctr_0_1);
    delta_l += tco(delta_i, w_i_gate, ctr_0_1);
    delta_l += tco(delta_f, w_f_gate, ctr_0_1);

    for (unsigned int i = cell_widths.at(layer_idx); i < input_sz; ++i) {
      ph(i - cell_widths.at(layer_idx)) = delta_l(i);
    }
  }
}

template <typename A>
LSTM::LSTM(unsigned int _layers,
  std::initializer_list<A> _cell_widths)
{
  std::random_device generator;
  std::uniform_real_distribution<double> ud(-1.0, 1.0);

  layers = _layers - 1;
  cell_widths = std::vector<unsigned int>(layers);

  for (unsigned int i = 0; i < layers; ++i) {
    cell_widths.at(i) = *(_cell_widths.begin() + i);
  }

  Cs = std::vector<Tensor<double, 1>>(layers);
  prev_Cs = std::vector<Tensor<double, 1>>(layers);

  output_list = std::vector<Tensor<double, 1>>(layers);
  prev_output_list = std::vector<Tensor<double, 1>>(layers);

  lstm_fg_weights = std::vector<Tensor<double, 2>>(layers);
  lstm_ig_weights = std::vector<Tensor<double, 2>>(layers);
  lstm_ug_weights = std::vector<Tensor<double, 2>>(layers);
  lstm_og_weights = std::vector<Tensor<double, 2>>(layers);

  lstm_f_gate = std::vector<Tensor<double, 1>>(layers);
  lstm_i_gate = std::vector<Tensor<double, 1>>(layers);
  lstm_u_gate = std::vector<Tensor<double, 1>>(layers);
  lstm_o_gate = std::vector<Tensor<double, 1>>(layers);

  zu = std::vector<Tensor<double, 1>>(layers);
  zo = std::vector<Tensor<double, 1>>(layers);

  lambda = std::vector<Tensor<double, 1>>(layers);

  for (unsigned int i = 0; i < layers; ++i) {
    Cs.at(i) = Tensor<double, 1>(cell_widths.at(i));
    prev_Cs.at(i) = Tensor<double, 1>(cell_widths.at(i));

    output_list.at(i) = Tensor<double, 1>(cell_widths.at(i));
    prev_output_list.at(i) = Tensor<double, 1>(cell_widths.at(i));

    lstm_fg_weights.at(i) = Tensor<double, 2>(cell_widths.at(i), cell_widths.at(i + 1));
    lstm_ig_weights.at(i) = Tensor<double, 2>(cell_widths.at(i), cell_widths.at(i + 1));
    lstm_ug_weights.at(i) = Tensor<double, 2>(cell_widths.at(i), cell_widths.at(i + 1));
    lstm_og_weights.at(i) = Tensor<double, 2>(cell_widths.at(i), cell_widths.at(i + 1));

    for (unsigned int j = 0; j < cell_widths.at(i) * cell_widths.at(i + 1); ++j) {
      lstm_fg_weights.at(i).coeffRef(j) = ud(generator);
      lstm_ig_weights.at(i).coeffRef(j) = ud(generator);
      lstm_ug_weights.at(i).coeffRef(j) = ud(generator);
      lstm_og_weights.at(i).coeffRef(j) = ud(generator);
    }

    lstm_f_gate.at(i) = Tensor<double, 1>(cell_widths.at(i));
    lstm_i_gate.at(i) = Tensor<double, 1>(cell_widths.at(i));
    lstm_u_gate.at(i) = Tensor<double, 1>(cell_widths.at(i));
    lstm_o_gate.at(i) = Tensor<double, 1>(cell_widths.at(i));

    zu.at(i) = Tensor<double, 1>(cell_widths.at(i));
    zo.at(i) = Tensor<double, 1>(cell_widths.at(i));

    unsigned int input_sz;
    if (i == 0) {
      input_sz = cell_widths.at(i);
    } else {
      input_sz = 2 * cell_widths.at(i);
    }
    lambda.at(i) = Tensor<double, 1>(input_sz);
  }
}
