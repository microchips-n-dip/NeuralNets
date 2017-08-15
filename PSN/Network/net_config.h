#ifndef PSN_NET_CONFIG_H
#define PSN_NET_CONFIG_H

struct ConnectonConfiguration
{
  unsigned int source;
  unsigned int destination;
  double weight;
};

struct NetworkConfiguration
{
  unsigned int nsz;
  unsigned int csz;

  std::vector<ConnectonConfiguration> connecton_configuration;
};

#endif

