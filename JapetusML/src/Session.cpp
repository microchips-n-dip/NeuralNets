#include <stdio.h>
#include "../inc/Session.h"

namespace Japetus {

// Evaluate nodes recursively
// I still have to figure out how on earth tf does it
void Session::recursive_evaluate(
  Node* node,
  OutputType* nli,
  int out_edge_id)
{
  std::vector<InputType> inputs((*node->func()).in_size());
  std::vector<OutputType> outputs((*node->func()).out_size());
  for (auto edge : node->in_edges()) {
    recursive_evaluate(edge->src(),
      &(inputs.at(edge->dst_input())),
      edge->src_output());
  }
  (*node->func()).run(&inputs, &outputs);
  if (nli && outputs.size() > 0) {
    *nli = outputs.at(out_edge_id);
  }
}

// Run the session from a node
void Session::run(
  const Scope& scope,
  Node* entry,
  OutputType* outputs)
{
  w_scope = const_cast<Scope*>(&scope);
  w_entry = entry;

  recursive_evaluate(w_entry, outputs, 0);
}

}
