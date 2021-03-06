#ifndef JAPETUS_TENSOR_UTIL_H
#define JAPETUS_TENSOR_UTIL_H

namespace Japetus {

namespace tensor {

template <typename I1, typename I2>
struct promote_index_type
{
  typedef typename conditional<(sizeof(I1)>sizeof(I2)), I1, I2>::type type;
};

template <typename I1, typename I2>
struct promote_indices_type
{
  typedef typename conditional<(sizeof(I1)>sizeof(I2)), I1, I2>::type type;
};

template <typename T> struct is_const { enum { value = 0 }; };
template <typename T> struct is_const<const T> { enum { value = 1 }; };

#define LvalueBit 1

template <typename ExpressionType>
struct is_lvalue
{
  enum { value = (!bool(is_const<ExpressionType>::value)) &&
    bool(traits<ExpressionType>::Flags & LvalueBit)
  };
};

}

}

#endif
