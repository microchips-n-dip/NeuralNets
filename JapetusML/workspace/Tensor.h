#ifndef JAPETUS_TENSOR_H
#define JAPETUS_TENSOR_H

namespace Japetus {

namespace tensor {

class Dimensions
{
 public:
  unsigned int total_size() const { return ts_; }
  std::vector<unsigned int> dims() const { return dims_; }

  Dimensions(std::vector<unsigned int> dims)
  {
    dims_ = dims;

    ts_ = 1;
    for (unsigned int i = 0; i < dims_.size(); ++i) {
      ts_ *= dims_.at(i);
    }
  }

 private:
  friend class TensorStorage;
  friend class Tensor;

  std::vector<unsigned int> dims_;
  unsigned int ts_;
};

template <typename Type>
class TensorStorage
{
 public:
  Type* data() { return data_; }
  Dimensions dimensions() const { return dimensions_; }
  unsigned int total_size() const { return total_size_; }
  unsigned int n_dims() const { return n_dims; }

  Tensor(Dimensions& dimensions)
  {
    dimensions_ = dimensions;
    n_dims_ = dimensions_.size();
    total_size_ = dimensions_.total_size();
    allocate();
  }

  void allocate()
  { data_ = new Type[total_size_]; }

 private:
  Type* data_;
  Dimensions dimensions_;
  unsigned int total_size_;
  unsigned int n_dims_;
};

}

template <typename Type>
class Tensor
{
 public:
  typedef tensor::TensorStorage<Type> Storage;

  Tensor(tensor::Dimensions& dims)
  { storage = Storage(dims); }

  typedef <typename IndexType, typename... IndexTypes>
  Tensor(IndexType first_dim, IndexTypes... other_dims)
  { storage = Storage(tensor::Dimensions(std::vector<IndexType>({first_dim, other_dims...}))); }

 private:
   Storage storage_;
};

}

#endif
