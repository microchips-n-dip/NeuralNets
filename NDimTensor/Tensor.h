template <typename Scalar, typename Index, typename Indices>
class Tensor
{
  typedef TensorStorage<Scalar, Index, Indices> Storage;
  Storage storage;

  Scalar* data() { return storage.data(); }
  Index size() { return storage.size(); }
  Index n_dimensions() { return storage.n_dimensions(); }

  Scalar coeff(Indices indices)
  { return storage.accessor(indices); }

  template <typename... IndexTypes>
  Scalar coeff(Index firstIndex, IndexTypes... otherIndices)
  { return coeff(Indices({firstIndex, otherIndices...})); }

  Scalar& coeffRef(Indices indices)
  { return storage.accessor(indices); }

  template <typename... IndexTypes>
  Scalar& coeffRef(Index firstIndex, IndexTypes... otherIndices)
  { return coeffRef(Indices({firstIndex, otherIndices...})); }

  Tensor(Indices dimensions)
  { storage = Storage(dimensions); }

  template <typename... IndexTypes>
  Tensor(Index firstIndex, IndexTypes... otherIndices)
  { storage = Storage(Indices({firstIndex, otherIndices...})); }

  template <typename Derived>
  Derived& operator=(const Derived& other)
  {
    
  }
};
