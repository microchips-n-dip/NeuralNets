#ifndef JAPETUS_FUNCTOR_IMPL_H
#define JAPETUS_FUNCTOR_IMPL_H

#include "../inc/Functor.h"
#include "../inc/Graph.h"
#include "../inc/Scope.h"

namespace Japetus {

template <typename FunctorType>
Node* gen_func_node(Scope& scope, std::vector<Node*> nodes, FunctorType func);

Node* sigmoid(Scope& scope, Node* node);
Node* tanh(Scope& scope, Node* node);
Node* hadamard_product(Scope& scope, Node* n1, Node* n2);

}

#endif
