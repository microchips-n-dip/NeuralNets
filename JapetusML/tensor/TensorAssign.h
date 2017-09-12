#ifndef JAPETUS_TENSOR_ASSIGN_H
#define JAPETUS_TENSOR_ASSIGN_H

namespace Japetus {

namespace tensor {

template <typename LeftXprType, typename RightXprType>
class TensorAssignOp : public TensorBase<TensorAssignOp<LeftXprType, RightXprType>>
{
 public:
  TensorAssignOp(const LeftXprType& leftImpl, const RightXprType& rightImpl)
  {
    m_leftImpl = leftImpl;
    m_rightImpl = rightImpl;
  }

  LeftXprType lhsExpression() const { return m_leftImpl; }
  RightXprType rhsExpression() const { return m_rightImpl; }

 private:
  LeftXprType m_leftImpl;
  RightXprType m_rightImpl;
};

template <typename LeftArgType, typename RightArgType>
struct TensorEvaluator<TensorAssignOp<LeftArgType, RightArgType>>
{
  typedef TensorAssignOp<LeftArgType, RightArgType> XprType;

  TensorEvaluator(const XprType& op)
  {
    m_leftImpl = op.lhsExpression();
    m_rightImpl = op.rhsExpression();
  }

  bool evalSubExprsIfNeeded(Scalar*)
  {
    m_leftImpl.evalSubExprsIfNeeded(NULL);
    return m_rightImpl.evalSubExprsIfNeeded(m_lefImpl.data());
  }

  void cleanup()
  {
    m_leftImpl.cleanup();
    m_rightImpl.cleanup();
  }

  void evalScalar(Index index)
  { m_lefImpl.coeffRef(index) = m_rightImpl.coeff(index); }

  CoeffReturnType coeff(Index index) const
  { return m_leftImpl.coeff(index); }

  TensorEvaluator<LeftArgType> m_leftImpl;
  TensorEvaluator<RightArgType> m_rightImpl;
};

}

}

#endif
