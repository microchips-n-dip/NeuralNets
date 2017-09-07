#ifndef JAPETUS_FLOW_H
#define JAPETUS_FLOW_H

namespace Japetus {

#ifdef EIGEN
using namespace Eigen;
#endif

template <typename VariableType, typename FunctorType>
struct GradientPathEvaluator
{
  // This is the gradient's path
  std::vector<std::pair<std::reference_wrapper<VariableType>, int>> gradient_seq;

  // Evaluate each variable in tree form until the gradient's path is found
  // Yes, I do mean to recopy the gradient list each time because I don't want nodes modifying eachother's lists!
  bool evaluate_next_var(
    const std::reference_wrapper<VariableType> s,
    const std::reference_wrapper<VariableType> f,
    const std::reference_wrapper<VariableType> evaluate_var,
    std::vector<std::reference_wrapper<VariableType>> grads_list,
    int idx)
  {
    // Expand the tree
    grads_list.push_back(std::pair<std::reference_wrapper<VariableType>, int> \
      (evaluate_var, idx));

    // Case: ending conditions have been met
    if (evaluate_var == s) {
      gradient_seq = grads_list;
      return true;
    }

    FunctorType* sf = evaluate_var.src_func;

    // Case: ending conditions not met with further exploration possible
    if (sf) {
      typename std::vector<std::reference_wrapper<VariableType>>::iterator var_it;
      typename std::vector<std::reference_wrapper<VariableType>>::iterator b = sf->inputs.begin();
      typename std::vector<std::reference_wrapper<VariableType>>::iterator e = sf->inputs.end();

      for (var_it = b; var_it < e; ++var_it) {
        int idx = var_it - b;
        bool c = evaluate_next_var(s, f, *var_it, grads_list, idx);
        if (c) return true;
      }
    }

    // Case: all else has failed, this node gives up
    return false;
  }

  std::vector<std::reference_wrapper<VariableType>> gradient(
    const std::reference_wrapper<VariableType> s,
    const std::reference_wrapper<VariableType> f)
  {
    std::reference_wrapper<VariableType> var = f;
    std::vector<std::reference_wrapper<VariableType>> grads_list;

    bool c = evaluate_next_var(s, f, var, grads_list, 0);

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
class Flow
{
  public:

  // Store a list of all variables
  // This is done mostly for future gradient checking
  std::vector<std::reference_wrapper<VariableType>> flow_vars;

  void gradient(
    const std::reference_wrapper<VariableType> s,
    const std::reference_wrapper<VariableType> f)
  {
    GradientPathEvaluator<VariableType, FunctorType> gpe;
    std::vector<std::reference_wrapper<VariableType>> path = gpe.gradient(s, f);

    for (std::reference_wrapper<VariableType> var : path) {
      auto var_ = var.src_func.gradient();
    }
  }
};

}

#endif
