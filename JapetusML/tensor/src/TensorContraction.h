#ifndef JAPETUS_TENSOR_CONTRACTION_H
#define JAPETUS_TENSOR_CONTRACTION_H

namespace Japetus {

namespace tensor {

template <typename IndexPairs, typename LhsXprType, typename RhsXprType>
struct traits<TensorContractionOp<IndexPairs, LhsXprType, RhsXprType>>
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
class TensorContractionOp : public TensorBase<TensorContractionOp<IndexPairs, LhsXprType, RhsXprType>>
{
 public:
  typedef traits<TensorContractionOp> Traits;
  typedef typename Traits::Scalar Scalar;
  typedef typename Traits::Index Index;
  typedef typename Traits::Indices Indices;

  typedef Scalar CoeffReturnType;

  TensorContractionOp(const LhsXprType& leftImpl, const RhsXprType& rightImpl, const IndexPairs& contract_indices) :
    m_leftImpl(leftImpl),
    m_rightImpl(rightImpl),
    m_contract_indices(contract_indices)
  { }

  const typename remove_all<LhsXprType>::type& lhsExpression() const { return m_leftImpl; }

  const typename remove_all<RhsXprType>::type& rhsExpression() const { return m_rightImpl; }

  const IndexPairs indices() const { return m_contract_indices; }

 protected:
  IndexPairs m_contract_indices;
  const LhsXprType& m_leftImpl;
  const RhsXprType& m_rightImpl;
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
  typedef typename remove_const<typename Traits::IndexPairs>::type IndexPairs;
  typedef typename Traits::LeftArgType LeftArgType;
  typedef typename Traits::RightArgType RightArgType;

  typedef TensorContractionOp<const IndexPairs, LeftArgType, RightArgType> XprType;
  typedef typename remove_all<typename XprType::Scalar>::type Scalar;
  typedef typename XprType::Index Index;
  typedef typename XprType::Indices Indices;
  typedef typename XprType::CoeffReturnType CoeffReturnType;

  typedef typename remove_const<typename LeftArgType::Dimensions>::type Dimensions;

  int LDims;
  int RDims;
  int ContractDims;

  TensorContractionEvaluatorBase(const XprType& op) :
    m_leftImpl(op.lhsExpression()),
    m_rightImpl(op.rhsExpression())
  {
    LDims = m_leftImpl.dimensions().n_dims();
    RDims = m_rightImpl.dimensions().n_dims();
    ContractDims = op.indices().size();

    printf("LDims: %d\n", LDims);
    printf("RDims: %d\n", RDims);

    Indices eval_left_dims(LDims);
    Indices eval_right_dims(RDims);
    IndexPairs eval_op_indices(ContractDims);

    Indices next_dims(LDims + RDims - 2 * ContractDims);

    for (int i = 0; i < LDims; ++i) {
      eval_left_dims[i] = m_leftImpl.dimensions()[i];
    }
    for (int i = 0; i < RDims; ++i) {
      eval_right_dims[i] = m_rightImpl.dimensions()[i];
    }
    for (int i = 0; i < ContractDims; ++i) {
      eval_op_indices[i].first = op.indices()[i].first;
      eval_op_indices[i].second = op.indices()[i].second;
    }

    for (int i = 0; i < ContractDims; ++i) {
      for (int j = i + 1; j < ContractDims; ++j) {
        ECHECK(eval_op_indices[j].first != eval_op_indices[i].first &&
          eval_op_indices[j].second != eval_op_indices[i].second,
          "Contraction axes should be unique!");
        if (eval_op_indices[j].first < eval_op_indices[i].first) {
          std::swap(eval_op_indices[j], eval_op_indices[i]);
        }
      }
    }

    Indices lhs_strides(LDims);
    lhs_strides[0] = 1;
    for (int i = 0; i < LDims - 1; ++i) {
      lhs_strides[i + 1] = lhs_strides[i] * eval_left_dims[i];
    }

    Indices rhs_strides(RDims);
    rhs_strides[0] = 1;
    for (int i = 0; i < RDims - 1; ++i) {
      rhs_strides[i + 1] = rhs_strides[i] * eval_right_dims[i];
    }

    m_i_strides = Indices(LDims - ContractDims);
    m_j_strides = Indices(RDims - ContractDims);
    m_k_strides = Indices(ContractDims);

    if (m_i_strides.size() > 0) m_i_strides[0] = 1;
    if (m_j_strides.size() > 0) m_j_strides[0] = 1;
    if (m_k_strides.size() > 0) m_k_strides[0] = 1;

    m_i_size = 1;
    m_j_size = 1;
    m_k_size = 1;

    int dim_idx = 0;
    unsigned int nocontract_idx;

    m_left_nocontract_strides = Indices(LDims - ContractDims);
    m_right_nocontract_strides = Indices(RDims - ContractDims);

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
        next_dims[dim_idx] = eval_left_dims[i];
        m_left_nocontract_strides[nocontract_idx] = lhs_strides[i];
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
        next_dims[dim_idx] = eval_right_dims[i];
        m_right_nocontract_strides[nocontract_idx] = rhs_strides[i];
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
    m_dimensions = Dimensions(next_dims);

    m_left_contracting_strides = Indices(ContractDims);
    m_right_contracting_strides = Indices(ContractDims);

    for (int i = 0; i < ContractDims; ++i) {
      Index left = eval_op_indices[i].first;
      Index right = eval_op_indices[i].second;

      Index size = eval_left_dims[left];
      ECHECK(size == eval_right_dims[right], "Contraction axes must be same size!");

      if (i + 1 < static_cast<int>(ContractDims)) {
        m_k_strides[i + 1] = m_k_strides[i] * size;
      } else {
        m_k_size = m_k_strides[i] * size;
      }
      m_left_contracting_strides[i] = lhs_strides[left];
      m_right_contracting_strides[i] = rhs_strides[right];
    }
  }

