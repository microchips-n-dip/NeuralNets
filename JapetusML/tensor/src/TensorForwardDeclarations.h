#ifndef JAPETUS_TENSOR_FORWARD_DECLARATIONS_H
#define JAPETUS_TENSOR_FORWARD_DECLARATIONS_H

namespace Japetus {

namespace tensor {

template <typename T> struct MakePointer
{ typedef T* Type; };

template <typename Index, typename Indices>
class TensorDimensions;

template <typename Derived> class TensorBase;
template <typename Derived, typename Index, typename Indices> class TensorStorage;
template <typename Scalar_, typename Index_ = unsigned int, typename Indices_ = std::vector<Index_>>
class Tensor;

template <typename PlainObjectType> class TensorRef;

template <typename Derived> struct traits;
template <typename Derived> struct traits<const Derived> : traits<Derived> { };

template <typename Expression> struct TensorEvaluator;
template <typename Expression> struct TensorExecutor;

template <typename BinaryOp, typename LeftXprType, typename RightXprType>
class TensorCWiseBinaryOp;

template <typename LeftXprType, typename RightXprType>
class TensorAssignOp;

template <typename LhsScalar, typename RhsScalar = LhsScalar> struct scalar_sum_op;
template <typename LhsScalar, typename RhsScalar = LhsScalar> struct scalar_difference_op;
template <typename LhsScalar, typename RhsScalar = LhsScalar> struct scalar_product_op;
template <typename LhsScalar, typename RhsScalar = LhsScalar> struct scalar_division_op;

}

}

#endif
