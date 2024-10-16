#SingleInstance
SetWorkingDir(A_ScriptDir)
#WinActivateForce

SetWinDelay -1
SetControlDelay -1

VDA_PATH := A_ScriptDir . "\lib\vda\VirtualDesktopAccessor.dll"
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", VDA_PATH, "Ptr")

global GetDesktopCountProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GetDesktopCount", "Ptr")
global GoToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GoToDesktopNumber", "Ptr")
global GetCurrentDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GetCurrentDesktopNumber", "Ptr")
global MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "MoveWindowToDesktopNumber", "Ptr")

global activeWindowPids := Map()

SetActiveWindowPidForDesktop() {
  activeDesktop := DllCall(GetCurrentDesktopNumberProc, "Int")
  try {
    activePid := WinGetPID("A")
    if(activePid != "") {
      activeWindowPids.Set(activeDesktop, activePid)
    } else {
      activeWindowPids.Set(activeDesktop, -1)
    }
  } catch {
    activeWindowPids.Set(activeDesktop, -1)
  }
}

GetActiveWindowForCurrentDesktop() {
  currentDesktop := DllCall(GetCurrentDesktopNumberProc, "Int")
  return activeWindowPids.Get(currentDesktop, -1)
}

GetDesktopCount() {
  count := DllCall(GetDesktopCountProc, "Int")
  return count
}

MoveCurrentWindowToDesktop(number) {
  activeHwnd := WinGetID("A")
  DllCall(MoveWindowToDesktopNumberProc, "Ptr", activeHwnd, "Int", number, "Int")
}

GoToDesktopNumber(num) {
  if num - 1 > GetDesktopCount() {
    CreateNeededDesktops(num - 1)
  }

  SetActiveWindowPidForDesktop()

  DllCall("User32\AllowSetForegroundWindow", "Int", -1)

  if(WinExist("ahk_class Shell_TrayWnd")) {
    ; Prevent taskbar icons from flashing on desktop switch
    WinActivate "ahk_class Shell_TrayWnd"
    WinWaitActive "ahk_class Shell_TrayWnd"
    DllCall(GoToDesktopNumberProc, "Int", num, "Int")
    WinMinimize "ahk_class Shell_TrayWnd"
  }

  ; Focus last focused window
  newActive := GetActiveWindowForCurrentDesktop()
  try {
    WinActivate "ahk_pid " activeWindowPids[num]
  } catch {
    DllCall(GoToDesktopNumberProc, "Int", num, "Int")
  }

  return
}

CreateNeededDesktops(num) {
  Loop num - GetDesktopCount() {
    CreateDesktop()
  }
}

CreateDesktop() {
  Send "#^d"
}

LaunchTerminal() {
  userDir := EnvGet("USERPROFILE")

  if(FileExist(userDir . "\AppData\Local\Microsoft\WindowsApps\wt.EXE")) {
    Run "wt"
  } else {
    Run "cmd /K cd " . userDir
  }
}

#1::GoToDesktopNumber(0)
#2::GoToDesktopNumber(1)
#3::GoToDesktopNumber(2)
#4::GoToDesktopNumber(3)
#5::GoToDesktopNumber(4)
#6::GoToDesktopNumber(5)
#7::GoToDesktopNumber(6)

#+1::MoveCurrentWindowToDesktop(0)
#+2::MoveCurrentWindowToDesktop(1)
#+3::MoveCurrentWindowToDesktop(2)
#+4::MoveCurrentWindowToDesktop(3)
#+5::MoveCurrentWindowToDesktop(4)
#+6::MoveCurrentWindowToDesktop(5)
#+7::MoveCurrentWindowToDesktop(6)

#+q::WinClose "A"
#f::WinMaximize "A"

#a::Send "#{PrintScreen}"

#Enter::LaunchTerminal()
