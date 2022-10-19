TraySetIcon "vim_style_arrows.ico"

!h::Send "{Left}"         ; ALT + h            ->    Left                 (Cursor left one character)
!b::Send "^{Left}"       ; ALT + b            ->    CTRL + Left          (Cursor left per word)
!+h::Send "+{Left}"      ; ALT + SHIFT + h    ->    SHIFT + Left         (Select one character)
!+b::Send "+^{Left}"     ; ALT + SHIFT + b    ->    SHIFT + CTRL + Left  (Select per word)

!l::Send "{Right}"       ; ALT + l            ->    Right                (Cursor right one character)
!w::Send "^{Right}"      ; ALT + w            ->    CTRL + Right         (Cursor right per word)
!+l::Send "+{Right}"      ; ALT + SHIFT + l    ->    SHIFT + Right        (Select one character)
!+w::Send "+^{Right}"     ; ALT + SHIFT + W    ->    SHIFT + CTRL + Right (Select per word)

!k::Send "{Up}"           ; ALT + k            ->    Up                   (Cursor up line)
!+k::Send "+{Up}"         ; ALT + SHIFT + k    ->    SHIFT + Up           (Select one line)

!j::Send "{Down}"         ; ALT + j            ->    Left                 (Cursor down line)
!+j::Send "+{Down}"       ; ALT + SHIFT + j    ->    SHIFT + Left         (Select one line)

!0::Send "{Home}"         ; ALT + a            ->    Home                 (Cursor to beginning of line)
!+0::Send "+{Home}"      ; ALT + SHIFT + a    ->    SHIFT + Home         (Select to beginning of line)

!4::Send "{End}"          ; ALT + f            ->    End                  (Cursor to end of line)
!+4::Send "+{End}"        ; ALT + SHIFT + f    ->    SHIFT + End          (Select to end of line)

!BackSpace::Send "{Del}"        ; ALT + m            ->    DEL                  (Delete one character)
!+BackSpace::Send "^{BS}"       ; ALT + SHIFT + BACKSPACE   ->  CTRL + DELETE   (Backspace one word)

