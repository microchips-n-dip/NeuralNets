#ifndef LSTM_WEIGHTS_H
#define LSTM_WEIGHTS_H

template <WeightType>
class LSTMWeight
{
  public:

  WeightType f_gate;
  WeightType i_gate;
  WeightType u_gate;
  WeightType o_gate;

  LSTMWeight(unsigned int source_sz,
    unsigned int destination_sz)
  {
    std::random_device generator;
    std::uniform_real_distribution<double> ud;

    f_gate = WeightType(source_sz, destination_sz);
    i_gate = WeightType(source_sz, destination_sz);
    u_gate = WeightType(source_sz, destination_sz);
    o_gate = WeightType(source_sz, destination_sz);

    for (unsigned int i = 0; i < source_sz * destination_sz; ++i) {
      f_gate.coeffRef(i) = ud(generator);
      i_gate.coeffRef(i) = ud(generator);
      u_gate.coeffRef(i) = ud(generator);
      o_gate.coeffRef(i) = ud(generator);
    }
  }
};

template <typename WeightType>
class LSTMWeights
{
  public:

  typedef LSTMWeight<WeightType> Weight;
  std::vector<Weight> weights;

  Weight& at(unsigned int idx)
  { return weights.at(idx); }

  template <typename A>
  LSTMWeights(unsigned int layers,
    std::initializer_list<A> cell_widths)
  {
    weights.reserve(layers - 1);

    std::initializer_list<A>::iterator it;
    for (it = cell_widths.begin(); it < cell_width.end() - 1; ++it) {
      weights.push_back(Weight(*it, *(it + 1)));
    }
  }
};

#endif
