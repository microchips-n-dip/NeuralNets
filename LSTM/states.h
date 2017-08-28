#ifndef LSTM_STATES_H
#define LSTM_STATES_H

template <typename FlowType>
class LSTMState
{
  public:

  FlowType f_gate;
  FlowType i_gate;
  FlowType u_gate;
  FlowType o_gate;

  FlowType C;
  FlowType prev_C;

  FlowType output;
  FlowType prev_output;

  FlowType zu;
  FlowType zo;

  FlowType lambda;

  LSTMState(unsigned int cell_width)
  {
    f_gate = FlowType(cell_width);
    i_gate = FlowType(cell_width);
    u_gate = FlowType(cell_width);
    o_gate = FlowType(cell_width);

    C = FlowType(cell_width);
    prev_C = FlowType(cell_width);

    output = FlowType(cell_width);
    prev_output = FlowType(cell_width);

    zu = FlowType(cell_width);
    zo = FlowType(cell_width);

    lambda = FlowType(cell_width);
  }
};

template <typename FlowType>
class LSTMStates
{
  public:

  typedef LSTMState<FlowType> State;
  std::vector<State> states;

  State& at(unsigned int idx)
  { return states.at(idx); }

  template <typename A>
  LSTMStates(unsigned int layers,
    std::initializer_list<A> cell_widths)
  {
    states.reserve(layers);

    std::initializer_list<A>::iterator it;
    for (it = cell_widths.begin(); it < cell_widths.end(); ++it) {
      states.push_back(State(*it));
    }
  }
};

#endif
