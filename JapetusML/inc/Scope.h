#ifndef JAPETUS_SCOPE_H
#define JAPETUS_SCOPE_H

#include <string>
#include "Graph.h"

namespace Japetus {

// Scope class
class Scope
{
 public:
  // Constructors and destructors
  Scope(const Scope& other);
  ~Scope();
  // Equals overload
  Scope& operator=(const Scope& other);

  // New root scope
  static Scope NewRootScope();

  // Get scope's graph
  Graph* graph();

  // Internal Impl class
  class Impl;
  // Get Impl item
  Impl* impl() { return impl_.get(); }
  // Get const Impl item
  const Impl* impl() const { return impl_.get(); }

 private:
  friend class InternalScope;
  std::unique_ptr<Impl> impl_; // Impl object
  explicit Scope(Impl*); // Explicit constructor from Impl
};

}

#endif
