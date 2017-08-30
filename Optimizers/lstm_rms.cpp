#include "lstm_rms.h"
#include "tensorops.h"

using namespace Eigen;

// build_stack()
// Creates an unrolled network by looking at the cross-sections between timesteps
template <typename StateType, typename WeightType, typename FlowType>
void LSTM_RMSProp<StateType, WeightType, FlowType>::build_stack()
{
  postflow_data = std::vector<FlowType>(n_tsteps);

  state_stack = std::vector<StateType>(truncate);
  weight_stack = std::vector<WeightType>(truncate);

  cost_grad_stack = std::vector<FlowType>(truncate);

  for (unsigned int i = 0; i < n_tsteps; ++i) {
    postflow_data.at(i) = lstm.forward(preflow_data.at(i));
    // Now take the weights and states of the LSTM because we have a cross-section
    state_stack.emplace(state_stack.begin(), lstm.states);
    weight_stack.emplace(weight_stack.begin(), lstm.weights);
    state_stack.pop_back();
    weight_stack.pop_back();

    cost_grad_stack.emplace(cost_stack.begin(), \
      compute_cost_grad(postflow_data.at(i)));
    cost_grad_stack.pop_back();
  }
}

template <typename StateType, typename WeightType, typename FlowType>
void LSTM_RMSProp<StateType, WeightType, FlowType>::gradient()
{
  typedef typename StateType::State State;
  typedef typename WeightType::Weight Weight;

  std::array<IndexPair<int>, 0> no_ctr = {};
  std::array<IndexPair<int>, 1> ctr_0_0 = {IndexPair<int>(0, 0)};
  std::array<IndexPair<int>, 1> ctr_0_1 = {IndexPair<int>(0, 1)};

  build_stack();

  for (unsigned int i = lstm.layers - 1; i > 0; i--) {
    for (unsigned int j = 0; j < truncate; ++j) {
      State state = state_stack.at(j).at(i);
      Weight weight = weight_stack.at(j).at(i);
      FlowType cost_grad = cost_grad_stack.at(j);

      Tensor<double, 1> tC = tanh_prime(state.C);

      double zeta_o = tco(cost_grad, state.zo, ctr_0_0)(0);
      double zeta_u = tco(cost_grad, state.zu, ctr_0_0)(0);

      FlowType dodq = sigmoid_prime(tco(state.lambda, weight.o_gate, ctr_0_0));
      FlowType delta_o = zeta_u * dodq;
      FlowType dudq = tanh_prime(tco(state.lambda, weight.u_gate, ctr_0_0));
      FlowType delta_u = zeta_o * tco(tC, state.i_gate, ctr_0_0) * dudq;
      FlowType didq = sigmoid_prime(tco(state.lambda, weight.i_gate, ctr_0_0));
      FlowType delta_i = zeta_o * tco(tC, state.u_gate, ctr_0_0) * didq;
      FlowType dfdq = sigmoid_prime(tco(state.lambda, weight.f_gate, ctr_0_0));
      FlowType delta_f = zeta_o * tco(tC, state.prev_C, ctr_0_0) * dfdq;

      FlowType dhdWo = tco(delta_o, state.lambda, no_ctr);
      FlowType dhdWu = tco(delta_u, state.lambda, no_ctr);
      FlowType dhdWi = tco(delta_i, state.lambda, no_ctr);
      FlowType dhdWf = tco(delta_f, state.lambda, no_ctr);

      weight.o_gate -= dhdWo;
      weight.u_gate -= dhdWu;
      weight.i_gate -= dhdWi;
      weight.f_gate -= dhdWf;

      FlowType delta_l;
      delta_l += tco(delta_o, weight.o_gate, ctr_0_1);
      delta_l += tco(delta_u, weight.u_gate, ctr_0_1);
      delta_l += tco(delta_i, weight.i_gate, ctr_0_1);
      delta_l += tco(delta_f, weight.f_gate, ctr_0_1);

      for (unsigned int k = 0; k < lstm.cell_widths.at(i); ++k) {
        cost_grad_stack.at(j)(k) = delta_l(k);
      }

      lstm.weights.at(lstm.layers - i) = weight;
    }
  }
}

template <typename StateType, typename WeightType, typename FlowType>
LSTM& LSTM_RMSProp<StateType, WeightType, FlowType>::get_lstm() { return lstm; }

template <typename StateType, typename WeightType, typename FlowType>
LSTM_RMSProp<StateType, WeightType, FlowType>::LSTM_RMSProp(LSTM& lstm_)
{
  lstm = lstm_;

  preflow_data = std::vector<FlowType>(n_tsteps);
  postflow_data = std::vector<FlowType>(n_tsteps);

  state_stack = std::vector<StateType>(truncate);
  weight_stack = std::vector<WeightType>(truncate);
  cost_grad_stack = std::vector<FlowType>(truncate);
}
