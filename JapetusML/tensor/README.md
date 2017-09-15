# Tensor Module
The tensor module is an Eigen-like header-only implementation of variable rank tensors for use in JapetusML as the primary data type

Internals:

 - TensorBase: Class for storing basic tensor data and handling shared operations.

 - Tensor: Class for storing pure tensors and handling tensor assignments.

 - TensorEvaluator: A struct for storing and evaluating data in expressions.

 - TensorRef: A class for containing a reference to some other Tensor object. Used similarly to std::reference_wrapper.

 - TensorCWiseBinaryOp: Class for storing data for future computation of binary Tensor operations.

 - TensorExecutor: Used in the full computation of Tensor expressions.

TODO:

 - Tensor contraction.

 - Tensor reduction.

 - Tensor unary operators.

 - Tensor streams.

 - Multi-index coefficient access.
