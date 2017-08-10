class BaseTask:
  def __init__(self):
    self.prior_conditions = []
    self.until_conditions = []

  def add_prior_condition(self, condition):
    self.prior_conditions.append(condition)

  def check_prior_conditions(self):
    state = true
    for condition in prior_conditions:
      state = state && condition.satisfaction(internal_state[condition.state_id])
    return state

  def add_until_condition(self, condition):
    self.until_conditions.append(condition)

  def check_until_conditions(self):
    state = true
    for condition in until_conditions:
      state = state && condition.satisfaction(internal_state[condition.state_id])
    return state

# Handles sensor microtasks
class SensorTask(BaseTask):
  def __init__(self, sensor_id):
    BaseTask.__init__(self)
    self.sensor_id = sensor_id
    self.mode = sensor_task

  def task_run(self):
    # get the sensor data

# Handles motor microtasks
class MotorTask(BaseTask):
  def __init__(self, motor_id):
    self.motor_id = motor_id
    self.mode = motor_task

  def task_run(self):
    # turn the motor


class Task(BaseTask):
  def __init__(self):
    self.subtasks = []

  def add_task(self, task):
    self.subtasks.append(task)

  def task_run(self):
    self.check_prior_conditions()
    while self.check_until_conditions():
      for subtask in self.subtasks:
        subtask.task_run()
