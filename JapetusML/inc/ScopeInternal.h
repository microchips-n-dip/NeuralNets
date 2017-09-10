#ifndef JAPETUS_SCOPE_INTERNAL_H
#define JAPETUS_SCOPE_INTERNAL_H

#include "../inc/Scope.h"

namespace Japetus {

// Scope::Impl class
class Scope::Impl
{
 public:
  // Constructor
  Impl(const std::shared_ptr<Graph>& graph);

  // Get name
  const std::string& name() const { return name_; }

 private:
  friend class Scope;

  // Graph object
  std::shared_ptr<Graph> graph_;

  // Constructor from graph
  Impl(Graph* graph);

  // Name
  const std::string name_ = "";
};

}

#endif
