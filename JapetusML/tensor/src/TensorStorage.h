#ifndef JAPETUS_TENSOR_STORAGE_H
#define JAPETUS_TENSOR_STORAGE_H

namespace Japetus {

namespace tensor {

template <typename Index, typename Indices>
class TensorDimensions
{
 public:
  const Index n_dims() const { return ndims_; }
  const Index total_size() const { return total_sz_; }
  const Indices dimensions() const { return dimensions_; }

  const Index operator[](Index index) const
  { return dimensions_.at(index); }

  TensorDimensions()
  {
    total_sz_ = 1;
    ndims_ = 0;
    dimensions_ = Indices({1});
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
    total_sz_ = Index(1);
    ndims_ = dims.size();
    dimensions_ = dims;
    for (Index i = 0; i < ndims_; ++i) {
      total_sz_ *= dimensions_.at(i);
    }
  }

  ~TensorDimensions()
  {
    total_sz_ = 0;
    ndims_ = 0;
    dimensions_.clear();
  }

 private:
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

  Derived* data() const
  {
    if (data_ && ts_gooddata_flag) {
      return data_;
    }
  }

  void resize(const Dimensions& dims)
  {
    dimensions_ = dims;
    ts_deallocate();
    ts_allocate(dimensions_.total_size());
  }

  TensorStorage()
  {
    ts_allocate(0);
    ts_gooddata_flag = true;
  }

  TensorStorage(const Dimensions& dims) :
    dimensions_(dims)
  { ts_allocate(dims.total_size()); }

  ~TensorStorage()
  { ts_deallocate(); }

 private:
  void ts_allocate(const Index& sz)
  {
    data_ = new Derived[sz];
    ts_gooddata_flag = true;
  }

  void ts_deallocate()
  {
    if (data_ && ts_gooddata_flag) {
      delete[] data_;
    }
    ts_gooddata_flag = false;
  }

  Derived* data_;
  Dimensions dimensions_;
  bool ts_gooddata_flag;
};

}

}

#endif
