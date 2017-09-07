namespace Japetus {

template <typename VariableType, typename FunctorType>
struct GradientPathEvaluator
{
  typedef std::vector<NodeOut> BackpropedGradients;

  gtl::ArraySlice<NodeOut> y_node_outputs_;
  gtl::ArraySlice<NodeOut> x_node_outputs_;
  gtl::ArraySlice<NodeOut> y_grad_node_outputs_;
  /* no clue, some gtl implementation */
  BackpropedGradients* x_grad_node_outputs_;
  Graph* graph;

  std::unordered_map<NodeOut, BackpropedGradients, NodeOutHash, NodeOutEq>
    backprops_;

  void EdgeBackprop(
    const std::reference_wrapper<NodeOut> dst_grad,
    const std::reference_wrapper<NodeOut> src)
  {
    if (!src.node) {
      return;
    }

    auto iter = backprops_.find(src);
    if (iter != backprops_.end()) {
      auto* grads = &iter->second;
      grads->push_back(dst_grad);
      if (--pending_[src.node->id()] == 0) {
        ready_.push_back(src.node);
      }
    }
  }
};

}
