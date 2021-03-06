#ifndef JAPETUS_TENSOR_ASSIGN_H
#define JAPETUS_TENSOR_ASSIGN_H

namespace Japetus {

namespace tensor {

template <typename LeftXprType, typename RightXprType>
struct traits<TensorAssignOp<LeftXprType, RightXprType>>
{
  typedef typename LeftXprType::Scalar Scalar;
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

template <typename LeftXprType, typename RightXprType>
struct nested<TensorAssignOp<LeftXprType, RightXprType>>
{
  typedef TensorAssignOp<LeftXprType, RightXprType> type;
};

template <typename LeftXprType, typename RightXprType>
class TensorAssignOp : public TensorBase<TensorAssignOp<LeftXprType, RightXprType>>
{
 public:
  typedef traits<TensorAssignOp> Traits;
  typedef typename Traits::Scalar Scalar;
  typedef Scalar CoeffReturnType;
  typedef typename Traits::Index Index;
  typedef typename Traits::Indices Indices;

  typedef typename nested<TensorAssignOp>::type Nested;

  TensorAssignOp(LeftXprType& leftImpl, const RightXprType& rightImpl) :
    m_leftImpl(leftImpl),
    m_rightImpl(rightImpl)
  { }

  typename remove_all<typename LeftXprType::Nested>::type& lhsExpression() const
  { return *((typename remove_all<typename LeftXprType::Nested>::type*)&m_leftImpl); }
  const typename remove_all<typename RightXprType::Nested>::type& rhsExpression() const { return m_rightImpl; }

 private:
  typename remove_all<typename LeftXprType::Nested>::type& m_leftImpl;
  const typename remove_all<typename RightXprType::Nested>::type& m_rightImpl;
};

template <typename LeftArgType, typename RightArgType>
struct TensorEvaluator<const TensorAssignOp<LeftArgType, RightArgType>>
{
  typedef TensorAssignOp<LeftArgType, RightArgType> XprType;
  typedef typename XprType::Scalar Scalar;
  typedef typename XprType::CoeffReturnType CoeffReturnType;
  typedef typename XprType::Index Index;
  typedef typename TensorEvaluator<RightArgType>::Dimensions Dimensions;

  TensorEvaluator(const XprType& op) :
    m_leftImpl(op.lhsExpression()),
    m_rightImpl(op.rhsExpression())
  { }

  bool evalSubExprsIfNeeded(Scalar*)
  {
    m_leftImpl.evalSubExprsIfNeeded(nullptr);
    return m_rightImpl.evalSubExprsIfNeeded(m_leftImpl.data());
  }

  void cleanup()
  {
    m_leftImpl.cleanup();
    m_rightImpl.cleanup();
  }

  const Dimensions& dimensions() const { return m_rightImpl.dimensions(); }

  void evalScalar(Index index)
  { m_leftImpl.coeffRef(index) = m_rightImpl.coeff(index); }

  CoeffReturnType coeff(Index index) const
  { return m_leftImpl.coeff(index); }

  CoeffReturnType* data() const { return m_leftImpl.data(); }

  TensorEvaluator<LeftArgType> m_leftImpl;
  TensorEvaluator<RightArgType> m_rightImpl;
};

}

}

#endif
