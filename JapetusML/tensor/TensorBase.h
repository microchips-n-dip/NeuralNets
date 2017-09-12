// First and foremost is the developent of unary and hadamard type operations
#ifndef JAPETUS_TENSOR_BASE_H
#define JAPETUS_TENSOR_BASE_H

namespace Japetus {

namespace tensor {

template<typename Derived>
class TensorBase
{
 public:

  Dimensions dimensions() const { return dimensions_; }
  Index total_size() const { return dimensions_.total_size(); }

  template <typename OtherDerived, BinaryOp>
  binaryOp(OtherDerived& other, BinaryOp& op)
  {
    return TensorCWiseBinaryOp<BinaryOp, Derived, OtherDerived>(
      derived(), other.derived(), op);
  }

  template <typename OtherDerived>
  operator+(OtherDerived& other)
  { return binaryOp(other, tensor_add_op()); }

  template <typename OtherDerived>
  operator-(OtherDerived& other)
  { return binaryOp(other, tensor_sub_op()); }

  template <typename OtherDerived>
  operator*(OtherDerived& other)
  { return binaryOp(other, tensor_mul_op()); }

  template <typename OtherDerived>
  operator/(OtherDerived& other)
  { return binaryOp(other, tensor_div_op()); }

  Derived& derived() const { return *static_cast<Derived*>(this); }

 private:
  Dimensions dimensions_;
};

}

}

#endif
