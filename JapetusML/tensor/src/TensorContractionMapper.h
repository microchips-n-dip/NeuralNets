#ifndef JAPETUS_TENSOR_CONTRACTION_MAPPER_H
#define JAPETUS_TENSOR_CONTRACTION_MAPPER_H

namespace Japetus {

namespace tensor {

enum {
  Rhs = 0,
  Lhs = 1
};

template <typename Tensor>
struct CoeffLoader
{
  CoeffLoader(const Tensor& tensor) :
    m_tensor(tensor)
  { }

  typename Tensor::Scalar coeff(typename Tensor::Index index) const
  { return m_tensor.coeff(index); }

  const Tensor m_tensor;
};

template <typename Scalar, typename Index, int side, typename Tensor, typename nocontract_t, typename contract_t>
class TensorContractionMapper
{
 public:

  TensorContractionMapper(
    const Tensor& tensor,
    const nocontract_t& nocontract_strides,
    const nocontract_t& ij_strides,
    const contract_t& contract_strides,
    const contract_t& k_strides) :
    m_tensor(tensor),
    m_nocontract_strides(nocontract_strides),
    m_ij_strides(ij_strides),
    m_contract_strides(contract_strides),
    m_k_strides(k_strides)
  { }

  Scalar operator()(Index i) const
  { return operator()(i, 0); }

  Scalar operator()(Index i, Index j) const
  { return m_tensor.coeff(compute_index(i, j)); }

  Index compute_index(Index row, Index col) const
  {
    const bool Left = (side == Lhs);
    Index nocontract_val = Left ? row : col;
    Index linidx = 0;

    Index nocontract_sz = m_nocontract_strides.size();
    Index contract_sz = m_contract_strides.size();

    for (int i = static_cast<int>(nocontract_sz) - 1; i > 0; i--) {
      printf("m_ij_strides[%d] = %d\n", i, m_ij_strides[i]);
      const Index idx = nocontract_val / m_ij_strides[i];
      linidx += idx * m_nocontract_strides[i];
      nocontract_val -= idx * m_ij_strides[i];
    }
    linidx += nocontract_val * m_nocontract_strides[0];

    Index contract_val = Left ? col : row;
    for (int i = static_cast<int>(contract_sz) - 1; i > 0; i--) {
      const Index idx = contract_val / m_k_strides[i];
      linidx += idx * m_contract_strides[i];
      contract_val -= idx * m_k_strides[i];
    }
    linidx += contract_val * m_contract_strides[0];

    return linidx;
  }

 protected:
  const nocontract_t m_nocontract_strides;
  const nocontract_t m_ij_strides;
  const contract_t m_contract_strides;
  const contract_t m_k_strides;

  CoeffLoader<Tensor> m_tensor;
};

}

}

#endif
