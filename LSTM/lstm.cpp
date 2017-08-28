#include "lstm.h"
#include "tensorops.h"

using namespace Eigen;

Tensor<double, 1> LSTM::forward(Tensor<double, 1> x)
{
  typedef LSTMStates<FlowType>::State State;
  typedef LSTMWeights<WeightType>::Weight Weight;

  std::array<IndexPair<int>, 1> ctr_0_0 = {IndexPair<int>(0, 0)};

  states.update_states();
  states.update_outputs();

  FlowType h = x;

  for (unsigned int layer_idx = 0; layer_idx < layers; ++layer_idx) {
    State state = states.at(i);
    Weight weight = weights.at(i);

    h = h.concatenate(state.prev_output);
    state.lambda = h;

    state.f_gate = sigmoid(tco(h, weight.f_gate, ctr_0_0));
    state.i_gate = sigmoid(tco(h, weight.i_gate, ctr_0_0));
    state.u_gate = sigmoid(tco(h, weight.u_gate, ctr_0_0));
    state.o_gate = sigmoid(tco(h, weight.o_gate, ctr_0_0));

    Tensor<double, 1> C;
    C = (state.prev_C * f_gate) + (i_gate * u_gate);
    state.C = C * o_gate;

    state.zu = C;
    state.zo = state.o_gate;

    h = tanh(C);
    state.output = h;

    states.states.at(i) = state;
  }

  return output_list.back();
}

template <typename A>
LSTM::LSTM(unsigned int layers_,
  std::initializer_list<A> cell_widths_)
{
  layers = layers_ - 1;

  states = LSTMStates(layers);
  weights = LSTMWeights(layers);
}
