internal_state = []
n_sensors = 2
n_motors = 4
sensor_begin = 0
motor_begin = n_sensors

def mod_internal_mspeed(motor_id, motor_speed):
  global internal_state
  internal_state[motor_begin + 2 * motor_id] = motor_speed

def mod_internal_mpos(motor_id, motor_speed):
  global internal_state
  internal_state[motor_begin + 2 * motor_id + 1] += motor_speed

def turn_motor(motor_id, motor_speed):
  mod_internal_mspeed(motor_id, motor_speed)
  mod_internal_mpos(motor_id, motor_speed)
  TURN_MOTOR_REPLACEMENT_FUNCTION(motor_id, motor_speed)

def mod_internal_sensor_value(sensor_id, sensor_value):
  global internal_state
  internal_state[sensor_begin + sensor_id] = sensor_value

def measure_sensor(sensor_id, sensor_value):
  mod_internal_sensor_value(sensor_id, sensor_value)
  MEASURE_SENSOR_REPLACEMENT_FUNCTION(sensor_id, sensor_value)
