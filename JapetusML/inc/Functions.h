#ifndef JAPETUS_FUNCTIONS_H
#define JAPETUS_FUNCTIONS_H

#include "../tensor/Tensor"

namespace Japetus {

typedef tensor::Tensor<double> Data;

Data sigmoid_prime(const Data& z);
Data sigmoid(const Data& z);
Data tanh_prime(const Data& z);
Data tanh(const Data& z);
Data hadamard_product_prime(const Data& a);
Data hadamard_product(const Data& a, const Data& b);
Data hadamard_quotient(const Data& a, const Data& b);

}

#endif
