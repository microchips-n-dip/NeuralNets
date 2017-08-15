import numpy as np
from math import *

import connecton

class Nodeon:
  def __init__(self, _network):
    self.network = _network
    self.src_connectons = []
    self.dst_connectons = []

  def add_random_connecton(self):
    nsz = self.network.nodeons.size()
    dst_node = random.randint(0, nsz - 1)
    self.src_connectons.append(connecton.Connecton(self, self.network.nodeons[dst_node], self.network, false))

  def remove_random_connecton(self):
    csz = self.src_connectons.size()
    connecton_id = random.randint(0, csz - 1)
    self.src_connectons[csz - 1].loc_in_src = connecton_id
    self.src_conenctons[connecton_id] = self.src_connectons[csz - 1]
    self.src_connectons.pop()

  def mutate(self):
    csz = self.src_connectons.size()
    connecton_drift = np.random.normal(csz, self.network.adaptive())

    while csz + connecton_drift != self.src_connectons.size():
      if csz + connecton_drift > self.src_connectons.size():
        self.add_random_connecton()
      elif csz + connecton_drift < self.src_connectons.size():
        self.remove_random_connecton()

  def sigmoid(self, z):
    return 1 / (1 + exp(-z))

  def activation_function(self):
    self.activation = self.sigmoid(self.input_pot) + np.random.normal(0, self.network.adaptive())
    self.input_pot = 0
    self.spike = false

    if self.ntype == -1:
      if self.number == self.network.c_input():
        self.activation = 1.0
      else:
        self.activation = 0.0

    if self.activation > 0.5:
      self.spike = true
      self.llft = self.network.network_time

      if self.ntype == 1:
        self.network.c_output(self.number)
      if self.ntype == 2:
        self.network.global_i += 1
      if self.ntype == -2:
        self.network.global_i -= 1

    for connecton in self.src_connectons:
      connecton.tm()

    for connecton in self.dst_connectons:
      connecton.stdp()

