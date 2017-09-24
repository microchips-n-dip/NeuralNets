#ifndef JAPETUS_TENSOR_H
#define JAPETUS_TENSOR_H

namespace Japetus {

namespace tensor {

template <typename Scalar_, typename Index_, typename Indices_>
struct traits<Tensor<Scalar_, Index_, Indices_>>
{
  typedef Scalar_ Scalar;
  typedef Index_ Index;
  typedef Indices_ Indices;

  enum {
    Flags = is_const<Scalar_>::value ? 0 : LvalueBit
  };

  template <typename T> struct MakePointer
  { typedef T* Type; };
};

template <typename Scalar_, typename Index_, typename Indices_>
class Tensor : public TensorBase<Tensor<Scalar_, Index_, Indices_>>
{
 public:
  typedef Tensor<Scalar_, Index_, Indices_> Self;
  typedef TensorBase<Self> Base;
  typedef TensorStorage<Scalar_, Index_, Indices_> Storage;

  typedef Scalar_ Scalar;
  typedef Index_ Index;
  typedef Indices_ Indices;
  typedef TensorDimensions<Index, Indices> Dimensions;

  Scalar* data() { return storage_.data(); }
  const Scalar* data() const { return storage_.data(); }
  const Index& size() const { return storage_.total_size(); }
  const Dimensions& dimensions() const { return storage_.dimensions(); }

  Scalar coeff(Index index) const {
    if (index < size()) {
      return data()[index];
    }
  }

  void resize(const Dimensions& dims)
  { storage_.resize(dims); }

  Tensor() { }

  Tensor(const Self& other) :
    storage_(other.storage_)
  { }

  template <typename OtherDerived>
  Tensor(const TensorBase<OtherDerived>& other)
  {
    typedef TensorAssignOp<Tensor, const OtherDerived> Assign;
    Assign assign(*this, other.derived());
    resize(TensorEvaluator<const Assign>(assign).dimensions());
    TensorExecutor<const Assign>::run(assign);
  }

  template <typename OtherDerived>
  Tensor& operator=(const OtherDerived& other)
  {
    typedef TensorAssignOp<Tensor, const OtherDerived> Assign;
    Assign assign(*this, other.derived());
    resize(TensorEvaluator<const Assign>(assign).dimensions());
    TensorExecutor<const Assign>::run(assign);
  }

  Tensor& operator=(const Tensor& other)
  {
    typedef TensorAssignOp<Tensor, const Tensor> Assign;
    Assign assign(*this, other.derived());
    resize(TensorEvaluator<const Assign>(assign).dimensions());
    TensorExecutor<const Assign>::run(assign);
  }

  template <typename... IndexTypes>
  Tensor(Index first_index, IndexTypes... other_indices) :
    storage_(Dimensions({first_index, other_indices...}))
  { }

 private:
  Storage storage_;
};

template <typename Derived>
struct TensorEvaluator
{
  typedef typename Derived::Index Index;
  typedef typename Derived::Scalar Scalar;
  typedef typename Derived::Scalar CoeffReturnType;
  typedef typename Derived::Dimensions Dimensions;

  typedef typename traits<Derived>::template \
    MakePointer<Scalar>::Type Data;

//  typedef Scalar* Data;

  TensorEvaluator(const Derived& m) :
    m_data(const_cast<Data>(m.data())),
    m_dims(m.dimensions()),
    m_impl(m)
  { }

  void cleanup() { }

  CoeffReturnType coeff(Index index) const
  {
    ECHECK(m_data, "coeff(): Data pointer must be valid!");
    return m_data[index];
  }

  Scalar& coeffRef(Index index)
  {
    ECHECK(m_data, "coeffRef(): Data pointer must be valid!");
    return m_data[index];
  }

  Data data() const { return m_data; }

  const Dimensions& dimensions() const { return m_dims; }

  bool evalSubExprsIfNeeded(CoeffReturnType* dest)
  {
    if (dest) {
      memcpy((void*)dest, m_data, sizeof(Scalar) * m_dims.total_size());
      return false;
    }
    return true;
  }

  Data m_data;
  Dimensions m_dims;
  const Derived& m_impl;
};

template <typename Derived>
struct TensorEvaluator<const Derived>
{
  typedef typename Derived::Index Index;
  typedef typename Derived::Scalar Scalar;
  typedef typename Derived::Scalar CoeffReturnType;
  typedef typename Derived::Dimensions Dimensions;

  typedef typename traits<Derived>::template \
    MakePointer<const Scalar>::Type Data;

//  typedef Scalar* Data;

  TensorEvaluator(const Derived& m) :
    m_data(m.data()),
    m_dims(m.dimensions()),
    m_impl(m)
  { }

  void cleanup() { }

  CoeffReturnType coeff(Index index) const
  { if (m_dims.total_size()) return m_data[index]; }

  Data data() const { return m_data; }

  const Dimensions& dimensions() const { return m_dims; }

  bool evalSubExprsIfNeeded(Scalar* dest)
  {
    if (dest) {
      memcpy((void*)dest, m_data, sizeof(Scalar) * m_dims.total_size());
      return false;
    }
    return true;
  }

  Data m_data;
  Dimensions m_dims;
  const Derived& m_impl;
};

}

}

#endif

