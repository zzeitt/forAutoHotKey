#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Menu, Tray, Icon, vim_style_arrows.ico,1,1

!h::Send {LEFT}         ; ALT + h            ->    LEFT                 (Cursor left one character)
!b::Send ^{LEFT}        ; ALT + b            ->    CTRL + LEFT          (Cursor left per word)
!+h::Send +{LEFT}       ; ALT + SHIFT + h    ->    SHIFT + LEFT         (Select one character)
!+b::Send +^{LEFT}      ; ALT + SHIFT + b    ->    SHIFT + CTRL + LEFT  (Select per word)

!l::Send {RIGHT}        ; ALT + l            ->    RIGHT                (Cursor right one character)
!w::Send ^{RIGHT}       ; ALT + w            ->    CTRL + RIGHT         (Cursor right per word)
!+l::Send +{RIGHT}      ; ALT + SHIFT + l    ->    SHIFT + RIGHT        (Select one character)
!+w::Send +^{RIGHT}     ; ALT + SHIFT + W    ->    SHIFT + CTRL + RIGHT (Select per word)

!k::Send {UP}           ; ALT + k            ->    UP                   (Cursor up line)
!+k::Send +{UP}         ; ALT + SHIFT + k    ->    SHIFT + UP           (Select one line)

!j::Send {DOWN}         ; ALT + j            ->    LEFT                 (Cursor down line)
!+j::Send +{DOWN}       ; ALT + SHIFT + j    ->    SHIFT + LEFT         (Select one line)

!0::Send {HOME}         ; ALT + a            ->    HOME                 (Cursor to beginning of line)
!+0::Send +{HOME}       ; ALT + SHIFT + a    ->    SHIFT + HOME         (Select to beginning of line)

!4::Send {END}          ; ALT + f            ->    END                  (Cursor to end of line)
!+4::Send +{END}        ; ALT + SHIFT + f    ->    SHIFT + END          (Select to end of line)

!BackSpace::Send {Del}          ; ALT + m            ->    DEL                  (Delete one character)

;; --------------------------------------------------------------------------------------------------
;; Modified by @zeit
!^h::Send {LWin Down}{LEFT}{LWin Up}   ; ALT + CTRL + n            ->    HOME + LEFT
!^l::Send {LWin Down}{RIGHT}{LWin Up}  ; ALT + CTRL + m            ->    HOME + RIGHT
!^k::Send {LWin Down}{UP}{LWin Up}  ; ALT + CTRL + m            ->    HOME + UP
!^j::Send {LWin Down}{DOWN}{LWin Up}  ; ALT +CTRL + m            ->    HOME + DOWN
!y::Send ^c ; ALT + y -> Copy
!p::Send ^v ; ALT + p -> Paste
!`;::Send {ESC} ; ALT + ;
!8::Send {LAlt Down}{F4}{LAlt Up} ; Alt + 0 -> Alt + F4

;; --------------------------------------------------------------------------------------------------
;; 音量调节 (Copied from https://www.cnblogs.com/hyaray/p/7507476.html)
!F3::   ;音量+1
!F2:: ;音量-1
Sound_Add := 1
If InStr(A_ThisHotkey, "F3")
    hyf_SoundSetWaveVolume("+", Sound_Add)
Else
    hyf_SoundSetWaveVolume("-", Sound_Add)
Return


hyf_SoundSetWaveVolume(mode, n)
{ ;mode为"+"或"-"
    SoundGet, Sound_Get, , , DeviceNumber
    Sound_Get := Round(Sound_Get)
    If (n = 5 && (numMod := Mod(Floor(Sound_Get), 5))) ;调整到5的倍数
        Sound_Get -= numMod
    If (mode = "+")
    {
        Sound_Now := Floor(Sound_Get) + n
        If (Sound_Now > 100)
        {
            hyf_tooltip("音量+  100", 1, 0, A_ScreenWidth, A_ScreenHeight)
            Return
        }
    }
    Else
    {
        Sound_Now := Floor(Sound_Get) - n
        If (Sound_Now < 0)
        {
            hyf_tooltip("音量-  0", 1, 0, A_ScreenWidth, A_ScreenHeight)
            Return
        }
    }
    SoundSet, Sound_Now, , , DeviceNumber
    hyf_tooltip("音量" . mode . "  " . Sound_Now, 1, 0, A_ScreenWidth, A_ScreenHeight)
    Return
}

hyf_tooltip(str, t := 1, ExitScript := 0, x := "", y := "")  ;提示t秒并自动消失   {{{3
{
    t *= 1000
    ToolTip, %str%, %x%, %y%
    SetTimer, hyf_removeToolTip, -%t%
    If ExitScript
    {
        Gui, Destroy
        Exit
    }
}

hyf_removeToolTip() ;清除ToolTip {{{3
{
    ToolTip
}

;; --------------------------------------------------------------------------------------------------
!6::Send {F6}   ; 模拟F6