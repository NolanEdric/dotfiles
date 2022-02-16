#NoEnv                      ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn                     ; Enable warnings to assist with detecting common errors.
#SingleInstance FORCE       ; Skip invocation dialog box and silently replace previously executing instance of this script.
SendMode Input              ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Toggle := False

$*Esc::
  Toggle := True
  KeyWait, Esc, T0.2
  if !ErrorLevel
    Send {Blind}{Esc}
  KeyWait, Esc
return

#If Toggle

  Esc UP::Toggle := False

  $*1::F13
  $*2::F14
  $*3::F15
  $*4::F16
  $*5::F17
  $*6::F18
  $*7::F19
  $*8::F20
  $*9::F21
  $*0::F22
  $*-::F23
  $*=::F24

#If
