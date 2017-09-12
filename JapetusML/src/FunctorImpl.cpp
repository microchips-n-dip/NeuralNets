#include "../inc/FunctorImpl.h"

namespace Japetus {

template <typename FunctorType>
Node* gen_func_node(Scope& scope, std::vector<Node*> nodes, FunctorType func)
{
  Node* ret = scope.graph()->add_node(func, nullptr);
  for (unsigned int i = 0; i < nodes.size(); ++i) {
    scope.graph()->add_edge(nodes.at(i), 0, ret, i);
  }
  return ret;
}

Node* sigmoid(Scope& scope, Node* n1)
{
  return gen_func_node(scope, std::vector<Node*>({n1}), new SigmoidFunctor);
}

Node* tanh(Scope& scope, Node* n1)
{
  return gen_func_node(scope, std::vector<Node*>({n1}), new TanhFunctor);
}

Node* hadamard_product(Scope& scope, Node* n1, Node* n2)
{
  return gen_func_node(scope, std::vector<Node*>({n1, n2}), new HadamardProductFunctor);
}

Node* hadamard_quotient(Scope& scope, Node* n1, Node* n2)
{
  return gen_func_node(scope, std::vector<Node*>({n1, n2}), new HadamardQuotientFunctor);
}

}
