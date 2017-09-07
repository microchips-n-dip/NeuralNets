#ifndef JAPETUS_SCOPE_H
#define JAPETUS_SCOPE_H

#include <string>
#include "Graph.h"

namespace Japetus {

class Scope
{
 public:
  Scope(const Scope& other);
  ~Scope();
  Scope& operator=(const Scope& other);

  static Scope NewRootScope();

  Graph* graph();

  class Impl;
  Impl* impl() { return impl_.get(); }
  const Impl* impl() const { return impl_.get(); }

 private:
  friend class InternalScope;
  std::unique_ptr<Impl> impl_;
  explicit Scope(Impl*);
};

}

#endif
