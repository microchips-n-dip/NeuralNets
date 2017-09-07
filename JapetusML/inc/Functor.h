#ifndef JAPETUS_FUNCTOR_H
#define JAPETUS_FUNCTOR_H

#include <vector>
#include "../inc/Functions.h"

typedef double Data;

namespace Japetus {

// Functor Bases
struct Functor
{
  virtual void run(std::vector<Data>* inputs, std::vector<Data>* outputs) = 0;
  virtual Functor* gradient(int respect) const = 0;
};

struct GradientFunctor :
  public Functor
{
  int respect_;

  Functor* gradient(int respect) const
  { return nullptr; }
};

// Functor implementations
#define FUNCTOR(Name) struct Name : public Functor
#define GRADIENT_FUNCTOR(Name) struct Name : public GradientFunctor

GRADIENT_FUNCTOR(SigmoidGradientFunctor)
{
  SigmoidGradientFunctor(int respect)
  { respect_ = respect; }

  void run(std::vector<Data>* inputs, std::vector<Data>* outputs);
};

FUNCTOR(SigmoidFunctor)
{
  void run(std::vector<Data>* inputs, std::vector<Data>* outputs);

  Functor* gradient(int respect) const
  { return new SigmoidGradientFunctor(respect); }
};

GRADIENT_FUNCTOR(TanhGradientFunctor)
{
  TanhGradientFunctor(int respect)
  { respect_ = respect; }

  void run(std::vector<Data>* inputs, std::vector<Data>* outputs);
};

FUNCTOR(TanhFunctor)
{
  void run(std::vector<Data>* inputs, std::vector<Data>* outputs);

  Functor* gradient(int respect) const
  { return new TanhGradientFunctor(respect); }
};

GRADIENT_FUNCTOR(HadamardProductGradientFunctor)
{
  HadamardProductGradientFunctor(int respect)
  { respect_ = respect; }

  void run(std::vector<Data>* inputs, std::vector<Data>* outputs);
};

FUNCTOR(HadamardProductFunctor)
{
  void run(std::vector<Data>* inputs, std::vector<Data>* outputs);

  Functor* gradient(int respect) const
  { return new HadamardProductGradientFunctor(respect); }
};

FUNCTOR(PlaceholderFunctor)
{
  void run(std::vector<Data>* inputs, std::vector<Data>* outputs) { }
  Functor* gradient(int respect) const
  { return new PlaceholderFunctor; }
};

}

#endif
