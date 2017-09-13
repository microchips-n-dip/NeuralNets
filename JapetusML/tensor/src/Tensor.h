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

  void resize(Dimensions& dims) const
  { storage_.resize(dims); }

  template <typename OtherDerived>
  Tensor(const OtherDerived& other)
  {
    typedef TensorAssignOp<Tensor, OtherDerived> Assign;
    Assign assign(*this, other.derived());
    resize(TensorEvaluator<const Assign>(assign).dimensions());
    TensorExecutor<const Assign>::run(assign);
  }

  template <typename... IndexTypes>
  Tensor(Index first_index, IndexTypes... other_indices)
  { storage_ = Storage(Dimensions({first_index, other_indices...})); }

 private:
  Storage storage_;
};

}

}

#endif

