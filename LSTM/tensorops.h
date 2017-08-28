#ifndef TENSOROPS_H
#define TENSOROPS_H

#include <unsupported/Eigen/CXX11/Tensor>

using namespace Eigen;

template <typename LeftType, typename RightType, typename Dimensions>
Tensor<double, LeftType::NumIndices + RightType::NumIndices - 2 * internal::array_size<Dimensions>::value>
tco(LeftType a, RightType b, Dimensions ctr)
{
  const int sz = LeftType::NumIndices + RightType::NumIndices - 2 * internal::array_size<Dimensions>::value;
  Tensor<double, sz> ret;
  ret = TensorContractionOp<const Dimensions, const LeftType, const RightType>(a, b, ctr);
  return ret;
}

template <typename Derived> Derived sigmoid(const Derived& z) {
  Derived ret(z.dimensions());
  for (unsigned int i = 0; i < z.size(); ++i) {
    ret.coeffRef(i) = pow(1 + exp(-(z.coeff(i))), -1);
  }
  return ret;
}

template <typename Derived>
Derived sigmoid_prime(const Derived& z)
{
  Derived ret(z.dimensions());
  for (unsigned int i = 0; i < z.size(); ++i) {
    ret.coeffRef(i) = exp(-z.coeff(i)) / pow(1 + exp(-z.coeff(i)), 2);
  }
  return ret;
}

template <typename Derived>
Derived tanh(const Derived& z)
{
  Derived ret(z.dimensions());
  for (unsigned int i = 0; i < z.size(); ++i) {
    ret.coeffRef(i) = tanh(z.coeff(i));
  }
  return ret;
}

template <typename Derived>
Derived tanh_prime(const Derived& z)
{
  Derived ret(z.dimensions());
  for (unsigned int i = 0; i < z.size(); ++i) {
    ret.coeffRef(i) = 1.0 / pow(cosh(z.coeff(i)), 2);
  }
  return ret;
}


#endif
