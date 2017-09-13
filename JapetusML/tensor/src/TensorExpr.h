#ifndef JAPETUS_TENSOR_EXPR_H
#define JAPETUS_TENSOR_EXPR_H

namespace Japetus {

namespace tensor {

template <typename BinaryOp, typename LeftXprType, typename RightXprType>
struct traits<TensorCWiseBinaryOp<BinaryOp, LeftXprType, RightXprType>>
{
  typedef typename std::result_of<
    BinaryOp(typename LeftXprType::Scalar,
             typename RightXprType::Scalar)>::type Scalar;
  // For indical promotion, will probably naevly assume some index type
  typedef typename promote_index_type<
    typename traits<LeftXprType>::Index,
    typename traits<RightXprType>::Index>::type Index;
  typedef typename promote_indices_type<
    typename traits<LeftXprType>::Indices,
    typename traits<RightXprType>::Indices>::type Indices;
};

template <typename BinaryOp, typename LeftXprType, typename RightXprType>
class TensorCWiseBinaryOp : public TensorBase<TensorCWiseBinaryOp<BinaryOp, LeftXprType, RightXprType>>
{
 public:
  typedef traits<TensorCWiseBinaryOp> Traits;
  typedef typename Traits::Scalar Scalar;
  typedef Scalar CoeffReturnType;
  typedef typename Traits::Index Index;
  typedef typename Traits::Indices Indices;

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
  typedef typename XprType::CoeffReturnType CoeffReturnType;
  typedef typename XprType::Index Index;

  TensorEvaluator(XprType& op)
  {
    m_leftImpl = op.lhsExpression();
    m_rightImpl = op.rhsExpression();
    m_functor = op.functor();
  }

  bool evalSubExprsIfNeeded(CoeffReturnType*)
  {
    m_leftImpl.evalSubExprsIfNeeded(nullptr);
    m_rightImpl.evalSubExprsIfNeeded(nullptr);
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
