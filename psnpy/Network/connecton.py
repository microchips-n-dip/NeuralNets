import numpy as np
from math import *

import random

class Connecton:
  def __init__(self, _src, _dst, _network, need_push_src):
    self.src = _src
    self.dst = _dst
    self.network = _network

    if need_push_src:
      self.src.src_connectons.append(self)
    self.dst.dst_connectons.append(self)

    self.weight = np.random.normal(0, 1.0)
    self.c = 0

    self.w_A_plus = 0.1
    self.w_A_minus = 0.15
    self.w_T_plus = 0.02
    self.w_T_minus = 0.11

    self.c_tau = 0.2

  def tm(self):
    self.dst.input_pot += self.weight * self.src.activation

  def stdp(self):
    dt = self.dst.llft - self.src.llft

    if dt >= 0:
      dc = self.w_A_plus * exp(-dt / self.w_T_plus)
    else:
      dc = self.w_A_minus * exp(dt / self.w_T_minus)

    self.c += dc - self.c / self.c_tau

    self.weight += c * self.network.dopamine
