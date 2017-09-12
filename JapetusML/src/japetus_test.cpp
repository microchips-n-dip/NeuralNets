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
  auto n4 = scope.graph()->add_node(new ConstFunctor(-5), nullptr);
  auto h1 = hadamard_product(scope, n1, n2);
  auto h2 = hadamard_product(scope, h1, n3);

  auto s1 = sigmoid(scope, h2);
  auto q1 = hadamard_quotient(scope, s1, n4);

  auto q2 = hadamard_quotient(scope, h1, n4);
  auto t1 = tanh(scope, q2);

  auto sess1 = Session();
  OutputType output1;
  sess1.run(scope, q1, &output1);

  auto sess2 = Session();
  OutputType output2;
  sess2.run(scope, t1, &output2);

  printf("Session 1 Output: %f\n", output1);
  printf("Session 2 Output: %f\n", output2);
}
