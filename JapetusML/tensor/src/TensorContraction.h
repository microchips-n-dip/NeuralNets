#ifndef JAPETUS_TENSOR_CONTRACTION_H
#define JAPETUS_TENSOR_CONTRACTION_H

namespace Japetus {

namespace tensor {

template <typename LhsXprType, typename RhsXprType>
struct traits<TensorContractionOp<LhsXprType, RhsXprType>>
{
  typedef typename ScalarBinaryOpTraits<
    typename remove_all<typename LhsXprType::Scalar>::type,
    typename remove_all<typename RhsXprType::Scalar>::type
  >::ReturnType Scalar;

  typedef typename promote_index_type<
    typename LhsXprType::Index,
    typename RhsXprType::Index
  >::type Index;
  typedef typename promote_indices_type<
    typename LhsXprType::Indices,
    typename RhsXprType::Indices
  >::type Indices;

  enum {
    Flags = 0
  };
};

template <typename IndexPairs, typename LhsXprType, typename RhsXprType>
class TensorContractionOp : public TensorBase<TensorContractionOp<LhsXprType, RhsXprType>>
{
 public:
  typedef traits<TensorContractionOp> Traits;
  typedef typename Traits::Scalar Scalar;
  typedef typename Traits::Index Index;
  typedef typename Traits::Indices Indices;

  TensorContractionOp(const LhsXprType& leftImpl, const RhsXprType& rightImpl, const IndexPairs& contract_indices) :
    m_leftImpl(leftImpl),
    m_rightImpl(rightImpl),
    m_contract_indices(contract_indices)
  { }

  const typename remove_all<LhsXprType>::type& lhsExpression() const { return m_leftImpl; }

  const typename remove_all<RhsXprType>::type& rhsExpression() const { return m_rightImpl; }

 protected:
  IndexPairs m_contract_indices;
  LhsXprType m_leftImpl;
  RhsXprType m_rightImpl;
};

template <typename IndexPairs_, typename LeftArgType_, typename RightArgType_>
struct traits<TensorEvaluator<const TensorContractionOp<IndexPairs_, LeftArgType_, RightArgType_>>>
{
  typedef IndexPairs_ IndexPairs;
  typedef LeftArgType_ LeftArgType;
  typedef RightArgType_ RightArgType;
};

template <typename Derived>
struct TensorContractionEvaluatorBase
{
  typedef traits<Derived> Traits;
  typedef Traits::IndexPairs IndexPairs;
  typedef Traits::LeftArgType LeftArgType;
  typedef Traits::RightArgType RightArgType;

  typedef TensorContractionOp<IndexPairs, LeftArgType, RightArgType> XprType;
  typedef typename remove_all<typename XprType::Scalar>::type Scalar;
  typedef typename XprType::Index Index;
  
};

}

}

#endif
