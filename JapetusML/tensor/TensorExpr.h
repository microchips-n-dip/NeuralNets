#ifndef JAPETUS_TENSOR_EXPR_H
#define JAPETUS_TENSOR_EXPR_H

namespace Japetus {

namespace tensor {

template <typename BinaryOp, typename LeftXprType, typename RightXprType>
class TensorCWiseBinaryOp : public TensorBase<TensorCWiseBinaryOp<BinaryOp, LeftXprType, RightXprType>>
{
 public:
  TensorCWiseBinaryOp(BinaryOp& op, LeftXprType& leftImpl, RightXprType& rightImpl)
  {
    m_leftImpl = leftImpl;
    m_rightImpl = rightImpl;
    m_functor = op;
  }

  LeftXprType lhsExpression() const { return m_leftImpl; }
  RightXprType rhsExpression() const { return m_rightImpl; }
  BinaryOp functor() const { return m_functor; }

 private:
  LeftXprType m_leftImpl;
  RightXprType m_rightImpl;
  BinaryOp m_functor;
};

template <typename BinaryOp, typename LeftArgType, typename RightArgType>
struct TensorEvaluator<TensorCWiseBinaryOp<BinaryOp, LeftArgType, RightArgType>>
{
  typedef TensorCWiseBinaryOp<BinaryOp, LeftArgType, RightArgType> XprType;

  TensorEvaluator(XprType& op)
  {
    m_leftImpl = op.lhsExpression();
    m_rightImpl = op.rhsExpression();
    m_functor = op.functor();
  }

  bool evalSubExprsIfNeeded(CoeffReturnType*)
  {
    m_leftImpl.evalSubExprsIfNeeded(NULL);
    m_rightImpl.evalSubExprsIfNeeded(NULL);
    return true;
  }

  CoeffReturnType coeff(Index index) const
  { return m_functor(m_leftImpl.coeff(index), m_rightImpl.coeff(index)); }

  TensorEvaluator<LeftArgType> m_leftImpl;
  TensorEvaluator<RightArgType> m_rightImpl;
  BinaryOp m_functor;
};

}

}

#endif
