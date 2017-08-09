from collections import namedtuple as ntuple

### A map of all the words with their associated tasks ###
wmap = {}
wmap.update({'go': })

class NLCompiler(object):
  def __init__(self, fname):
    self.fname = fname
    self.file = open(fname, 'r')

  def finish(self):
    self.file.close()

  def run(self):
    self.c_line = self.file.readline()
