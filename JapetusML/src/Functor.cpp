#include "../inc/util.h"
#include "../inc/Functor.h"
#include "../inc/Functions.h"

namespace Japetus {

void SigmoidGradientFunctor::run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs)
{
  ECHECK(inputs->size() == 1, "Sigmoid gradient takes one input!");
  ECHECK(outputs->size() == 1, "Sigmoid gradient gives one output!");
  outputs->at(0) = sigmoid_prime(inputs->at(0));
}

void SigmoidFunctor::run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs)
{
  ECHECK(inputs->size() == 1, "Sigmoid function takes one input!");
  ECHECK(outputs->size() == 1, "Sigmoid function gives one output!");
  outputs->at(0) = sigmoid(inputs->at(0));
}

void TanhGradientFunctor::run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs)
{
  ECHECK(inputs->size() == 1, "Tanh gradient takes one input!");
  ECHECK(outputs->size() == 1, "Tanh gradient gives one output!");
  outputs->at(0) = tanh_prime(inputs->at(0));
}

void TanhFunctor::run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs)
{
  ECHECK(inputs->size() == 1, "Tanh function takes one input!");
  ECHECK(outputs->size() == 1, "Tanh function gives one output!");
  outputs->at(0) = tanh(inputs->at(0));
}

void HadamardProductGradientFunctor::run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs)
{
  ECHECK(inputs->size() == 2, "Hadamard product gradient takes two inputs!");
  ECHECK(outputs->size() == 1, "Hadamard product gradient gives one output!");
  outputs->at(0) = hadamard_product_prime(inputs->at(respect_));
}

void HadamardProductFunctor::run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs)
{
  ECHECK(inputs->size() == 2, "Hadamard product function takes two inputs!");
  ECHECK(outputs->size() == 1, "Hadamard product function gives one output!");
  outputs->at(0) = hadamard_product(inputs->at(0), inputs->at(1));
}

void HadamardQuotientFunctor::run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs)
{
  ECHECK(inputs->size() == 2, "Hadamard quotient function takes two inputs!");
  ECHECK(outputs->size() == 1, "Hadamard quotient function gives one output!");
  outputs->at(0) = hadamard_quotient(inputs->at(0), inputs->at(1));
}

void ConstFunctor::run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs)
{
  ECHECK(inputs->size() == 0, "Const takes no inputs!\n");
  ECHECK(outputs->size() == 1, "Const gives one output!\n");
  outputs->at(0) = val_;
}

}
