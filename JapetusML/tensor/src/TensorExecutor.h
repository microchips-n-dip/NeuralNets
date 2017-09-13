#ifndef JAPETUS_TENSOR_EXECUTOR_H
#define JAPETUS_TENSOR_EXECUTOR_H

namespace Japetus {

namespace tensor {

template <typename Expression>
struct TensorExecutor
{
  typedef typename Expression::Index Index;
  static inline void run(const Expression& expr)
  {
    TensorEvaluator<Expression> evaluator(expr);
    const bool needs_assign = evaluator.evalSubExprsIfNeeded(nullptr);
    if (needs_assign) {
      for (Index i = 0; i < evaluator.total_size(); ++i) {
        evalScalar(i);
      }
    }
    evaluator.cleanup();
  }
};

}

}

#endif
