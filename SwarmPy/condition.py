## Temporarily writing conditional code here
class Condition:
  def __init__(self, limit, state_id, mode):
    self.mode = mode
    self.limit = limit
    self.state_id = state_id

  def satisfaction(self):
    return false # This is an abstract base class, nothing applies

# Class for if equal to
class EqCondition(Condition):
  def __init__(self, limit, state_id, mode):
    # Initialize base
    Condition.__init__(self, limit, state_id, mode)

  def satisfaction(self, var):
    return (var == limit)

# Class for if not equal to
class NeqCondition(Condition):
  def __init__(self, limit, state_id, mode):
    Condition.__init__(self, limit, state_id, mode)

  def satisfaction(self, var):
    return (var != limit)


