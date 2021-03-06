#include "../inc/Scope.h"
#include "../inc/ScopeInternal.h"

namespace Japetus {

// Constructors and destructors
Scope::Scope(Impl* impl) : impl_(impl) { }
Scope::Scope(const Scope& other) : impl_(new Impl(*other.impl())) { }
Scope::~Scope() { }

// Equals overload
// Note that due to item constness some issues can arise with other configurations
Scope& Scope::operator=(const Scope& other)
{
  impl_.reset(new Impl(*other.impl()));
  return *this;
}

// Constructors for Scop Impl class
Scope::Impl::Impl(Graph* graph) :
  graph_(graph)
{ }

Scope::Impl::Impl(const std::shared_ptr<Graph>& graph) :
  graph_(graph)
{ }

// Create new root scope
Scope Scope::NewRootScope()
{
  Graph* graph = new Graph;
  return Scope(new Impl(graph));
}

// Get scope internal graph
Graph* Scope::graph() { return impl()->graph_.get(); }

}
