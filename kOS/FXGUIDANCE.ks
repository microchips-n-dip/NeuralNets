// Attitude control logic
RCS ON.

set vess to ship.
declare orient_locked is false.

set vess_dir to vess:up.
lock d_pitch to vess_dir:pitch.
lock d_yaw to vess_dir:yaw.

set PitchPID to PIDLoop().
set PitchPID:KP to 0.85.
set PitchPID:KI to 0.5.
set PitchPID:KD to 0.1.
set PitchPID:MaxOutput to 0.75.
set PitchPID:MinOutput to -0.75.

set YawPID to PIDLoop().
set YawPID:KP to 0.85.
set YawPID:KI to 0.5.
set YawPID:KD to 0.1.
set YawPID:MaxOutput to 0.75.
set YawPID:MinOutput to -0.75.

lock PitchRate to PitchPID:Update(time:seconds, d_pitch).
lock YawRate to YawPID:Update(time:seconds, d_yaw).

when orient_locked then {
  set vess:control:pitch to -PitchRate.
  set vess:control:yaw to -YawRate.
  return true.
}

clearscreen.

// Main execution
set phase to 0.

set vess0 to 0.
set vess1 to 0.

set vess0_burn_done to false.
set vess1_burn_done to false.

when vess:altitude < 40000 then {
  if phase = 2 {
    print "Phase 3 interrupt".
    set phase to 3.
    return false.
  } else {
    return true.
  }
}

// Vessel startup
print "Computer on...".

until phase = 5 {
  if phase = 0 {
    // Launch countdown
    from {local countdown is 10.}
    until countdown = 0 step {
      set countdown to countdown - 1.
    } do {
      print "Launch T-" + countdown.
      wait 1.
    }
  
    print "Launch!".

    // Gravity turn parameters
    set gturn_goal to 50000.
    set gturn_max to 90.
    set gturn_step to gturn_goal / gturn_max.

    set alt_start to vess:altitude.

    // Throttle up and launch
    lock throttle to 1.0.
    lock steering to up.
    stage.

    until vess:apoapsis > 150000 {
      set gturn_inc to (vess:altitude - alt_start) / gturn_step.
      if gturn_inc < gturn_max {
        lock steering to heading(90, 90 - gturn_inc).
      }
    }

    print "Completed gravity turn".
    set phase to 1.
  }

  if phase = 1 {
    set throttle to 0.0.
    set vess:control:pilotmainthrottle to 0.0.
    unlock throttle.
    unlock steering.
    toggle ag1.

    set vess to vessel("Falcon X Test Probe").
    print "Switched to vessel " + vess:name.
    wait 5.

    kuniverse:forceactive(vess).

    print "Turning retrograde...".

    set steeringmanager:maxstoppingtime to 5.
    lock steering to vess:retrograde.
    wait until vang(vess:facing:vector, vess:retrograde:vector) < 3.

    print "Retroburn...".

    lock throttle to 1.0.
    wait until vess:apoapsis < (vess:altitude + 1000).
    lock throttle to 0.0.

    unlock throttle.
    unlock steering.

    print "Finished retroburn!".
    set phase to 2.
  }

  // Switch to two-vessel mode
  if phase = 2 {
    set vess0 to vessel("Falcon X Test").
    set vess1 to vessel("Falcon X Test Probe").

    set vess0_burn_done to false.
    set vess1_burn_done to false.
    if vess0_burn_done and vess1_burn_done {
      set phase to 5.
    }
  }

  if phase = 3 {
    kuniverse:forceactive(vess1).
    set vess to vess1.
    set vess_dir to vess:srfretrograde.
    set orient_locked to true.
    wait until vang(vess:facing:vector, vess_dir:vector) < 5.
    set vess:control:pilotmainthrottle to 1.0.
    wait until vess:airspeed < 200.
    set vess:control:pilotmainthrottle to 0.0.
    set orient_locked to false.
    set vess1_burn_done to true.
    set phase to 2.
  }
}

print "Done!".
