#include "Tensor"

using namespace Japetus;
using namespace Japetus::tensor;

int main(void)
{
  Tensor<double> A(3, 3);
  Tensor<double> B(3, 3);
  TensorRef<Tensor<double>> C = A * B;
}
