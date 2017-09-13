#include <vector>
#include <type_traits>
#include "jt_util.h"
#include "TensorForwardDeclarations.h"
#include "TensorStorage.h"
#include "TensorBase.h"
#include "TensorExpr.h"
#include "TensorAssign.h"
#include "TensorExecutor.h"
#include "Tensor.h"

using namespace Japetus;
using namespace Japetus::tensor;

int main(void)
{
  Tensor<double> A(3, 3);
  Tensor<double> B = A;
}