;; --------------------------------------------------------------------------------------------------
;; Modified by @zeit
!^h::Send "{LWin Down}{Left}{LWin Up}"   ; ALT + CTRL + n            ->    Home + Left
!^l::Send "{LWin Down}{Right}{LWin Up}"  ; ALT + CTRL + m            ->    Home + Right
!^k::Send "{LWin Down}{Up}{LWin Up}"  ; ALT + CTRL + m            ->    Home + Up
!^j::Send "{LWin Down}{Down}{LWin Up}"  ; ALT +CTRL + m            ->    Home + Down
#+h::Send "#+{Left}"                    ; WIN + SHIFT + h        -> WIN + SHIFT + Left
#+l::Send "#+{Right}"                    ; WIN + SHIFT + l        -> WIN + SHIFT + Right
!y::Send "^c" ; ALT + y -> Copy
!p::Send "^v" ; ALT + p -> Paste
!x::Send "^x" ; ALT + x -> Cut
!z::Send "^z" ; ALT + z -> Undo
!;::Send "{Esc}" ; ALT + ;
!8::Send "{LAlt Down}{F4}{LAlt Up}" ; Alt + 0 -> Alt + F4
![::Send "+{Ins}" ; ALT + [ -> SHIFT + INSERT

;; --------------------------------------------------------------------------------------------------
;; 音量调节 (Copied from https://www.cnblogs.com/hyaray/p/7507476.html)
!F3::
{
    hyf_SoundSetWaveVolume("+", 5)
}

!F2::
{
    hyf_SoundSetWaveVolume("-", 5)
}

!F1::
{
    SoundSetMute -1
    mute_on_off := SoundGetMute()
    If mute_on_off
        hyf_tooltip("静音  ON", 1, A_ScreenWidth, A_ScreenHeight)
    Else
        hyf_tooltip("静音  OFF", 1, A_ScreenWidth, A_ScreenHeight)
}

hyf_SoundSetWaveVolume(mode, n)
{ ;mode为"+"或"-"
    Sound_Get := SoundGetVolume()

    If (mode = "+")
    {
        Sound_Now := Round(Sound_Get) + n
        If (Sound_Now > 100)
        {
            SoundSetVolume 100
            hyf_tooltip("音量+  100", 1, A_ScreenWidth, A_ScreenHeight)
            Return
        }
    }
    Else
    {
        Sound_Now := Round(Sound_Get) - n
        If (Sound_Now < 0)
        {
            SoundSetVolume 0
            hyf_tooltip("音量-  0", 1, A_ScreenWidth, A_ScreenHeight)
            Return
        }
    }
    SoundSetVolume Sound_Now
    hyf_tooltip("音量" . mode . "  " . Sound_Now, 1, A_ScreenWidth, A_ScreenHeight)
    Return
}

hyf_tooltip(str, t := 1, x := "", y := "")  ;提示t秒并自动消失
{
    t *= 1000
    ToolTip str, x, y
    SetTimer hyf_removeToolTip, -t
}

hyf_removeToolTip() ;清除ToolTip
{
    ToolTip
}

;; --------------------------------------------------------------------------------------------------
;; My Functions
is_input(t_sleep:=50) {
    Sleep t_sleep  ; give function time to get pos
    if CaretGetPos(&x, &y) {
        return true
    } else {
        return false
    }
}

is_caps_on() {
    if GetKeyState("CapsLock", "T")
        return true
    else
        return false
}

swich_tab(my_hotkey){
    if (InStr(my_hotkey, "+k")) {
        if !is_input()
            Send "^{Tab}"  ; next tab
        else
            SendInput "K"
    } else if (InStr(my_hotkey, "+j")) {
        if !is_input()
            Send "^+{Tab}"  ; previouse tab
        else
            SendInput "J"
    }
}

;; --------------------------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe msedge.exe")
!'::Send "{F10}"  ; Edge打开时的快捷键
#HotIf

;; --------------------------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe zotero.exe")
!e::Send "^+l"          ; focus library
+k::
+j::
{
    swich_tab(ThisHotKey)
}
+h::
+l::
{
    if InStr(ThisHotkey, "+h")
        if !is_input()
            Send "!{Left}"
        else
            SendInput "H"
    else if InStr(ThisHotKey, "+l")
        if !is_input()
            Send "!{Right}"
        else
            SendInput "L"
}
j::  ; scroll down
{
    if !is_input()
        Send "{Down}"
    else  ;; don't send original j/k to system, because j/k is hard-defined in zotero
        if is_caps_on()
            SendInput "J"
        else
            SendInput "j"
}
k::  ; scroll up
{
    if !is_input()
        Send "{Up}"
    else
        if is_caps_on()
            SendInput "K"
        else
            SendInput "k"
}
~h::  ; left
{
    if !is_input()
        Send "{Left}"
}
~l::  ; right
{
    if !is_input()
        Send "{Right}"
}
~u::  ; scroll half-page up
{
    if !is_input()
        Send "{Up 9}"
}
~d::  ; scroll half-page down
{
    if !is_input()
        Send "{Down 9}"
}
~/::  ; find
{
    if !is_input()
        Send "^f"
}
~x::  ; close
{
    if !is_input()
        Send "^w"
}
~a::  ; SHIFT + F10
{
    if !is_input()
        Send "+{F10}"
}
#HotIf

;; --------------------------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe SumatraPDF.exe")
+k::
+j::
{
    swich_tab(ThisHotKey)
}
!d::Send "{Down 9}"     ; scroll half-page down
!u::Send "{Up 9}"       ; scroll half-page up
!/::Send "^f"           ; find
#HotIf

;; --------------------------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe explorer.exe")
!e::
{
    Send "^e"
    Sleep 10
    Send "{Esc}"
}
!'::
{
    Send "^a{Up}{Down}"
}
!u::Send "!{Up}"
!r::Send "!{Right}"
#HotIf
