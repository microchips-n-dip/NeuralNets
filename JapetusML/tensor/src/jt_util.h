#ifndef JAPETUS_TENSOR_UTIL_H
#define JAPETUS_TENSOR_UTIL_H

template <bool condition, typename Then, typename Else>
struct conditional { };

template <typename Then, typename Else>
struct conditional<true, Then, Else> { typedef Then type; };

template <typename Then, typename Else>
struct conditional<false, Then, Else> { typedef Else type; };

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

#endif
