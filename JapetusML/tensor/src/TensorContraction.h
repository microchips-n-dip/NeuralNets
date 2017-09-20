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
  typedef typename XprType::Indices Indices;
  typedef typename XprType::CoeffReturnType CoeffReturnType;

  TensorContractionEvaluatorBase(const XprType& op) :
    m_leftImpl(op.lhsExpression()),
    m_rightImpl(op.rhsExpression())
  {
    Indices eval_left_dims(LDims);
    Indices eval_right_dims(RDims);
    IndexPairs eval_op_indices(ContractDims);

    for (int i = 0; i < LDims; ++i) {
      eval_left_dims[i] = m_leftImpl.dimensions()[i];
    }
    for (int i = 0; i < RDims; ++i) {
      eval_right_dims[i] = m_rightImpl.dimensions()[i];
    }
    for (int i = 0; i < ContractDims; ++i) {
      eval_op_dims[i].first = op.indices()[i].first;
      eval_op_dims[i].second = op.indices()[i].second;
    }

    for (int i = 0; i < ContractDims; ++i) {
      for (int j = 0; j < ContractDims; ++j) {
        ECHECK(eval_op_indices[j].first != eval_op_indices[i].first &&
          eval_op_indices[j].second != eval_op_indices[i].second,
          "Contraction axes should be unique!");
        if (eval_op_indices[j].first < eval_op_indices[i].first) {
          std::swap(eval_op_indices[j], eval_op_indices[i]);
        }
      }
    }

    Indices lhs_strides(LDims);
    lhs_stides[0] = 1;
    for (int i = 0; i < LDims - 1; ++i) {
      lhs_stides[i + 1] = lhs_stides[i] * eval_left_dims[i];
    }

    Indices rhs_strides(RDims);
    rhs_strides[0] = 1;
    for (int i = 0; i < RDims - 1; ++i) {
      rhs_strides[i + 1] = rhs_strides * eval_right_dims[i];
    }

    m_i_strides = Indices(LDims);
    m_j_strides = Indices(RDims);
    m_k_strides = Indices(ContractDims);

    if (m_i_strides.size() > 0) m_i_strides[0] = 1;
    if (m_j_strides.size() > 0) m_j_strides[0] = 1;
    if (m_k_strides.size() > 0) m_k_strides[0] = 1;

    m_i_size = 1;
    m_j_size = 1;
    m_k_size = 1;

    int dim_idx = 0;
    unsigned int nocontract_idx;

    nocontract_idx = 0;
    for (int i = 0; i < LDims; ++i) {
      bool contracting = false;
      for (int j = 0; j < ContractDims; ++j) {
        if (eval_op_indices[j].first == i) {
          contracting = true;
          break;
        }
      }
      if (!contracting) {
        m_dimensions[dim_idx] = eval_left_dims[i];
        m_left_nocontract_stride[nocontract_idx] = lhs_strides[i];
        if (nocontract_idx + 1 < LDims - ContractDims) {
          m_i_strides[nocontract_idx + 1] =
            m_i_strides[nocontract_idx] * eval_left_dims[i];
        } else {
          m_i_size = m_i_strides[nocontract_idx] * eval_left_dims[i];
        }
        ++dim_idx;
        ++nocontract_idx;
      }
    }

    nocontract_idx = 0;
    for (int i = 0; i < RDims; ++i) {
      bool contracting = false;
      for (int j = 0; j < ContractDims; ++j) {
        if (eval_op_indices[j].second == i) {
          contracting = true;
          break;
        }
      }
      if (!contracting) {
        m_dimensions[dim_idx] = eval_right_dims[i];
        m_right_nocontract_stride[nocontract_idx] = rhs_strides[i];
        if (nocontract_idx + 1 < RDims - ContractDims) {
          m_j_strides[nocontract_idx + 1] =
            m_j_strides[nocontract_idx] * eval_right_dims[i];
        } else {
          m_j_size = m_j_strides[nocontract_idx] * eval_right_dims[i];
        }
        ++dim_idx;
        ++nocontract_idx;
      }
    }
  }
};

}

}

#endif
