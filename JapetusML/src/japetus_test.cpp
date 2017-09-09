#include "../inc/util.h"
#include "../inc/Graph.h"
#include "../inc/Scope.h"
#include "../inc/FunctorImpl.h"
#include "../inc/Session.h"

using namespace Japetus;

int main(void)
{
  Scope scope = Scope::NewRootScope();

  auto n1 = scope.graph()->add_node(new ConstFunctor(3), nullptr);
  auto n2 = scope.graph()->add_node(new ConstFunctor(2), nullptr);
  auto n3 = scope.graph()->add_node(new ConstFunctor(4), nullptr);
  auto h1 = hadamard_product(scope, n1, n2);
  auto h2 = hadamard_product(scope, h1, n3);

  auto sess = Session();
  sess.run(scope, h2);
}
