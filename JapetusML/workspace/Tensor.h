#ifndef JAPETUS_TENSOR_H
#define JAPETUS_TENSOR_H

namespace Japetus {

namespace tensor {

// Class for storing Tensor's dimensions
class Dimensions
{
 public:
  unsigned int total_size() const { return ts_; }
  std::vector<unsigned int> dims() const { return dims_; }

  Dimensions(std::vector<unsigned int> dims)
  {
    dims_ = dims;

    ts_ = 1;
    for (unsigned int i = 0; i < dims_.size(); ++i) {
      ts_ *= dims_.at(i);
    }
  }

 private:
  std::vector<unsigned int> dims_;
  unsigned int ts_;
};

// Class for storing Tensor's raw data
template <typename Type>
class TensorStorage
{
 public:
  Type* data() { return data_; }
  Dimensions dimensions() const { return dimensions_; }
  unsigned int total_size() const { return total_size_; }
  unsigned int n_dims() const { return n_dims; }

  Tensor(Dimensions& dimensions)
  {
    dimensions_ = dimensions;
    n_dims_ = dimensions_.size();
    total_size_ = dimensions_.total_size();
    allocate();
  }

  void allocate()
  { data_ = new Type[total_size_]; }

 private:
  Type* data_;
  Dimensions dimensions_;
  unsigned int total_size_;
  unsigned int n_dims_;
};

}

// Tensor base class
// Dev note: tensor base does not contain any tensor data
//   Base does contain dimension information and operators
template <typename Derived>
class TensorBase
{
 public:

 private:
};

// Binary element wise operations
template <typename BinaryOp, typename LeftXprType, typename RightXprType>
class TensorCWiseBinaryOp :
  public TensorBase<TensorCWiseBinaryOp<BinaryOp, LeftXprType, RightXprType>>
{
 public:
  typedef typename tensor::internal::traits<TensorCWiseBinaryOp>::Scalar Scalar;

  BinaryOp op() const { return m_functor; }
  LeftXprType lhsExpression() const { return m_leftImpl; }
  RightXprType rhsExpression() const { return m_rightImpl; }

 private:
  BinaryOp m_functor;
  LeftXprType m_leftImpl;
  RightXprType m_rightImpl;
};

template <typename BinaryOp, typename LeftArgType, typename RightArgType>
struct TensorEvaluator<TensorCWiseBinaryOp<BinaryOp, LeftArgType, RightArgType>>
{
  typedef TensorCWiseBinaryOp<BinaryOp, LeftArgType, RightArgType> XprType;

  typedef typename XprType::Scalar Scalar;
  typedef typename XprType::Index Index;
  typedef typename tensor::internal::traits<XprType>::Scalar CoeffReturnType;

  TensorEvaluator(XprType& op)
  {
    m_functor = op.functor();
    m_leftImpl = op.lhsExpression();
    m_rightImpl = op.rhsExpression();
  }

  CoeffReturnType coeff(Index index) const
  { return m_functor(m_leftImpl.coeff(index), m_rightImpl.coeff(index)); }

 private:
  LeftArgType m_leftImpl;
  RightArgType m_rightImpl;
  BinaryOp m_functor;
};

// Tensor axial reduction operation
template <typename Op, typename Dims, typename XprType>
class TensorReductionOp
{
 public:
  TensorReductionOp(XprType& expr, Dims& dims, Op& reducer)
  {
    m_expr = expr;
    m_dims = dims;
    m_reducer = reducer;
  }

  XprType expression() const { return m_expr; }
  Dims dims() const { return m_dims; }
  Op reducer() const { return m_reducer; }

 private:
  XprType m_expr;
  Dims m_dims;
  Op m_reducer;
};

template <typename Op, typename Dims, typename ArgType>
struct TensorEvaluator<TensorReductionOp<Op, Dims, ArgType>>
{
  typedef TensorReductionOp<Op, Dims, ArgType> XprType;

  typedef typename XprType::Scalar Scalar;

  TensorEvaluator(XprType& op)
  {
    m_expr = op.expression();
    m_dims = op.dims();
    m_reducer = op.reducer();
  }

  bool evalSubExprsIfNeeded(...)
  {
    // TODO
  }

  ArgType m_expr;
  Dims m_dims;
  Op m_reducer;
}

// Tensor contraction operation
template <typename Dims, typename LeftXprType, typename RightXprType>
class TensorContractionOp
{
 public:
  TensorContractionOp(LeftXprType& leftImpl, RightXprType& rightImpl, Dims& dims)
  {
    m_leftImpl = leftImpl;
    m_rightImpl = rightImpl;
    m_dims = dims;
  }

