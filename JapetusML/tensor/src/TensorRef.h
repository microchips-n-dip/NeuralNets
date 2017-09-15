#ifndef JAPETUS_TENSOR_REF
#define JAPETUS_TENSOR_REF

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

 private:
  TensorLazyEvaluatorBase(const TensorLazyEvaluator& other);
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

  virtual Scalar& coeffRef(Index index) const
  {
    ECHECK(false, "Cannot request reference to coeff of ReadOnly evaluator!");
    return m_dummy;
  }

 private:
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
class TensorLazyEvaluator;

template <typename Dimensions, typename Expr>
class TensorLazyEvaluator<Dimensions, const Expr> :
  public TensorLazyEvaluatorReadOnly<Dimensions, const Expr>
{
 public:
  typedef TensorLazyEvaluatorReadOnly<Dimensions, const Expr> Base;
  typedef typename Base::Scalar;
  typedef typename Base::Index;

  TensorLazyEvaluator(const Expr& expr) :
    Base(expr)
  { }

  virtual ~TensorLazyEvaluator() { }
};

template <typename Dimensions, typename Expr>
class TensorLazyEvaluator<Dimensions, Expr> :
  public TensorLazyEvaluatorWritable<Dimensions, Expr>
{
 public:
  typedef TensorLazyEvaluatorWritable<Dimensions, Expr> Base;
  typedef typename Base::Scalar Scalar;
  typedef typename Base::Index Index;

  TensorLazyEvaluator(const Expr& expr) :
    Base(expr)
  { }

  virtual ~TensorLazyEvaluator() { }
};

template <typename PlainObjectType>
class TensorRef : TensorBase<TensorRef<PlainObjectType>>
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
    m_evaluator(new TensorLazyEvaluatorBase<Dimensions, Expression>(expr))
  { }
};

}

}

#endif