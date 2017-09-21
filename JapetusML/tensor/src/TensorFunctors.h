#ifndef JAPETUS_TENSOR_FUNCTORS_H
#define JAPETUS_TENSOR_FUNCTORS_H

namespace Japetus {

namespace tensor {

template <typename T>
struct scalar_sigmoid_op
{
  typedef T result_type;
  const result_type operator()(const T& z) const
  {
    const T one = T(1);
    return one / (one + exp(-z));
  }
};

template <typename T>
struct scalar_tanh_op
{
  typedef T result_type;
  const result_type operator()(const T& z) const
  { return tanh(z); }
};

template <typename ScalarA, typename ScalarB, typename BinaryOp=scalar_product_op<ScalarA, ScalarB>>
struct ScalarBinaryOpTraits
{ };

template <typename T, typename BinaryOp>
struct ScalarBinaryOpTraits<T, T, BinaryOp>
{ typedef T ReturnType; };

template <typename Arg1, typename Arg2>
struct binary_op_base
{
  typedef Arg1 first_argument_type;
  typedef Arg2 second_argument_type;
};

template <typename LhsScalar, typename RhsScalar>
struct scalar_sum_op : binary_op_base<LhsScalar, RhsScalar>
{
  typedef typename ScalarBinaryOpTraits<LhsScalar, RhsScalar, scalar_sum_op>::ReturnType result_type;
  const result_type operator()(const LhsScalar& a, const RhsScalar& b) const { return a + b; }
  scalar_sum_op() { }
};

template <typename LhsScalar, typename RhsScalar>
struct scalar_difference_op : binary_op_base<LhsScalar, RhsScalar>
{
  typedef typename ScalarBinaryOpTraits<LhsScalar, RhsScalar, scalar_difference_op>::ReturnType result_type;
  const result_type operator()(const LhsScalar& a, const RhsScalar& b) const { return a - b; }
  scalar_difference_op() { }
};

template <typename LhsScalar, typename RhsScalar>
struct scalar_product_op : binary_op_base<LhsScalar, RhsScalar>
{
  typedef typename ScalarBinaryOpTraits<LhsScalar, RhsScalar, scalar_product_op>::ReturnType result_type;
  const result_type operator()(const LhsScalar& a, const RhsScalar& b) const { return a * b; }
  scalar_product_op() { }
};

template <typename LhsScalar, typename RhsScalar>
struct scalar_division_op : binary_op_base<LhsScalar, RhsScalar>
{
  typedef typename ScalarBinaryOpTraits<LhsScalar, RhsScalar, scalar_division_op>::ReturnType result_type;
  const result_type operator()(const LhsScalar& a, const RhsScalar& b) const { return a / b; }
  scalar_division_op() { }
};

}

}

#endif
