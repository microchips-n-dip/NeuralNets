// First and foremost is the developent of unary and hadamard type operations
#ifndef JAPETUS_TENSOR_BASE_H
#define JAPETUS_TENSOR_BASE_H

namespace Japetus {

namespace tensor {

template <typename Derived>
class TensorBase
{
 public:
  typedef traits<Derived> DerivedTraits;
  typedef typename DerivedTraits::Scalar Scalar;
  typedef typename DerivedTraits::Index Index;
  typedef typename DerivedTraits::Indices Indices;

  typedef TensorDimensions<Index, Indices> Dimensions;

  template <typename UnaryOp>
  TensorCWiseUnaryOp<UnaryOp, const Derived>
  unaryOp(const UnaryOp& op)
  {
    return TensorCWiseUnaryOp<UnaryOp, const Derived>(
      derived(), op);
  }

  TensorCWiseUnaryOp<scalar_sigmoid_op<Scalar>, const Derived>
  sigmoid()
  { return unaryOp(scalar_sigmoid_op<Scalar>()); }

  TensorCWiseUnaryOp<scalar_tanh_op<Scalar>, const Derived>
  tanh()
  { return unaryOp(scalar_tanh_op<Scalar>()); }

  template <typename OtherDerived, typename BinaryOp>
  TensorCWiseBinaryOp<BinaryOp, const Derived, const OtherDerived>
  binaryOp(const OtherDerived& other, const BinaryOp& op)
  {
    return TensorCWiseBinaryOp<BinaryOp, const Derived, const OtherDerived>(
      derived(), other.derived(), op);
  }

  template <typename OtherDerived>
  TensorCWiseBinaryOp<scalar_sum_op<Scalar>, const Derived, const OtherDerived>
  operator+(const OtherDerived& other)
  { return binaryOp(other, scalar_sum_op<Scalar>()); }

  template <typename OtherDerived>
  TensorCWiseBinaryOp<scalar_difference_op<Scalar>, const Derived, const OtherDerived>
  operator-(const OtherDerived& other)
  { return binaryOp(other, scalar_difference_op<Scalar>()); }

  template <typename OtherDerived>
  TensorCWiseBinaryOp<scalar_product_op<Scalar>, const Derived, const OtherDerived>
  operator*(const OtherDerived& other)
  { return binaryOp(other, scalar_product_op<Scalar>()); }

  template <typename OtherDerived>
  TensorCWiseBinaryOp<scalar_division_op<Scalar>, const Derived, const OtherDerived>
  operator/(const OtherDerived& other)
  { return binaryOp(other, scalar_division_op<Scalar>()); }

  template <typename OtherDerived, typename IndexPairs>
  const TensorContractionOp<const IndexPairs, const Derived, const OtherDerived>
  contract(const OtherDerived& other, const IndexPairs& ctr) const
  { return TensorContractionOp<const IndexPairs, const Derived, const OtherDerived>(derived(), other.derived(), ctr); }

  Derived& derived() { return *static_cast<Derived*>(this); }

 protected:
  template <typename Scalar_, typename Index_, typename Indices_> friend class Tensor;
  template <typename OtherDerived> friend class TensorBase;

  const Derived& derived() const { return *static_cast<const Derived*>(this); }
};

}

}

#endif
