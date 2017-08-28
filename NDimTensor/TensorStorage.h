template <typename DataType, typename Index, typename Indices>
class TensorStorage
{
  Index n_dimensions;
  Indices dimensions;

  Index total_size;
  DataType* data;

  TensorStorage(Indices dimensions_)
  {
    n_dimensions = dimensions_.size();
    dimensions = dimensions_;

    total_size = 1;
    for (auto dim : dimensions) {
      total_size *= dim;
    }

    data = new DataType[total_size];
  }

  // TODO: Add range checker
  DataType& accessor(Indices indices)
  { return data[linearized_indices(indices)]; }

  Index size()
  { return total_size; }

  Index n_dimensions()
  { return n_dimensions; }

  Indices dimensions()
  { return dimensions; }
};
