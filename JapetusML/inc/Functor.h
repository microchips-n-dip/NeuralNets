#ifndef JAPETUS_FUNCTOR_H
#define JAPETUS_FUNCTOR_H

#include <vector>
#include "../inc/Functions.h"
#include "../tensor/Tensor"

namespace Japetus {

typedef tensor::Tensor<double> Data;
typedef tensor::TensorRef<Data> DataRef;

// Functor Bases
struct Functor
{
  unsigned int in_size_;
  unsigned int out_size_;

  unsigned int in_size() const { return (*this).in_size_; }
  unsigned int out_size() const { return (*this).out_size_; }

  virtual void run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs) = 0;
  virtual Functor* gradient(int respect) const = 0;
};

struct GradientFunctor :
  public Functor
{
  int respect_;

  Functor* gradient(int respect) const
  { return nullptr; }
};

// Functor implementation
struct SigmoidGradientFunctor :
  public GradientFunctor
{
  SigmoidGradientFunctor(int respect)
  {
    in_size_ = 1;
    out_size_ = 1;
    respect_ = respect;
  }

  void run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs);
};

struct SigmoidFunctor :
  public Functor
{
  SigmoidFunctor()
  {
    in_size_ = 1;
    out_size_ = 1;
  }

  void run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs);

  Functor* gradient(int respect) const
  { return new SigmoidGradientFunctor(respect); }
};

struct TanhGradientFunctor :
  public GradientFunctor
{
  TanhGradientFunctor(int respect)
  {
    in_size_ = 1;
    out_size_ = 1;
    respect_ = respect;
  }

  void run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs);
};

struct TanhFunctor :
  public Functor
{
  TanhFunctor()
  {
    in_size_ = 1;
    out_size_ = 1;
  }

  void run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs);

  Functor* gradient(int respect) const
  { return new TanhGradientFunctor(respect); }
};

struct HadamardProductGradientFunctor :
  public GradientFunctor
{
  HadamardProductGradientFunctor(int respect)
  {
    in_size_ = 2;
    out_size_ = 1;
    respect_ = respect;
  }

  void run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs);
};

struct HadamardProductFunctor :
  public Functor
{
  HadamardProductFunctor()
  {
    in_size_ = 2;
    out_size_ = 1;
  }

  void run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs);

  Functor* gradient(int respect) const
  { return new HadamardProductGradientFunctor(respect); }
};

struct HadamardQuotientFunctor :
  public Functor
{
  HadamardQuotientFunctor()
  {
    in_size_ = 2;
    out_size_ = 1;
  }

  void run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs);

  Functor* gradient(int respect) const
  { return nullptr; }
};

struct ConstFunctor:
  public Functor
{
  const Data val_;
  ConstFunctor(Data val)
    : val_(val)
  {
    in_size_ = 0;
    out_size_ = 1;
  }

  void run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs);

  Functor* gradient(int respect) const
  { return new ConstFunctor(0); }
};

struct PlaceholderFunctor :
  public Functor
{
  void run(std::vector<DataRef>* inputs, std::vector<DataRef>* outputs) { }
  Functor* gradient(int respect) const
  { return new PlaceholderFunctor; }
};

}

#endif
