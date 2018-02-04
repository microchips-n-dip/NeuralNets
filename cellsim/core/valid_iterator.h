#ifndef VALID_ITERATOR_H
#define VALID_ITERATOR_H

#include <vector>

template <typename T>
struct ValidIterator {
  typedef std::vector<T> VectorT;
  typedef typename std::vector<T>::iterator VectorTIterator;
  
  void reset() { n_ = 0; }
  ValidIterator() { reset(); }
  
  ValidIterator(VectorT& vec) {
    reset();
    vec_ = &vec;
  }
  
  VectorTIterator begin() { return vec_->begin(); }
  VectorTIterator end() { return vec_->end(); }
  VectorTIterator fetch_iterator() { return begin() + n_; }
  
  unsigned int size() { return vec_->size(); }
  
  bool at_begin() { return n_ == 0; }
  bool at_end() { return n_ >= vec_->size(); }
  bool valid() { return (size() > 0) && (!at_end()); }
  
  void erase_current() { vec_->erase(fetch_iterator()); }
  
  ValidIterator& operator=(VectorT& vec) {
    reset();
    vec_ = &vec;
    return *this;
  }
  
  ValidIterator& operator++() {
    ++n_;
    return *this;
  }
  
  VectorTIterator operator()() { return fetch_iterator(); }
  T& operator*() { return *fetch_iterator(); }
  
  VectorT* vec_;
  unsigned int n_;
};

#endif
