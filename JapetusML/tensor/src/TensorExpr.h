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

  TensorCWiseBinaryOp(const LeftXprType& leftImpl, const RightXprType& rightImpl, const BinaryOp& op) :
    m_leftImpl(leftImpl),
    m_rightImpl(rightImpl),
    m_functor(op)
  { }

  const typename remove_all<LeftXprType>::type& lhsExpression() const { return m_leftImpl; }
  const typename remove_all<RightXprType>::type& rhsExpression() const { return m_rightImpl; }
  const BinaryOp& functor() const { return m_functor; }

 private:
  LeftXprType m_leftImpl;
  RightXprType m_rightImpl;
  const BinaryOp m_functor;
};

template <typename BinaryOp, typename LeftArgType, typename RightArgType>
struct TensorEvaluator<const TensorCWiseBinaryOp<BinaryOp, LeftArgType, RightArgType>>
{
  typedef TensorCWiseBinaryOp<BinaryOp, LeftArgType, RightArgType> XprType;
  typedef typename XprType::Scalar Scalar;
  typedef typename traits<XprType>::Scalar CoeffReturnType;
  typedef typename XprType::Index Index;
  typedef typename TensorEvaluator<LeftArgType>::Dimensions Dimensions;

  TensorEvaluator(const XprType& op) :
    m_leftImpl(op.lhsExpression()),
    m_rightImpl(op.rhsExpression()),
    m_functor(op.functor())
  { }

  void cleanup() { }

  bool evalSubExprsIfNeeded(CoeffReturnType*)
  {
    m_leftImpl.evalSubExprsIfNeeded(nullptr);
    m_rightImpl.evalSubExprsIfNeeded(nullptr);
    return true;
  }

  CoeffReturnType coeff(Index index) const
  { return m_functor(m_leftImpl.coeff(index), m_rightImpl.coeff(index)); }

  const Dimensions& dimensions() const { return m_leftImpl.dimensions(); }

  TensorEvaluator<LeftArgType> m_leftImpl;
  TensorEvaluator<RightArgType> m_rightImpl;
  const BinaryOp m_functor;
};

}

}

#endif
