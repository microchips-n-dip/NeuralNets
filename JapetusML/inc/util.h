#ifndef JAPETUS_UTIL_H
#define JAPETUS_UTIL_H

#include <stdlib.h>
#include <stdio.h>

inline void ECHECK(bool state, const char* fail_msg)
{
  if (!state) {
    printf("JAPETUS_ECHECK_ERROR: %s\n", fail_msg);
    exit(rand());
  }
}

inline void WCHECK(bool state, const char* warn_msg)
{
  if (!state) {
    printf("JAPETUS_WCHECK_WARNING: %s\n", warn_msg);
  }
}

template<typename T> struct remove_all { typedef T type; };
template<typename T> struct remove_all<const T>   { typedef typename remove_all<T>::type type; };
template<typename T> struct remove_all<T const&>  { typedef typename remove_all<T>::type type; };
template<typename T> struct remove_all<T&>        { typedef typename remove_all<T>::type type; };
template<typename T> struct remove_all<T const*>  { typedef typename remove_all<T>::type type; };
template<typename T> struct remove_all<T*>        { typedef typename remove_all<T>::type type; };

#endif
