function BootConsoleInfo {
  parameter msg.
  print "[" + time:seconds + "] boot: " + msg.
}

function BootConsoleWarn {
  parameter msg.
  BootConsoleInfo("WARNING: " + msg).
}

function BootConsoleError {
  parameter msg.
  BootConsoleInfo("ERROR: " + msg).
}

set DISK to Core:Volume.
set EXE to "GUIDE_BOOST.ks".

set StartupOK to false.

when StartupOK then {
  BootConsoleInfo("Started!").
  run EXE.
}

switch to DISK.
if exists("archive:/" + EXE) {
  copypath("archive:/" + EXE, "").
  set StartupOK to true.
} else {
  BootConsoleError("Could not find executable").
}
