#ifndef JAPETUS_TENSOR_STORAGE_H
#define JAPETUS_TENSOR_STORAGE_H

namespace Japetus {

namespace tensor {

template <typename Index_, typename Indices_>
class TensorDimensions
{
 public:
  typedef Index_ Index;
  typedef Indices_ Indices;

  const Index n_dims() { compute_resized_values(); return ndims_; }
  const Index n_dims() const { return ndims_; }
  const Index total_size() { compute_resized_values(); return total_sz_; }
  const Index total_size() const { return total_sz_; }
  const Indices dimensions() const { return dimensions_; }

  const Index operator[](Index index) const
  { return dimensions_.at(index); }

  Index& operator[](Index index)
  {
    flag_compute_resized_values = true;
    return dimensions_.at(index);
  }

  TensorDimensions()
  {
    total_sz_ = 1;
    ndims_ = 0;
    dimensions_ = Indices({1});
  }

  TensorDimensions(const Index ndims)
  {
    ndims_ = ndims;
    dimensions_ = Indices(ndims_);
  }

  TensorDimensions(const TensorDimensions& other)
  {
    dimensions_.clear();

    total_sz_ = other.total_size();
    ndims_ = other.n_dims();
    dimensions_ = other.dimensions();
  }

  TensorDimensions&
  operator=(const TensorDimensions& other)
  {
    dimensions_.clear();

    total_sz_ = other.total_size();
    ndims_ = other.n_dims();
    dimensions_ = other.dimensions();
    return *this;
  }

  TensorDimensions(const Indices& dims)
  {
    ndims_ = dims.size();
    dimensions_ = dims;
    compute_total_size();
  }

  ~TensorDimensions()
  {
    total_sz_ = 0;
    ndims_ = 0;
    dimensions_.clear();
  }

 private:
  void compute_total_size()
  {
    total_sz_ = Index(1);
    for (Index i = 0; i < ndims_; ++i) {
      total_sz_ *= dimensions_.at(i);
    }
  }

  void compute_resized_values()
  {
    if (flag_compute_resized_values) {
      ndims_ = dimensions_.size();
      compute_total_size();
      flag_compute_resized_values = false;
    }
  }

  bool flag_compute_resized_values;

  Indices dimensions_;
  Index total_sz_;
  Index ndims_;
};

template <typename Derived, typename Index, typename Indices>
class TensorStorage
{
 public:
  typedef TensorDimensions<Index, Indices> Dimensions;

  const Index& total_size() const { return dimensions_.total_size(); }
  const Dimensions& dimensions() const { return dimensions_; }

  Derived* data() const { return data_; }

  void resize(const Dimensions& dims)
  {
    dimensions_ = dims;
    ts_deallocate();
    ts_allocate(dimensions_.total_size());
  }

  TensorStorage() :
    dimensions_()
  { ts_allocate(1); }

  TensorStorage(const Dimensions& dims) :
    dimensions_(dims)
  { ts_allocate(dims.total_size()); }

  ~TensorStorage()
  { ts_deallocate(); }

 private:
  void ts_allocate(const Index& sz)
  {
    data_ = new Derived[sz];
  }

  void ts_deallocate()
  {
    if (data_) {
      delete[] data_;
    }
    data_ = nullptr;
  }

  Derived* data_;
  Dimensions dimensions_;
};

}

}

#endif
