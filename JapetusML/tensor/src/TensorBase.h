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

  template <typename OtherDerived, typename BinaryOp>
  TensorCWiseBinaryOp<BinaryOp, Derived, OtherDerived>
  binaryOp(const OtherDerived& other, const BinaryOp& op)
  {
    return TensorCWiseBinaryOp<BinaryOp, Derived, OtherDerived>(
      derived(), other.derived(), op);
  }

  template <typename OtherDerived>
  TensorCWiseBinaryOp<scalar_sum_op<Scalar>, Derived, OtherDerived>
  operator+(OtherDerived& other)
  { return binaryOp(other, scalar_sum_op<Scalar>()); }

  template <typename OtherDerived>
  TensorCWiseBinaryOp<scalar_difference_op<Scalar>, Derived, OtherDerived>
  operator-(OtherDerived& other)
  { return binaryOp(other, scalar_difference_op<Scalar>()); }

  template <typename OtherDerived>
  TensorCWiseBinaryOp<scalar_product_op<Scalar>, Derived, OtherDerived>
  operator*(OtherDerived& other)
  { return binaryOp(other, scalar_product_op<Scalar>()); }

  template <typename OtherDerived>
  TensorCWiseBinaryOp<scalar_division_op<Scalar>, Derived, OtherDerived>
  operator/(OtherDerived& other)
  { return binaryOp(other, scalar_division_op<Scalar>()); }

  Derived& derived() { return *static_cast<Derived*>(this); }
  const Derived& derived() const { return *static_cast<const Derived*>(this); }
};

}

}

#endif
