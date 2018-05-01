// Interrupt manager
set ints to Stack().
set pending_ints to Queue().

set magic to false.
lock int0_end_cond to magic.
lock int1_end_cond to magic.

when ints:length > 0 then {
  set int to ints:peek().
  set end_cond to false.

  print "Interrupt stack "+ints.
  if int = 0 {
    if int0_end_cond {
      set end_cond to true.
    } else {
      print "Interrupt 0".
      pending_ints:push(1).
    }
  }
  else if int = 1 {
    if int1_end_cond {
      set end_cond to true.
    } else {
      print "Interrupt 1".
      set magic to true.
    }
  }
  if end_cond {
    ints:pop().
  }
  until pending_ints:length = 0 {
    ints:push(pending_ints:pop()).
  }
  return true.
}

ints:push(0).
wait until false.