  const Dimensions& dimensions() const { return m_dimensions; }

  bool evalSubExprsIfNeeded(Scalar* data)
  {
    m_leftImpl.evalSubExprsIfNeeded(nullptr);
    m_rightImpl.evalSubExprsIfNeeded(nullptr);
    if (data) {
      eval_to(data);
      return true;
    } else {
      m_result = new Scalar[dimensions().total_size()];
      eval_to(m_result);
      return true;
    }
  }

  void eval_to(Scalar* buffer) const
  {
    static_cast<const Derived*>(this)->template eval_product(buffer);
  }

  void eval_gemm(Scalar* buffer) const
  {
    typedef TensorEvaluator<LeftArgType> LeftEvaluator;
    typedef TensorEvaluator<RightArgType> RightEvaluator;
    typedef typename LeftEvaluator::Scalar LhsScalar;
    typedef typename RightEvaluator::Scalar RhsScalar;
    typedef TensorContractionMapper<LhsScalar, Index, Lhs, LeftEvaluator, Indices, Indices> LeftMapper;
    typedef TensorContractionMapper<RhsScalar, Index, Rhs, RightEvaluator, Indices, Indices> RightMapper;

    LeftMapper lhs(m_leftImpl, m_left_nocontract_strides, m_i_strides,
      m_left_contracting_strides, m_k_strides);
    RightMapper rhs(m_rightImpl, m_right_nocontract_strides, m_j_strides,
      m_right_contracting_strides, m_k_strides);

    for (int i = 0; i < LDims - ContractDims; ++i) {
      for (int j = 0; j < RDims - ContractDims; ++j) {
        for (int k = 0; k < ContractDims; ++k) {
          buffer[i + m_leftImpl.dimensions().total_size() * j] += lhs(i, k) * rhs(k, j);
        }
      }
    }
  }

  void cleanup()
  {
    m_leftImpl.cleanup();
    m_rightImpl.cleanup();

    if (m_result) {
//      delete[] m_result;
      m_result = nullptr;
    }
  }

  CoeffReturnType coeff(Index index) const
  { return m_result[index]; }

  Scalar* data() const { return m_result; }

 protected:
  TensorContractionEvaluatorBase& operator=(const TensorContractionEvaluatorBase&);

  Indices m_k_strides;
  Indices m_left_contracting_strides;
  Indices m_right_contracting_strides;

  Indices m_i_strides;
  Indices m_j_strides;
  Indices m_left_nocontract_strides;
  Indices m_right_nocontract_strides;

  Index m_i_size;
  Index m_j_size;
  Index m_k_size;

  Dimensions m_dimensions;

  TensorEvaluator<LeftArgType> m_leftImpl;
  TensorEvaluator<RightArgType> m_rightImpl;

  Scalar* m_result;
};

template <typename IndexPairs, typename LeftArgType, typename RightArgType>
struct TensorEvaluator<const TensorContractionOp<IndexPairs, LeftArgType, RightArgType>> :
  public TensorContractionEvaluatorBase<
  TensorEvaluator<const TensorContractionOp<IndexPairs, LeftArgType, RightArgType>>>
{
  typedef TensorContractionOp<IndexPairs, LeftArgType, RightArgType> XprType;
  typedef TensorEvaluator<const XprType> Self;
  typedef TensorContractionEvaluatorBase<Self> Base;

  typedef typename LeftArgType::Dimensions Dimensions;

  typedef typename XprType::Scalar Scalar;

  TensorEvaluator(const XprType& op) :
    Base(op)
  { }

  void eval_product(Scalar* buffer) const
  { this->template eval_gemm(buffer); }
};

}

}

#endif
