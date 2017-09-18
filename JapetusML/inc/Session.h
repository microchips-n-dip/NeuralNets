#ifndef JAPETUS_SESSION_H
#define JAPETUS_SESSION_H

#include <vector>

#include "../inc/Graph.h"
#include "../inc/Scope.h"

#include "../tensor/Tensor"

namespace Japetus {

typedef tensor::Tensor<double> Data;
typedef tensor::TensorRef<Data> DataRef;

// Session class
class Session
{
 public:
  // Recursively evaluate functors
  void recursive_evaluate(Node* node,
    DataRef* nli, int out_edge_id);
  // Run session from node
  void run(const Scope& scope, Node* entry,
    DataRef* outputs);

 private:
  Scope* w_scope;
  Node* w_entry;
};

}

#endif