 private:
  Dims m_dims;
  LeftXprType m_leftImpl;
  RightXprType m_rightImpl;
};

template <typename Dims, typename LeftArgType, typename RightArgType>
struct TensorEvaluator<TensorContractionOp<Dims, LeftArgType, RightArgType>>
{
  typedef TensorContractionOp<Dims, LeftArgType, RightArgType> XprType;

  // Unlike Eigen, size information is not stored in the templates
  typedef Dims contract_t;
  typedef Dims nocontract_t;

  TensorEvaluator(XprType& op)
  {
    m_leftImpl = op.lhsExpression();
    m_rightImpl = op.rhsExpression();
    m_dims = op.dims();

    ContractDims = m_dims.size();
    LDims = m_leftImpl.n_dims();
    RDims = m_rightImpl.n_dims();

    m_left_nocontract_strides = nocontract_t(LDims - ContractDims);
    m_right_nocontract_strides = nocontract_t(RDims - ContractDims);
    m_contract_strides = contract_t(ContractDims);

    /* Something or other */ eval_left_dims;
    /* Something or other */ eval_right_dims;
    /* Something or other */ eval_op_indices;
    for (unsigned int i = 0; i < LDims; ++i) {
      eval_left_dims[i] = m_leftImpl.dimensions()[i];
    }
    for (unsigned int i = 0; i < RDims; ++i) {
      eval_right_dims[i] = m_rightImpl.dimensions()[i];
    }
    for (unsigned int i = 0; i < ContractDims; ++i) {
      eval_op_indices[i].first = op.indices()[i].first;
      eval_op_indices[i].second = op.indices()[i].second;
    }

    for (unsigned int i = 0; i < ContractDims; ++i) {
      for (unsigned int j = 0; j < ContractDims; ++j) {
        if (eval_op_indices[j].first == eval_op_indices[i].first ||
            eval_op_indices[j].second == eval_op_indices[i].second) {
          printf("Contraction axes should be unique\n");
          exit(-1);
        }
        if (eval_op_indices[j].first < eval_op_indices[j].first) {
          std::swap(eval_op_indices[j], eval_op_indices[i]);
        }
      }
    }

    unsigned int nocontract_idx;
    unsigned int dim_idx = 0;

    nocontract_idx = 0;
    for (unsigned int i = 0; i < LDims; ++i) {
      bool contracting = false;
      for (unsigned int j = 0; j < ContractDims; ++j) {
        if (eval_op_indices[j].first == i) {
          contracting = true;
          break;
        }
      }
      if (!contracting) {
        m_dimensions[dim_idx] = eval_left_dims[i];
        m_left_nocontract_strides[nocontract_idx] = lhs_strides[i];
        if (dim_idx != i) {
          m_lhs_inner_dim_contiguous = false;
        }
        if (nocontract_idx + 1 < n_left_nocontract_dims) {
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
    for (unsigned int i = 0; i < RDims; ++i) {
      bool contracting = false;
      for (unsigned int j = 0; j < ContractDims; ++j) {
        if (eval_op_indices[j].second == i) {
          contracting = true;
          break;
        }
      }
      if (!contracting) {
        m_dimensions[dim_idx] = eval_right_dims[i];
        m_right_nocontract_strides[nocontract_idx] = rhs_strides[i];
        if (nocontract_idx + 1 < n_right_nocontract_dims) {
          m_j_strides[nocontract_idx + 1] =
            m_j_strides[nocontract_idx] * eval_right_dims[i];
        } else {
          m_j_size = m_j_strides[nocontract_idx] * eval_j_dims[i];
        }
        ++dim_idx;
        ++nocontract_idx;
      }
    }
  }

  void eval_gemv(Scalar* buffer)
  {
    typedef tensor::internal::TensorContractionMapper<> LhsMapper;
    typedef tensor::internal::TensorContractionMapper<> RhsMapper;

    LhsMapper lhs();
    RhsMapper rhs();
    OutputMapper out();

    // TODO: Add multithread support
    for (unsigned int i = 0; i < LDims - ContractDims; ++i) {
      for (unsigned int j = 0; j < RDims - ContractDims; ++j) {
        for (unsigned int k = 0; k < ContractDims; ++k) {
          out(i, j) += lhs(i, k) * rhs(k, j);
        }
      }
    }
  }

  nocontract_t m_left_nocontract_strides;
  nocontract_t m_right_nocontract_strides;

  LeftArgType m_leftImpl;
  RightArgType m_rightImpl;
  Dims m_dims;
};

template <typename Type>
class Tensor
{
 public:
  typedef tensor::TensorStorage<Type> Storage;

  Tensor(tensor::Dimensions& dims)
  { storage = Storage(dims); }

  typedef <typename IndexType, typename... IndexTypes>
  Tensor(IndexType first_dim, IndexTypes... other_dims)
  { storage = Storage(tensor::Dimensions(std::vector<IndexType>({first_dim, other_dims...}))); }

 private:
   Storage storage_;
};

}

#endif
