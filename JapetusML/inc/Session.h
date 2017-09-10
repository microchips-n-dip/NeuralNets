#ifndef JAPETUS_SESSION_H
#define JAPETUS_SESSION_H

#include <vector>

#include "../inc/Graph.h"
#include "../inc/Scope.h"

// Placeholder types
typedef double InputType;
typedef double OutputType;

namespace Japetus {

// Session class
class Session
{
 public:
  // Recursively evaluate functors
  void recursive_evaluate(Node* node,
    OutputType* nli, int out_edge_id);
  // Run session from node
  void run(const Scope& scope, Node* entry,
    OutputType* outputs);

 private:
  Scope* w_scope;
  Node* w_entry;
};

}

#endif
