#ifndef PSN_NET_CONFIG_H
#define PSN_NET_CONFIG_H

struct NodeonConfiguration
{
  NodeonConfiguration();
};

struct ConnectonConfiguration
{
  unsigned int src;
  unsigned int dst;

  double c;
  double weight;

  ConnectonConfiguration(unsigned int _src, unsigned int _dst);
};

struct NetworkConfiguration
{
  std::vector<NodeonConfiguration> nc;
  std::vector<ConnectonConfiguration> cc;

  double cost;
  double fitness;

  NetworkConfiguration();
};

void net_permute(NetworkConfiguration& ncfg);

#endif

