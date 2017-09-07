#include "../inc/util.h"
#include "../inc/Graph.h"
#include "../inc/Scope.h"
#include "../inc/FunctorImpl.h"

using namespace Japetus;

int main(void)
{
  Scope scope = Scope::NewRootScope();

  auto n1 = scope.graph()->add_node(new PlaceholderFunctor, nullptr);
  auto n2 = scope.graph()->add_node(new PlaceholderFunctor, nullptr);
  auto h1 = hadamard_product(scope, n1, n2);
}
