#ifndef JAPETUS_SCOPE_INTERNAL_H
#define JAPETUS_SCOPE_INTERNAL_H

#include "../inc/Scope.h"

namespace Japetus {

class Scope::Impl
{
 public:
  Impl(const std::shared_ptr<Graph>& graph);

  const std::string& name() const { return name_; }

 private:
  friend class Scope;

  std::shared_ptr<Graph> graph_;

  Impl(Graph* graph);

  const std::string name_ = "";
};

}

#endif
