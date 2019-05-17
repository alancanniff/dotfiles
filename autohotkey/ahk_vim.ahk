Capslock::
    send, {Esc}
return


LCtrl & RCtrl::
    GetKeyState, keystate, CapsLock, T
    if (keystate = "D")
        SetCapsLockState, Off
    else
        SetCapsLockState, On
    return
return


; hack to emulate the \ on uk keyboards
; modified from scrip to map caps lock to ctrl and shift ; Author: fwompner gmail com
; LShift is LShift when pressed with another key
; is / when pressed alone
; #InstallKeybdHook
; LShift::
;     Send {LShift Down}
;     ; wait until the key is pressed or released
;     KeyWait, LShift
;     Send {LShift Up}
;     ; A_PriorKey returns the name of the last key pressed
;     if ( A_PriorKey = "LShift" )
;     {
;         Send, \
;     }
; return

