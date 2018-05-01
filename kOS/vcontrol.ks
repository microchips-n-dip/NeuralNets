// Attitude control logic
set vess to ship.
declare orient_locked is false.

set vess_dir to vess:up.
lock d_pitch to vess_dir:pitch.
lock d_yaw to vess_dir:yaw.

set PitchPID to PIDLoop().
set PitchPID:KP to 0.85.
set PitchPID:KI to 0.5.
set PitchPID:KD to 0.1.

set YawPID to PIDLoop().
set YawPID:KP to 0.85.
set YawPID:KI to 0.5.
set YawPID:KD to 0.1.

lock PitchRate to PitchPID:Update(time:seconds, d_pitch).
lock YawRate to YawPID:Update(time:seconds, d_yaw).

when orient_locked = true then {
  set vess:control:pitch to vess:control:pitch + PitchRate.
  set vess:control:yaw to vess:control:yaw + YawRate.
  print "*Trying* to orient".
  return true.
}.

set orient_locked to true.

wait until false.