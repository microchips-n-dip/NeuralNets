#include "Tensor"

using namespace Japetus;
using namespace Japetus::tensor;

int main(void)
{
  Tensor<double> A(3, 3);
  Tensor<double> B(3, 3);
  std::vector<std::pair<int, int>> ctr = { std::pair<int, int>(0, 0) };
  Tensor<double> C = A.contract(B, ctr);

  Tensor<double> D = C;
}
