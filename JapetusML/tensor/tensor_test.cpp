#include "Tensor"

using namespace Japetus;
using namespace Japetus::tensor;

int main(void)
{
  Tensor<double> A(3, 3);
  Tensor<double> B(3, 3);
  Tensor<double> C;

  typedef std::vector<std::pair<int, int>> IPs;
  IPs ctr(1);
  ctr[0] = std::pair<int, int>(0, 0);

  C = A.contract(B, ctr);
}
