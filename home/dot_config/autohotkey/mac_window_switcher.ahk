#Requires AutoHotkey v2.0
#SingleInstance Force

; ============================================================
; macOS-style application window switching
;
; Alt + `        = next window of current application
; Alt + Shift + ` = previous window of current application
; ============================================================

global MRU := Map()

; Track the active window whenever it changes.
SetTimer TrackActiveWindow, 100

!`::SwitchAppWindow(1)
!+`::SwitchAppWindow(-1)


TrackActiveWindow() {
    static lastWindow := 0

    hwnd := WinExist("A")

    if !hwnd || hwnd = lastWindow
        return

    lastWindow := hwnd

    try {
        process := WinGetProcessName("ahk_id " hwnd)

        if !MRU.Has(process)
            MRU[process] := []

        list := MRU[process]

        ; Remove this window if it already exists.
        for index, existing in list {
            if existing = hwnd {
                list.RemoveAt(index)
                break
            }
        }

        ; Put the newest window at the front.
        list.InsertAt(1, hwnd)

        ; Keep a reasonable number of windows.
        while list.Length > 20
            list.Pop()
    }
}


SwitchAppWindow(direction) {
    current := WinExist("A")

    if !current
        return

    try {
        process := WinGetProcessName("ahk_id " current)
    } catch {
        return
    }

    if !MRU.Has(process)
        return

    list := MRU[process]

    ; Clean up windows that no longer exist.
    cleaned := []

    for hwnd in list {
        if WinExist("ahk_id " hwnd)
            cleaned.Push(hwnd)
    }

    MRU[process] := cleaned
    list := cleaned

    if list.Length < 2
        return

    ; Find the current window.
    currentIndex := 0

    for index, hwnd in list {
        if hwnd = current {
            currentIndex := index
            break
        }
    }

    if !currentIndex
        return

    ; MRU order:
    ;
    ; [current, previous, older, ...]
    ;
    ; Forward:
    ;   current → previous → older → ...
    ;
    ; Backward:
    ;   current → oldest → ... → previous
    ;
    if direction = 1 {
        newIndex := currentIndex + 1

        if newIndex > list.Length
            newIndex := 1
    } else {
        newIndex := currentIndex - 1

        if newIndex < 1
            newIndex := list.Length
    }

    target := list[newIndex]

    if WinExist("ahk_id " target)
        WinActivate("ahk_id " target)
}
