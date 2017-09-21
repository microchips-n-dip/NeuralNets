#include "Tensor"

using namespace Japetus;
using namespace Japetus::tensor;

int main(void)
{
  Tensor<double> A(3, 3);
  Tensor<double> B(3, 3);
  TensorRef<Tensor<double>> C = A * B;
  std::vector<std::pair<int, int>> ctr = {std::pair<int, int>(0, 0)};
  TensorRef<const TensorContractionOp<const std::vector<std::pair<int, int>>, const Tensor<double>, const Tensor<double>>> D = C.contract(B, ctr);
  Tensor<double> E = D;
}
