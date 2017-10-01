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

  typedef TensorContractionOp<const IPs, const Tensor<double>, const Tensor<double>> Contraction;
  Contraction contraction(A, B, ctr);

  typedef TensorAssignOp<Tensor<double>, const Contraction> Assign;
  Assign assign(C, contraction);
  B.resize(TensorEvaluator<const Assign>(assign).dimensions());
  TensorExecutor<const Assign>::run(assign);
}
