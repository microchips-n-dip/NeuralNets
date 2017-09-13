#include "../inc/util.h"
#include "../inc/Graph.h"
#include "../inc/Scope.h"
#include "../inc/FunctorImpl.h"
#include "../inc/Session.h"

using namespace Japetus;

int main(void)
{
  Scope scope = Scope::NewRootScope();

  // Create model
  auto n1 = constant(scope, 3);
  auto n2 = constant(scope, 2);
  auto n3 = constant(scope, 4);
  auto n4 = constant(scope, -5);
  auto h1 = hadamard_product(scope, n1, n2);
  auto h2 = hadamard_product(scope, h1, n3);

  auto s1 = sigmoid(scope, h2);
  auto q1 = hadamard_quotient(scope, s1, n4);
  s1 = sigmoid(scope, q1);

  auto q2 = hadamard_quotient(scope, h1, n4);
  auto t1 = tanh(scope, q2);

  // Create and run the first session
  auto sess1 = Session();
  OutputType output1;
  sess1.run(scope, s1, &output1);

  // Create and run the second session
  auto sess2 = Session();
  OutputType output2;
  sess2.run(scope, t1, &output2);

  // Create and run the third session
  auto sess3 = Session();
  OutputType output3;
  sess3.run(scope, h1, &output3);

  // Print the outputs
  printf("Session 1 Output: %f\n", output1);
  printf("Session 2 Output: %f\n", output2);
  printf("Session 3 Output: %f\n", output3);
}
