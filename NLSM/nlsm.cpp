#include "LSTM/lstm.h"
#include "LSM/lsm.h"

using Eigen::Tensor;

const unsigned int n_inputs = 8;
const unsigned int n_outputs = 8;

int main(void)
{
  unsigned int ntm;
  unsigned int stm;

  unsigned int nio = n_inputs + n_outputs;

  LSTM l1 = LSTM(4, {nio, round(0.5 * nio), round(0.75 * nio), 4});
  LSTM l2 = LSTM(6, {4, 2, 5, 5, 5, 2});

  while (true) {
    Tensor<double, 1> abstract_layout = l1.forward(/* something */);

    // Maybe some FFNs to determine ntm and stm?
    ntm = ...;
    stm = ...;

    for (unsigned int i = 0; i < stm; ++i) {
      Tensor<double, 1> syn_cfg = static_cast<double>(stm) * \
        l2.forward(abstract_layout.concatenate(i / \
        static_cast<double>(stm)));

      Nodeon* src = net.nodeons.at(syn_cfg(0));
      Nodeon* dst = net.nodeons.at(syn_cfg(1));
      construct_connecton(src, dst, net);
    }

    net.net_run(1024);
  }
}
