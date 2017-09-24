#include "Tensor"

using namespace Japetus;
using namespace Japetus::tensor;

int main(void)
{
  Tensor<double> A(3, 3);
  Tensor<double> B(3, 3);
  Tensor<double> C = A * B;

  printf("n_dims() from B: %d\n", B.dimensions().n_dims());
  printf("n_dims() from C: %d\n", C.dimensions().n_dims());

  std::vector<std::pair<int, int>> ctr = {std::pair<int, int>(0, 0)};
  Tensor<double> D = C.contract(B, ctr);
  Tensor<double> E = D;
}
