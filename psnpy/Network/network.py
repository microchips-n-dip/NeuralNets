import numpy as np
import random
from math import *

import nodeon

class Network:
  def __init__(self):
    self.nodeons = []

    self.cost_saved = 0
    self.cost_saved_valid = False
    self.fit_saved = 0
    self.fit_saved_valid = False

    self.last_cost = float("inf")

    self.samples = []

  def adaptive(self):
    return 1 - self.fitness()

  def mutate(self):
    nsz = self.nodeons.size()
    node_drift = numpy.random.normal(nsz, self.adaptive())

    while (nsz + node_drift) != self.nodeons.size():
      if nsz + node_drift > self.nodeons.size():
        self.nodeons.append(nodeon.Nodeon(self))
      elif nsz + node_drift < self.nodeons.size():
        self.nodeons.erase(random.randint(0, self.nodeons.size() - 1))

    for node in self.nodeons:
      node.mutate()

  def net_run(self, time):
    stime = network_time
    while network_time < stime + time:
      for node in self.nodeons:
        node.lf()
      network_time += 0.1

  def cost(self):
    if cost_saved_valid == true:
      return cost_saved
    else:
      misaligned = 0
      for sample in self.samples:
        self.output = sample.size * []
        self.input = sample.input_data
        self.net_run(self.nrac)
        for i in range(0, sample.size - 1):
          misaligned += abs(self.output - sample.output_data)
      self.cost_saved = misaligned
      self.cost_saved_valid = true
      return misaligned

  def fitness(self):
    if self.fit_saved_valid == true:
      return self.fit_saved
    else:
      c_cost = self.cost()
      ret = 1 - exp(-self.last_cost / c_cost)
      self.last_cost = c_cost
      self.fit_saved = ret
      self.fit_saved_valid = true
      return ret

  def run(self, cycles):
    for t in range(0, cycles):
      self.dopamine = self.fitness()
      self.cost_saved_valid = false
      self.fit_saved_valid = false
