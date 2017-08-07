#ifndef EVN_MUTATOR_H
#define EVN_MUTATOR_H

inline double nd_inverse(double y,
  std::normal_distribution<double>& nd)
{
  double m = nd.mean();
  double s = nd.stddev();

  return std::sqrt(-2.0 * s * std::log(y / s)) + m;
}

// General mutator struct
template <typename Derived = double>
struct Mutator
{
  // Random generators
  std::normal_distribution<Derived> nd;
  std::uniform_real_distribution<Derived> ud;
	std::default_random_engine generator;
  std::random_device rdevice;
  
  // Distribution's standard deviation (default to 0.2)
  constexpr static double s = 0.2;
  
	void reset_nd(double m)
	{ nd = std::normal_distribution<Derived>(m, s); }
	
  void reset_nd(double m, double _s)
  { nd = std::normal_distribution<Derived>(m, _s); }
  
  Derived get_nd()
  { return nd(generator); }
  
  void reset_ud(Derived a, Derived b)
  { ud = std::uniform_real_distribution<Derived>(a, b); }
  
  Derived get_ud()
  { return ud(generator); }
  
  Mutator() {
		generator = std::default_random_engine(rdevice());
	}
	
	void operator=(const Mutator& mu)
	{
		nd = mu.nd;
		ud = mu.ud;
		generator = mu.generator;
	}
};

#endif
