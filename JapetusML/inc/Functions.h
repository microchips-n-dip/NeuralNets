#ifndef JAPETUS_FUNCTIONS_H
#define JAPETUS_FUNCTIONS_H

typedef double Data;

namespace Japetus {

Data sigmoid_prime(Data z);
Data sigmoid(Data z);
Data tanh_prime(Data z);
Data tanh(Data z);
Data hadamard_product_prime(Data a);
Data hadamard_product(Data a, Data b);

}

#endif
