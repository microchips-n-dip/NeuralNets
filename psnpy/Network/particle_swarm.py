import numpy as np
import network

class ParticleSwarm:
  def __init__(self):
    self.n_paths = 20
    self.paths = []
    self.c_net = network.Network()

  def path_reset(self):
    self.paths = []
    self.paths.append(self.c_net)

  def path_branch(self):
    for path in self.paths:
      path.mutate()
      path.run(2)

    for path in self.paths:
      if path.fitness() >= self.c_net.fitness():
        self.c_net = path

    self.paths = []

