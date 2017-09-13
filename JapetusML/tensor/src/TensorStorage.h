#ifndef JAPETUS_TENSOR_STORAGE_H
#define JAPETUS_TENSOR_STORAGE_H

namespace Japetus {

namespace tensor {

template <typename Index, typename Indices>
class TensorDimensions
{
 public:
  const Index total_size() const { return ts_; }
  const Indices dimensions() const { return dimensions_; }

  const Index operator[](Index index) const
  { return dimensions_.at(index); }

  TensorDimensions() { }

  TensorDimensions(const Indices& dims)
  {
    ts_ = 1;
    dimensions_ = dims;
    for (Index i = 0; i < dimensions_.size(); ++i) {
      ts_ *= dimensions_.at(i);
    }
  }

 private:
  Indices dimensions_;
  Index ts_;
};

template <typename Derived, typename Index, typename Indices>
class TensorStorage
{
 public:
  typedef TensorDimensions<Index, Indices> Dimensions;

  unsigned int total_size() const { return dimensions_.total_size(); }
  Dimensions dimensions() const { return dimensions_; }

  void resize(const Dimensions& dims)
  {
    dimensions_ = dims;
    deallocate();
    allocate(dimensions_.total_size());
  }

  TensorStorage() { }

  TensorStorage(const Dimensions& dims)
  { resize(dims); }

 private:
  void allocate(unsigned int sz)
  { data_ = new Derived[sz]; }

  void deallocate()
  { delete[] data_; }

  Derived* data_;
  Dimensions dimensions_;
};

}

}

#endif
