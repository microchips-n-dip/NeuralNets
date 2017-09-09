#ifndef JAPETUS_SESSION_H
#define JAPETUS_SESSION_H

#include <vector>

#include "../inc/Graph.h"
#include "../inc/Scope.h"

typedef double InputType;
typedef double OutputType;

namespace Japetus {

class Session
{
 public:
  void recursive_evaluate(Node* node,
    OutputType* nli, int out_edge_id);
  void run(const Scope& scope, Node* entry,
    OutputType* outputs);

 private:
  Scope* w_scope;
  Node* w_entry;
};

}

#endif
