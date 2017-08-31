#ifndef JAPETUS_VARIABLE_H
#define JAPETUS_VARIABLE_H

namespace Japetus {

using namespace Eigen;

class Variable
{
  public:

  // Store the functor acting as a source for this variable
  // (If none is found, be sure to use nullptr)
  // Helps with Flow
  Functor* src_func;

  // Data tensor
  // During Flow run stage, store data here
  Tensor<DataType, 1> tensor;

  // Flow object for self insertion when modified
  FlowObject flow;

  // Operator for assigning from other variables
  // Does not modify the Flow
  Variable& operator=(const Variable& other)
  {
    src_func = other.src_func;
    tensor = other.tensor;

    return *this;
  }

  // Operator for assigning from functor
  // Adds variable to the Flow, as a new "thing" has just happened
  Variable& operator=(const Functor* func)
  {
    src_func = func;
    flow.add_variable(*this);

    return *this;
  }

  // Operator for comparing variables, may be useful in future
  bool operator==(const Variable& other)
  {
    if ((other.src_func == src_func) && \
      other.tensor == tensor) {
      return true;
    }

    else {
      return false
    }
  }
};

}

#endif
