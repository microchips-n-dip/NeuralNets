#ifndef JAPETUS_TENSOR_REF_H
#define JAPETUS_TENSOR_REF_H

namespace Japetus {

namespace tensor {

template <typename Dimensions, typename Scalar>
class TensorLazyEvaluatorBase
{
 public:
  typedef typename Dimensions::Index Index;

  TensorLazyEvaluatorBase() :
    m_refcount(0)
  { }

  virtual ~TensorLazyEvaluatorBase() { }

  virtual const Dimensions& dimensions() const = 0;
  virtual const Scalar* data() const = 0;

  virtual const Scalar coeff(Index index) const = 0;
  virtual Scalar& coeffRef(Index index) = 0;

  void incrRefCount() { ++m_refcount; }
  void decrRefCount() { --m_refcount; }
  Index refCount() const { return m_refcount; }

 private:
  TensorLazyEvaluatorBase(const TensorLazyEvaluatorBase& other);
  TensorLazyEvaluatorBase& operator=(const TensorLazyEvaluatorBase& other);

  Index m_refcount;
};

template <typename Dimensions, typename Expr>
class TensorLazyEvaluatorReadOnly : public TensorLazyEvaluatorBase<Dimensions, typename TensorEvaluator<Expr>::Scalar>
{
 public:
  typedef typename TensorEvaluator<Expr>::Scalar Scalar;
  typedef typename TensorEvaluator<Expr>::Index Index;

  TensorLazyEvaluatorReadOnly(const Expr& expr) :
    m_impl(expr),
    m_dummy(Scalar(0))
  {
    m_dims = m_impl.dimensions();
    m_impl.evalSubExprsIfNeeded(nullptr);
  }

  virtual const Dimensions& dimensions() const { return m_dims; }

  virtual const Scalar* data() const { return m_impl.data(); }

  virtual const Scalar coeff(Index index) const { return m_impl.coeff(index); }

  virtual Scalar& coeffRef(Index index)
  {
    ECHECK(false, "Cannot request reference to coeff of ReadOnly evaluator!");
    return m_dummy;
  }

 protected:
  TensorEvaluator<Expr> m_impl;
  Dimensions m_dims;
  Scalar m_dummy;
};

template <typename Dimensions, typename Expr>
class TensorLazyEvaluatorWritable : public TensorLazyEvaluatorReadOnly<Dimensions, Expr>
{
 public:
  typedef TensorLazyEvaluatorReadOnly<Dimensions, Expr> Base;
  typedef typename Base::Scalar Scalar;
  typedef typename Base::Index Index;

  TensorLazyEvaluatorWritable(const Expr& expr) :
    Base(expr)
  { }

  virtual ~TensorLazyEvaluatorWritable() { }

  virtual Scalar& coeffRef(Index index)
  { return this->m_impl.coeffRef(index); }
};

template <typename Dimensions, typename Expr>
class TensorLazyEvaluator :
  public conditional<bool(is_lvalue<Expr>::value),
    TensorLazyEvaluatorWritable<Dimensions, Expr>,
    TensorLazyEvaluatorReadOnly<Dimensions, const Expr>>::type
{
 public:
  typedef typename conditional<bool(is_lvalue<Expr>::value),
    TensorLazyEvaluatorWritable<Dimensions, Expr>,
    TensorLazyEvaluatorReadOnly<Dimensions, const Expr>>::type Base;
  typedef typename Base::Scalar Scalar;
  typedef typename Base::Index Index;

  TensorLazyEvaluator(const Expr& expr) :
    Base(expr)
  { }

  virtual ~TensorLazyEvaluator() { }
};

template <typename Derived>
struct traits<TensorRef<Derived>> :
  public traits<Derived>
{
  typedef traits<Derived> BaseTraits;
  typedef typename BaseTraits::Scalar Scalar;
  typedef typename BaseTraits::Index Index;
  typedef typename BaseTraits::Indices Indices;

  enum {
    Flags = BaseTraits::Flags
  };
};

template <typename PlainObjectType>
class TensorRef : public TensorBase<TensorRef<PlainObjectType>>
{
 public:
  typedef TensorRef<PlainObjectType> Self;
  typedef traits<PlainObjectType> Traits;
  typedef typename Traits::Index Index;
  typedef typename Traits::Indices Indices;
  typedef typename Traits::Scalar Scalar;
  typedef Scalar CoeffReturnType;

  typedef typename PlainObjectType::Dimensions Dimensions;

  template <typename Expression>
  TensorRef(const Expression& expr) :
    m_evaluator(new TensorLazyEvaluator<Dimensions, Expression>(expr))
  { }

  template <typename Expression>
  TensorRef& operator=(const Expression& expr)
  {
    unrefEvaluator();
    m_evaluator = new TensorLazyEvaluator<Dimensions, Expression>(expr);
    m_evaluator->incrRefCount();
    return *this;
  }

  ~TensorRef() { unrefEvaluator(); }

  TensorRef(const TensorRef& other) :
    m_evaluator(other.m_evaluator)
  {
    ECHECK(m_evaluator->refCount(), "TensorRef construction failed!");
    m_evaluator->incrRefCount();
  }

  TensorRef& operator=(const TensorRef& other)
  {
    if (this != &other) {
      unrefEvaluator();
      m_evaluator = other.m_evaluator;
      ECHECK(m_evaluator->refCount() > 0, "TensorRef assignment failed!");
      m_evaluator->incrRefCount();
    }
    return *this;
  }

  const Dimensions& dimensions() const { return m_evaluator->dimensions(); }

  const Scalar* data() const { return m_evaluator->data(); }

  const Scalar coeff(Index index) const
  { return m_evaluator->coeff(index); }

  Scalar& coeffRef(Index index)
  { return m_evaluator->coeffRef(index); }

  void unrefEvaluator()
  {
    if (m_evaluator) {
      m_evaluator->decrRefCount();
      if (m_evaluator->refCount() == 0) {
        delete m_evaluator;
      }
    }
  }

 private:
  TensorLazyEvaluatorBase<Dimensions, Scalar>* m_evaluator;
};

template <typename Derived>
struct TensorEvaluator<const TensorRef<Derived>>
{
  typedef typename Derived::Index Index;
  typedef typename Derived::Scalar Scalar;
  typedef typename Derived::Scalar CoeffReturnType;
  typedef typename Derived::Dimensions Dimensions;

  TensorEvaluator(const TensorRef<Derived>& m) :
    m_ref(m)
  { }

  const Dimensions& dimensions() const { return m_ref.dimensions(); }

  bool evalSubExprsIfNeeded(Scalar*) { return true; }

  void cleanup() { }

  CoeffReturnType coeff(Index index) const { return m_ref.coeff(index); }

  Scalar& coeffRef(Index index) { return m_ref.coeffRef(index); }

  Scalar* data() const { return m_ref.data(); }

  TensorRef<Derived> m_ref;
};

template <typename Derived>
struct TensorEvaluator<TensorRef<Derived>> : public TensorEvaluator<const TensorRef<Derived>>
{
  typedef typename Derived::Index Index;
  typedef typename Derived::Scalar Scalar;
  typedef typename Derived::Scalar CoeffReturnType;
  typedef typename Derived::Dimensions Dimensions;

  typedef TensorEvaluator<const TensorRef<Derived>> Base;

  TensorEvaluator(TensorRef<Derived>& m) :
    Base(m)
  { }

  Scalar& coeffRef(Index index)
  { return this->m_ref.coeffRef(index); }
};

}

}

#endif
