namespace Japetus {

class GradientBuilder
{
  public:

  const Scope& scope;
  const ops::GradOpRegistry* registry_;
  const std::vector<Output>& outputs_;
  const std::vector<Output>& inputs_;
  const std::vector<Output>& grad_inputs_;
  std::vector<Output>* grad_outputs_;

  // A vector of output endpoints which represents backpropagated
  // gradients
  typedef std::vector<Output> BackpropedGradients;

  // backprops_ is a map from a node output to its accumulated
  // gradients. When a node output has accumulated all its
  // gradients,  we add a node which sums them up.
  std::unordered_map<Output, BackpropedGradients, OutputHash, OutputEq>
    backprops_;

  // pending[i] is count-down counter for i-th node's expected
  // backprops. When pending[i] becomes zero, we collected all
  // backprop gradients for the i-th node.
  std::vector<int> pending_;

  // ready_ keeps track of nodes that have been completely
  // backpropped. Initially for every output in outputs_, we add initial gradients
  // from grad_inputs_.
  std::deque<Node*> ready_;

  // The set of node ids in outputs_. Used to identify nodes at which to stop
  // backprop.
  std::unordered_set<int> output_nodes_;

  // The set of node ids in inputs_. Used to identify nodes at backprop
  // frontier. Maps from Output -> index into grad_outputs_.
  std::unordered_map<Output, int, OutputHash, OutputEq>
    input_nodes_;
};

}
