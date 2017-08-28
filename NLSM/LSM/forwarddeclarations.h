#ifndef FORWARD_DECLARATIONS_H
#define FORWARD_DECLARATIONS_H

class Nodeon;
class Connecton;
class Network;
class ParticleSwarm;

void construct_nodeon(Network* net);
void construct_connecton(Nodeon* src, Nodeon* dst, Network* net);
void destroy_nodeon(Nodeon* n);
void destroy_connecton(Connecton* c);

#endif

