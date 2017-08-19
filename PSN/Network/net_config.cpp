#include "../psn.h"

void net_permute(NetworkConfiguration& ncfg)
{
  Mutator<double> mu;

  int nsz = ncfg.nc.size();
  int node_drift = mu.get_nd(nsz, 1 - ncfg.fitness);
  if (nsz < 20) nsz += node_drift;

  if (nsz < n_inputs + n_outputs) {
    nsz = n_inputs + n_outputs;
  }

  while (nsz != int(ncfg.nc.size())) {
    if (nsz > ncfg.nc.size()) {
      //printf("ncfg.nc.size(): %d\n", ncfg.nc.size());
      NodeonConfiguration node = NodeonConfiguration();
      ncfg.nc.push_back(node);
    }

    else if (nsz < ncfg.nc.size()) {
      std::vector<NodeonConfiguration>::iterator node_it;
      unsigned int node_id = mu.get_ud(0, ncfg.nc.size() - 1);
      node_it = ncfg.nc.begin() + node_id;
      ncfg.nc.erase(node_it);
    }
  }

  for (unsigned int i = 0; i < nsz; ++i) {
    int csz = ncfg.cc.size();
    int connecton_drift = mu.get_nd(csz, 1 - ncfg.fitness);
    if (csz < 20) csz += connecton_drift;

    if (csz < 0) {
      csz = 0;
    }

    while (csz!= ncfg.cc.size()) {
      if (csz > ncfg.cc.size()) {
        unsigned int node_id = mu.get_ud(0, nsz - 1);
        ConnectonConfiguration connecton = ConnectonConfiguration(i, node_id);
        ncfg.cc.push_back(connecton);
      }

      else if (csz + connecton_drift < ncfg.cc.size()) {
        std::vector<ConnectonConfiguration>::iterator connecton_it;
        unsigned int connecton_id = mu.get_ud(0, ncfg.cc.size() - 1);
        connecton_it = ncfg.cc.begin() + connecton_id;
        ncfg.cc.erase(connecton_it);
      }
    }
  }

  printf("Produced network of form (%d, %d)\n", ncfg.nc.size(), ncfg.cc.size());
}

NodeonConfiguration::NodeonConfiguration() { }

ConnectonConfiguration::ConnectonConfiguration(
  unsigned int _src, unsigned int _dst)
{
  src = _src;
  dst = _dst;

  Mutator<double> mu;
  weight = mu.get_nd(0, 1.0);
}

NetworkConfiguration::NetworkConfiguration()
{
  fitness = 0;
  cost = std::numeric_limits<double>::infinity();
}
