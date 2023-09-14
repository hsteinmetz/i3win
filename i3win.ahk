#SingleInstance

SetWorkingDir(A_ScriptDir)

VDA_PATH := A_ScriptDir . "\lib\VirtualDesktopAccessor.dll"
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", VDA_PATH, "Ptr")

GetDesktopCountProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GetDesktopCount", "Ptr")
GoToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GoToDesktopNumber", "Ptr")
GetCurrentDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "GetCurrentDesktopNumber", "Ptr")
MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "MoveWindowToDesktopNumber", "Ptr")
CreateDesktopProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "CreateDesktop", "Ptr")
RemoveDesktopProc := DllCall("GetProcAddress", "Ptr", hVirtualDesktopAccessor, "AStr", "RemoveDesktop", "Ptr")

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
  global GoToDesktopNumberProc
  DllCall(GoToDesktopNumberProc, "Int", num, "Int")
  return
}

CreateDesktop() {
  global CreateDesktopProc
  ran := DllCall(CreateDesktopProc, "Int")
  return ran
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