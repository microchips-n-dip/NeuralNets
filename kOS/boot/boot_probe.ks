clearscreen.

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
set KERN to "kernel_probe.ks".

set StartupOK to false.

switch to DISK.
if exists("archive:/" + KERN) {
  copypath("archive:/" + KERN, "").
  set StartupOK to true.
} else {
  BootConsoleError("Could not find kernel").
}

if StartupOK {
  BootConsoleInfo("Starting kernel").
  runpath(KERN).
}
