;-------------------------------------------------------------------------------
; AutoHotkey v2 config for my frequent Mac shortcuts on Windows
;   - Use normal Windows keyboard (Ctrl, Windows key, Alt)
;-------------------------------------------------------------------------------

#Requires AutoHotkey v2.0
#SingleInstance Force

SendMode "Input"
SetTitleMatchMode 2

;-------------------------------------------------------------------------------
; Caps Lock -> Escape
;-------------------------------------------------------------------------------

CapsLock::Esc

;-------------------------------------------------------------------------------
; Mac-style shortcuts
;-------------------------------------------------------------------------------

; New window
!n::Send "^n"

; New tab
!t::Send "^t"

; Refresh
!r::Send "^r"

; Close tab
!w::Send "^w"

; Copy
!c::Send "^c"

; Cut
!x::Send "^x"

; Paste
!v::Send "^v"

; Undo
!z::Send "^z"

; Find
!f::Send "^f"

; Select all
!a::Send "^a"

;-------------------------------------------------------------------------------
; Chrome-specific shortcuts
;-------------------------------------------------------------------------------

#HotIf WinActive("ahk_exe chrome.exe")

; Go to address bar
!l::Send "^l"

#HotIf

;-------------------------------------------------------------------------------
; Navigation
;-------------------------------------------------------------------------------

; Back
![::Send "{Browser_Back}"

; Forward
!]::Send "{Browser_Forward}"

; Previous tab
!+[::Send "^+{Tab}"

; Next tab
!+]::Send "^{Tab}"
