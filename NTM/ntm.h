#ifndef NTM_H
#define NTM_H

template <int MemSize, MemLength>
class NTM
{
  public:

  // NTM weight matrices
  std::list<Eigen::Matrix<double, Eigen::Dynamic, Eigen::Dynamic>> \
    ntm_weights;

  // NTM memory
  Eigen::Matrix<double, MemSize, MemLength> Memory;

  double w_beta;
  double w_g;
  double w_s; // S implementation remains to be seen
  double w_gamma;

  NTM();
  ~NTM();

  Eigen::Matrix<double, Eigen::Dynamic, Eigen::Dynamic>
  forward(Eigen::Matrix<double, Eigen::Dynamic, Eigen::Dynamic> x);
};

#endif
