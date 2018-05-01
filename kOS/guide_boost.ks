parameter start_phase is 0.

RCS ON.
set ship:control:pilotmainthrottle to 0.0.

set v_name to ship:name.

// Main execution
set phase to start_phase.

when ship:altitude < 40000 then {
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

    set alt_start to ship:altitude.

    // Throttle up and launch
    lock throttle to 1.0.
    lock steering to up.

    wait 1.
    stage.

    until ship:apoapsis > 150000 {
      set gturn_inc to (ship:altitude - alt_start) / gturn_step.
      if gturn_inc < gturn_max {
        lock steering to heading(90, 90 - gturn_inc).
      }
    }

    lock throttle to 0.0.
    wait 1.

    unlock throttle.
    unlock steering.

    print "Completed gravity turn".
    set phase to 1.
  }

  if phase = 1 {
    toggle ag1.
    wait 5.

    set C to Vessel(v_name):Connection.
    C:SendMessage("Startup").

    print "Turning retrograde...".

    set steeringmanager:maxstoppingtime to 10.
    lock vdir to ship:retrograde.
    lock steering to vdir.
    wait until vang(ship:facing:vector, vdir:vector) < 3.
    set steeringmanager:maxstoppingtime to 5.

    print "Retroburn...".

    lock throttle to 1.0.
    wait until ship:apoapsis < (ship:altitude + 1000).
    lock throttle to 0.0.
    wait 1.

    unlock throttle.
    unlock steering.

    print "Finished retroburn!".
    set phase to 2.
  }

  // Phase 2 is intermediary

  if phase = 3 {
    lock vdir to ship:srfretrograde.
    lock steering to vdir.
    wait until vang(ship:facing:vector, vdir:vector) < 5.
    lock throttle to 1.0.
    wait until ship:airspeed < 200.
    lock throttle to 0.0.
    wait 1.

    unlock throttle.
    unlock steering.
    set phase to 2.
  }
}

print "Done!".
