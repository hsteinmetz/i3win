#SingleInstance
SetWorkingDir(A_ScriptDir)
#WinActivateForce

SetWinDelay -1
SetControlDelay -1

VDA_PATH := A_ScriptDir . "\lib\VirtualDesktopAccessor.dll"
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", VDA_PATH, "Ptr")

GetDesktopCountProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GetDesktopCount", "Ptr")
GoToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GoToDesktopNumber", "Ptr")
GetCurrentDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GetCurrentDesktopNumber", "Ptr")
MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "MoveWindowToDesktopNumber", "Ptr")

GetDesktopCount() {
  global GetDesktopCountProc
  count := DllCall(GetDesktopCountProc, "Int")
  return count
}

MoveCurrentWindowToDesktop(number) {
  global MoveWindowToDesktopNumberProc, GoToDesktopNumberProc
  activeHwnd := WinGetID("A")
  DllCall(MoveWindowToDesktopNumberProc, "Ptr", activeHwnd, "Int", number, "Int")
}

GoToDesktopNumber(num) {
  if num - 1 > GetDesktopCount() {
    CreateNeededDesktops(num)
  }

  WinActivate "ahk_class Shell_TrayWnd"
  WinWaitActive "ahk_class Shell_TrayWnd"
  global GoToDesktopNumberProc
  DllCall(GoToDesktopNumberProc, "Int", num, "Int")
  WinMinimize "ahk_class Shell_TrayWnd"
  return
}

CreateNeededDesktops(num) {
  Loop GetDesktopCount() - num {
    ;CreateDesktop()
  }
}

LaunchTerminal() {
  Run "cmd"
}

#1::GoToDesktopNumber(0)
#2::GoToDesktopNumber(1)
#3::GoToDesktopNumber(2)
#4::GoToDesktopNumber(3)
#5::GoToDesktopNumber(4)
#6::GoToDesktopNumber(5)

#+1::MoveCurrentWindowToDesktop(0)
#+2::MoveCurrentWindowToDesktop(1)
#+3::MoveCurrentWindowToDesktop(2)
#+4::MoveCurrentWindowToDesktop(3)
#+5::MoveCurrentWindowToDesktop(4)
#+6::MoveCurrentWindowToDesktop(5)

#f::WinMaximize "A"

#Enter::LaunchTerminal()