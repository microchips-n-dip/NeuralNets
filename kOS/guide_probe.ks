parameter start_phase is 0.

print "Probe Guidance Computer On".

set phase to start_phase.

until phase = 2 {
  if phase = 0 {
    until ship:availablethrust > 0 {
      stage.
      wait 1.
    }
    toggle panels.
    set phase to 1.
  }

  if phase = 1 {
    set n to Node(0, 0, 0, 0).

    set body to ship:body.
    set a to ship:apoapsis + body:radius.
    set v to sqrt(body:mu / a).
    lock dv to v - ship:velocity:orbit:mag.
    set accel to ship:availablethrust / ship:mass.
    lock dt to dv / accel.

    set n:eta to eta:apoapsis.
    set n:prograde to v.
    add n.

    print "Computed orbital velocity to be: " + v.

    lock steering to n:deltav.
    wait until vang(ship:facing:vector, n:deltav) < 10.
    wait until eta:apoapsis <= 0.5 * dt.
    print "Delta-v: " + dv.
    lock throttle to 1.0.
    wait until ship:velocity:orbit:mag >= v.
    lock throttle to 0.0.
    wait 1.

    remove n.

    unlock dv.
    unlock dt.

    unlock throttle.
    unlock steering.
    set phase to 2.
  }
}
