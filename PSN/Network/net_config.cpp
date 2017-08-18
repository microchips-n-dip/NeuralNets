#include "../psn.h"

void net_permute(NetworkConfiguration& ncfg)
{
  Mutator<double> mu;

  int nsz = ncfg.nc.size();
  int node_drift = mu.get_nd(nsz, 1 - ncfg.fitness);
  nsz += node_drift;

  if (nsz < 0) {
    nsz = 0;
  }

  while (nsz != ncfg.nc.size()) {
    if (nsz > ncfg.nc.size()) {
      ncfg.nc.push_back(NodeonConfiguration());
    }

    else if (nsz < ncfg.nc.size()) {
      unsigned int node_id = mu.get_ud(0, ncfg.nc.size() - 1);
      ncfg.nc.at(node_id) = *(ncfg.nc.end() - 1);
      ncfg.nc.pop_back();
    }
  }

  for (unsigned int i = 0; i < nsz; ++i) {
    int csz = ncfg.cc.size();
    int connecton_drift = mu.get_nd(csz, 1 - ncfg.fitness);
    csz += connecton_drift;

    if (csz < 0) {
      csz = 0;
    }

    while (csz!= ncfg.cc.size()) {
      if (csz > ncfg.cc.size()) {
        unsigned int node_id = mu.get_ud(0, ncfg.nc.size() - 1);
        ncfg.cc.push_back(ConnectonConfiguration(i, node_id));
      }

      else if (csz + connecton_drift < ncfg.cc.size()) {
        std::vector<ConnectonConfiguration>::iterator connecton_it;
        unsigned int connecton_id = mu.get_ud(0, ncfg.cc.size() - 1);
        connecton_it = ncfg.cc.begin() + connecton_id;
        ncfg.cc.erase(connecton_it);
      }
    }
  }
}

ConnectonConfiguration::ConnectonConfiguration(
  unsigned int _src, unsigned int _dst)
{
  src = _src;
  dst = _dst;

  Mutator<double> mu;
  weight = mu.get_nd(0, 1.0);
}
