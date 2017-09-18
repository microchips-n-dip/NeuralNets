#include "../inc/util.h"
#include "../tensor/Tensor"
#include "../inc/Graph.h"
#include "../inc/Scope.h"
#include "../inc/FunctorImpl.h"
#include "../inc/Session.h"

using namespace Japetus;

int main(void)
{
  Scope scope = Scope::NewRootScope();

  // Create model
  auto n1 = constant(scope, tensor::Tensor<double>(3, 3));
  auto n2 = constant(scope, tensor::Tensor<double>(3, 3));
  auto p1 = hadamard_product(scope, n1, n2);

  auto s1 = sigmoid(scope, p1);
  auto t1 = tanh(scope, p1);

  auto sess1 = Session();
  sess1.run(scope, s1, nullptr);

  auto sess2 = Session();
  sess2.run(scope, t1, nullptr);
}
