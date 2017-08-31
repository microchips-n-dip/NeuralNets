#ifndef JAPETUS_FLOW_H
#define JAPETUS_FLOW_H

namespace Japetus {

using namespace Eigen;

template <typename VariableType, typename FunctorType>
struct GradientPathEvaluator
{
  // This is the gradient's path
  std::vector<std::pair<VariableType&, int>> gradient_seq;

  // Evaluate each variable in tree form until the gradient's path is found
  // Yes, I do mean to recopy the gradient list each time because I don't want nodes modifying eachother's lists!
  bool evaluate_next_var(const VariableType& s,
    const VariableType& f,
    const VariableType& evaluate_var,
    int idx,
    std::vector<VariableType&> grads_list)
  {
    // Expand the tree
    grads_list.push_back(std::pair<VariableType&, int> \
      (evaluate_var, idx));

    // Case: ending conditions have been met
    if (evaluate_var == s) {
      gradient_seq = grads_list;
      return true;
    }

    FunctorType* sf = evaluate_var.src_func;

    // Case: ending conditions not met with further exploration possible
    if (sf) {
      std::vector<VariableType&>::iterator var_it;
      std::vector<VariableType&>::iterator b = sf->inputs.begin();
      std::vector<VariableType&>::iterator e = sf->inputs.end();

      for (var_it = b; var_it < e; ++var_it) {
        int idx = var_it - b;
        bool c = evaluate_next_var(s, f, *var_it, idx, grads_list);
        if (c) return true;
      }
    }

    // Case: all else has failed, this node gives up
    return false;
  }

  std::vector<VariableType&> gradient(const VariableType& s, const VariableType& f)
  {
    VariableType& var = f;
    std::vector<VariableType&> grads_list;

    bool c = evaluate_next_var(s, f, var, 0, grads_list);

    if (c) {
      return gradient_seq;
    }

    else {
      printf("ERROR: GRADIENT NOT FOUND - ANY FOLLOWING CALCULUS YOU DO WILL \
        FAIL AND HENCE I WILL SELF-DESTRUCT\n");
      exit(1);
    }
  }
};

template <typename VariableType, typename FunctorType>
class FlowObject
{
  public:

  // Store a list of all variables
  // This is done mostly for future gradient checking
  std::vector<VariableType&> flow_vars;

  void gradient(const VariableType& s, const VariableType& f)
  {
    GradientPathEvaluator<VariableType, FunctorType> gpe;
    std::vector<VariableType&> path = gpe.gradient(s, f);

    for (auto var : path) {
      /* something */ = var.src_func.gradient();
    }
  }
};

}

#endif
