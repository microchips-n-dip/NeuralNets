parameter KSIGINIT is false.

function KernelConsoleInfo {
  parameter msg.
  print "[" + time:seconds + "] kernel: " + msg.
}

function KernelConsoleWarn {
  parameter msg.
  BootConsoleInfo("WARNING: " + msg).
}

function KernelConsoleError {
  parameter msg.
  BootConsoleInfo("ERROR: " + msg).
}

set DISK to Core:Volume.
set EXE to "GUIDE_PROBE.ks".

set StartupOK to false.

switch to DISK.
if exists("archive:/" + EXE) {
  copypath("archive:/" + EXE, "").
  set StartupOK to true.
} else {
  BootConsoleError("Could not find executable").
}

set KernelSignal to KSIGINIT.

when not ship:messages:empty then {
  set recv to ship:messages:pop.
  if recv:content = "Startup" {
    KernelConsoleInfo("Entering startup...").
    set KernelSignal to true.
    return false.
  } else {
    return true.
  }
}

KernelConsoleInfo("Waiting for boot signal...").
wait until KernelSignal.

if StartupOK {
  KernelConsoleInfo("Started!").
  runpath(EXE).
}
