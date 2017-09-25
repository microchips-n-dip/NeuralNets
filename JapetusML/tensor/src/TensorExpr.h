#ifndef JAPETUS_TENSOR_EXPR_H
#define JAPETUS_TENSOR_EXPR_H

namespace Japetus {

namespace tensor {

template <typename UnaryOp, typename XprType>
struct traits<TensorCWiseUnaryOp<UnaryOp, XprType>> :
  public traits<XprType>
{
  typedef typename std::result_of<
    UnaryOp(typename XprType::Scalar)
  >::type Scalar;
  typedef traits<XprType> XprTraits;
};

template <typename UnaryOp, typename XprType>
struct nested<TensorCWiseUnaryOp<UnaryOp, XprType>>
{
  typedef TensorCWiseUnaryOp<UnaryOp, XprType> type;
};

template <typename UnaryOp, typename XprType>
class TensorCWiseUnaryOp : public TensorBase<TensorCWiseUnaryOp<UnaryOp, XprType>>
{
 public:
  typedef traits<TensorCWiseUnaryOp> Traits;
  typedef typename Traits::Scalar Scalar;
  typedef typename Traits::Index Index;
  typedef typename Traits::Indices Indices;

  typedef typename nested<TensorCWiseUnaryOp>::type Nested;

  TensorCWiseUnaryOp(const XprType& impl, const UnaryOp& op) :
    m_impl(impl),
    m_functor(op)
  { }

  const UnaryOp& functor() const { return m_functor; }

  const typename remove_all<XprType>::type& nestedExpression() const { return m_impl; }

 private:
  typename XprType::Nested m_impl;
  const UnaryOp m_functor;
};

template <typename UnaryOp, typename ArgType>
struct TensorEvaluator<const TensorCWiseUnaryOp<UnaryOp, ArgType>>
{
  typedef TensorCWiseUnaryOp<UnaryOp, ArgType> XprType;
  typedef typename XprType::Scalar Scalar;
  typedef typename XprType::Index Index;
  typedef typename traits<XprType>::Scalar CoeffReturnType;
  typedef typename TensorEvaluator<ArgType>::Dimensions Dimensions;

  TensorEvaluator(const XprType& op) :
    m_functor(op.functor()),
    m_impl(op.nestedExpression())
  { }

  const Dimensions& dimensions() const { return m_impl.dimensions(); }

  bool evalSubExprsIfNeeded(Scalar*)
  {
    m_impl.evalSubExprsIfNeeded(nullptr);
    return true;
  }

  void cleanup() { m_impl.cleanup(); }

  CoeffReturnType coeff(Index index) const
  { return m_functor(m_impl.coeff(index)); }

  CoeffReturnType* data() const { return nullptr; }

  const UnaryOp m_functor;
  TensorEvaluator<ArgType> m_impl;
};

template <typename BinaryOp, typename LeftXprType, typename RightXprType>
struct traits<TensorCWiseBinaryOp<BinaryOp, LeftXprType, RightXprType>>
{
  typedef typename std::result_of<
    BinaryOp(typename LeftXprType::Scalar,
             typename RightXprType::Scalar)
  >::type Scalar;

  typedef typename promote_index_type<
    typename traits<LeftXprType>::Index,
    typename traits<RightXprType>::Index
  >::type Index;
  typedef typename promote_indices_type<
    typename traits<LeftXprType>::Indices,
    typename traits<RightXprType>::Indices
  >::type Indices;

  enum {
    Flags = 0
  };
};

template <typename BinaryOp, typename LeftXprType, typename RightXprType>
struct nested<TensorCWiseBinaryOp<BinaryOp, LeftXprType, RightXprType>>
{
  typedef TensorCWiseBinaryOp<BinaryOp, LeftXprType, RightXprType> type;
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

  typedef typename nested<TensorCWiseBinaryOp>::type Nested;

  TensorCWiseBinaryOp(const LeftXprType& leftImpl, const RightXprType& rightImpl, const BinaryOp& op) :
    m_leftImpl(leftImpl),
    m_rightImpl(rightImpl),
    m_functor(op)
  { }

  const typename remove_all<LeftXprType>::type& lhsExpression() const { return m_leftImpl; }
  const typename remove_all<RightXprType>::type& rhsExpression() const { return m_rightImpl; }
  const BinaryOp& functor() const { return m_functor; }

 private:
  typename LeftXprType::Nested m_leftImpl;
  typename RightXprType::Nested m_rightImpl;
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

  CoeffReturnType* data() const { return nullptr; }

  TensorEvaluator<LeftArgType> m_leftImpl;
  TensorEvaluator<RightArgType> m_rightImpl;
  const BinaryOp m_functor;
};

}

}

#endif
