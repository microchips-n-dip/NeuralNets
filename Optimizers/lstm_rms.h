using namespace Eigen;

template <typename StateType, typename WeightType, typename FlowType>
class LSTM_RMSProp
{
  public:

  const int n_tsteps;
  const int truncate;

  std::vector<StateType> state_stack;
  std::vector<WeightType> weight_stack;

  std::vector<FlowType> preflow_data;
  std::vector<FlowType> postflow_data;

  std::vector<FlowType> cost_grad_stack;

  void build_stack();
  void gradients();
};
