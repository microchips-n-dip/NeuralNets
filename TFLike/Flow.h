namespace Japetus {

using namespace Eigen;

struct GradientPathEvaluator
{
  // This is the gradient's path
  std::vector<Variable> gradient_seq;

  // Evaluate each variable in tree form until the gradient's path is found
  // Yes, I do mean to recopy the gradient list each time because I don't want nodes modifying eachother's lists!
  bool evaluate_next_var(const Variable& s,
    const Variable& f,
    const Variable& evaluate_var,
    int idx,
    std::vector<Variable> grads_list)
  {
    // Expand the tree
    grads_list.push_back(std::pair<Variable, int>(evaluate_var, \
      idx);

    // Case: ending conditions have been met
    if (evaluate_var == s) {
      gradient_seq = grads_list;
      return true;
    }

    // Case: ending conditions not met with further exploration possible
    if (evaluate_var.src_func) {
      std::vector<Variable&>::iterator var_it;
      std::vector<Variable&>::iterator b = evaluate_var.src_func->inputs.begin();
      std::vector<Variable&>::iterator e = evaluate_var.src_func->inputs.end();

      for (var_it = b; var_it < e; ++var_it) {
        int idx = var_it - b;
        bool c = evaluate_next_var(s, f, *var_it, idx, grads_list);
        if (c) return true;
      }
    }

    // Case: all else has failed, this node gives up
    return false;
  }

  std::vector<Variable> gradient(const Variable& s, const Variable& f)
  {
    Variable var = f;
    std::vector<Variable> grads_list;

    bool c = evaluate_next_var(s, f, var, grads_list);

    if (c) {
      return gradient_seq;
    }

    else {
      printf("ERROR: GRADIENT NOT FOUND - ANY FOLLOWING CALCULUS YOU DO WILL FAIL AND HENCE I WILL SELF-DESTRUCT\n");
      exit(1);
    }
  }
};

class FlowObject
{
  public:

  // Store a list of all variables
  // This is done mostly for future gradient checking
  std::vector<Variable> flow_vars;

  void gradient(const Variable& s, const Variable& f)
  {
    GradientPathEvaluator gpe;
    std::vector<Variable> path = gpe.gradient(s, f);

    for (auto var : path) {
      /* something */ = var.src_func.gradient();
    }
  }
};

}
