#include <cmath>
#include "../inc/Functions.h"

namespace Japetus {

Data sigmoid(Data z)
{ return 1.0 / (1 + exp(-z)); }

Data sigmoid_prime(Data z)
{ return sigmoid(z) * (sigmoid(z) - 1); }

Data tanh(Data z)
{ return std::tanh(z); }

Data tanh_prime(Data z)
{ return 1.0 / pow(cosh(z), 2); }

Data hadamard_product(Data a, Data b)
{ return a * b; }

Data hadamard_product_prime(Data a)
{ return a; }

Data hadamard_quotient(Data a, Data b)
{ return a / b; }

}
