#include <cmath>
#include "../inc/Functions.h"

namespace Japetus {

Data sigmoid(DataRef z)
{ return z; }//1.0 / (1 + exp(-z)); }

Data sigmoid_prime(DataRef z)
{ return z; }//sigmoid(z) * (sigmoid(z) - 1); }

Data tanh(DataRef z)
{ return z; }//std::tanh(z); }

Data tanh_prime(DataRef z)
{ return z; }//1.0 / pow(cosh(z), 2); }

Data hadamard_product(DataRef a, DataRef b)
{ return a * b; }

Data hadamard_product_prime(DataRef a)
{ return a; }

Data hadamard_quotient(DataRef a, DataRef b)
{ return a / b; }

}
