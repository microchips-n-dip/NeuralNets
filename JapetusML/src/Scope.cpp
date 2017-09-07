#include "../inc/Scope.h"
#include "../inc/ScopeInternal.h"

namespace Japetus {

Scope::Scope(Impl* impl) : impl_(impl) { }
Scope::Scope(const Scope& other) : impl_(new Impl(*other.impl())) { }
Scope::~Scope() { }

Scope& Scope::operator=(const Scope& other)
{
  impl_.reset(new Impl(*other.impl()));
  return *this;
}

Scope::Impl::Impl(Graph* graph) :
  graph_(graph)
{ }

Scope::Impl::Impl(const std::shared_ptr<Graph>& graph) :
  graph_(graph)
{ }

Scope Scope::NewRootScope()
{
  Graph* graph = new Graph;
  return Scope(new Impl(graph));
}

Graph* Scope::graph() { return impl()->graph_.get(); }

}
