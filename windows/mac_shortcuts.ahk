;-------------------------------------------------------------------------------
; AutoHotKey config for my frequent Mac shortcuts on Windows
;   -Use normal windows keyboard (Ctrl, Windows key, Alt)
;   -To install on Windows from WSL2:
;       ln -s ~/.dotfiles/winodws/mac_shortcuts.ahk
;           /mnt/c/Users/<Your User>/AppData/Roaming/Microsoft/Windows/
;           Start\ Menu/Programs/Startup/mac_shortcuts.ahk
;-------------------------------------------------------------------------------

#MenuMaskKey vkE8  ; Change the masking key to something unassigned such as vkE8.
SendMode Input

SetTitleMatchMode,2
;#IfWinActive,VIM
#IfWinActive
    CAPSLOCK::ESC
    ;ESC::CAPSLOCK
return

;New window
!n::
Send ^n
return

;New tab
!t::
Send ^t
return

;Refresh
!r::
Send ^r
return

;Close tab
!w::
Send ^w
return

;Copy
!c::
Send ^c
return

;Cut
!x::
Send ^x
return

;Paste
!v::
Send ^v
return

;Undo
!z::
Send ^z
return

;Find
!f::
Send ^f
return

;Goto Address Bar
!l::
Send ^l
return

;Back
;![::!Left
![::
Send {Browser_Back}
return

;Forward
;!]::!Right
!]::
Send {Browser_Forward}
return

;Previous Tab
;!+[:: send, ^+{Tab down}{Tab up}
!+[::
Send ^+{Tab}
return

;Next Tab
;!+]:: send, ^{Tab down}{Tab up}
!+]::
Send ^{Tab}
return

