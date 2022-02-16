#NoEnv                      ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn                     ; Enable warnings to assist with detecting common errors.
#SingleInstance FORCE       ; Skip invocation dialog box and silently replace previously executing instance of this script.
SendMode Input              ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Toggle := False

$*CapsLock::
  Toggle := True
  KeyWait, CapsLock, T0.2
  if !ErrorLevel
    Send {Blind}{CapsLock}
  KeyWait, CapsLock
return

#If Toggle
  CapsLock UP::Toggle := False

  $*6::
    if (GetKeyState("NumLock","T")) 
      Send {Blind}{Numpad7} 
    else 
      Send {Blind}{NumpadHome} 
    return
  $*7::
    if (GetKeyState("NumLock","T")) 
      Send {Blind}{Numpad8} 
    else 
      Send {Blind}{NumpadUp} 
    return
  $*8::
    if (GetKeyState("NumLock","T")) 
      Send {Blind}{Numpad9} 
    else  
      Send {Blind}{NumpadPgUp} 
    return
  $*y::
    if (GetKeyState("NumLock","T")) 
      Send {Blind}{Numpad4} 
    else 
      Send {Blind}{NumpadLeft} 
    return
  $*u::
    if (GetKeyState("NumLock","T")) 
      Send {Blind}{Numpad5} 
    else 
      Send {Blind}{NumpadClear} 
    return
  $*i::
    if (GetKeyState("NumLock","T")) 
      Send {Blind}{Numpad6} 
    else 
      Send {Blind}{NumpadRight} 
    return
  $*h::
    if (GetKeyState("NumLock","T")) 
      Send {Blind}{Numpad1} 
    else 
      Send {Blind}{NumpadEnd} 
    return
  $*j::
    if (GetKeyState("NumLock","T")) 
      Send {Blind}{Numpad2} 
    else 
      Send {Blind}{NumpadDown} 
    return
  $*k::
    if (GetKeyState("NumLock","T")) 
      Send {Blind}{Numpad3} 
    else 
      Send {Blind}{NumpadPgDn} 
    return
  $*n::
    if (GetKeyState("NumLock","T")) 
      Send {Blind}{Numpad0} 
    else 
      Send {Blind}{NumpadIns} 
    return
  $*m::Send {Blind}{SendRaw 000}
  $*,::
    if (GetKeyState("NumLock","T")) 
      Send {Blind}{NumpadDot}
    else 
      Send {Blind}{NumpadDel} 
    return

  $*Space::LWin
  $*5::NumLock

#If


