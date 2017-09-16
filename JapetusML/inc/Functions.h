#ifndef JAPETUS_FUNCTIONS_H
#define JAPETUS_FUNCTIONS_H

#include "../tensor/Tensor"

namespace Japetus {

typedef tensor::Tensor<double> Data;
typedef tensor::TensorRef<Data> DataRef;

Data sigmoid_prime(DataRef z);
Data sigmoid(DataRef z);
Data tanh_prime(DataRef z);
Data tanh(DataRef z);
Data hadamard_product_prime(DataRef a);
Data hadamard_product(DataRef a, DataRef b);
Data hadamard_quotient(DataRef a, DataRef b);

}

#endif
