#include "../psn.h"

void net_permute(NetworkConfiguration& ncfg)
{
  Mutator<double> mu;

  int nsz = ncfg.nc.size();
  int node_drift = mu.get_nd(0, 1 - ncfg.fitness);
  nsz += node_drift;

  if (nsz < int(n_inputs + n_outputs)) {
    nsz = int(n_inputs + n_outputs);
  }

  ncfg.nc.reserve(nsz);

  while (nsz != int(ncfg.nc.size())) {
    if (nsz > int(ncfg.nc.size())) {
      //printf("ncfg.nc.size(): %d\n", ncfg.nc.size());
      NodeonConfiguration node = NodeonConfiguration();
      ncfg.nc.push_back(node);
    }

    else if (nsz < int(ncfg.nc.size())) {
      std::vector<NodeonConfiguration>::iterator node_it;
      unsigned int node_id = mu.get_ud(0, ncfg.nc.size() - 1);
      node_it = ncfg.nc.begin() + node_id;
      ncfg.nc.erase(node_it);
    }
  }

  nsz = ncfg.nc.size();

  int csz = ncfg.cc.size();
  for (unsigned int i = 0; i < nsz; ++i) {
    int connecton_drift = mu.get_nd(0, 1 - ncfg.fitness);
    csz += connecton_drift;

    if (csz < 0) {
      csz = 0;
    }

    int nsz2 = nsz * nsz;
    if (csz > nsz2) {
      csz = nsz2;
    }
  }

  ncfg.cc.reserve(csz);

  while (csz != int(ncfg.cc.size())) {
    if (csz > int(ncfg.cc.size())) {
      unsigned int src_node_id = mu.get_ud(0, nsz - 1);
      unsigned int dst_node_id = mu.get_ud(0, nsz - 1);
      ConnectonConfiguration connecton = ConnectonConfiguration(src_node_id, dst_node_id);
      ncfg.cc.push_back(connecton);
    }

    else if (csz < int(ncfg.cc.size())) {
      std::vector<ConnectonConfiguration>::iterator connecton_it;
      unsigned int connecton_id = mu.get_ud(0, ncfg.cc.size() - 1);
      connecton_it = ncfg.cc.begin() + connecton_id;
      ncfg.cc.erase(connecton_it);
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
