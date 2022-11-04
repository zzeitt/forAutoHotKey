TraySetIcon "vim_style_arrows.ico"
FONT_MSYAHEI := "Microsoft YaHei UI"

ztToolTip("Hello AHK!")

;; ====================================================================================
;; Global mappings
;; ====================================================================================

!h::Send "{Left}"           ; ALT + h            ->    Left                 (Cursor left one character)
!b::Send "^{Left}"          ; ALT + b            ->    CTRL + Left          (Cursor left per word)
!+h::Send "+{Left}"         ; ALT + SHIFT + h    ->    SHIFT + Left         (Select one character)
!+b::Send "+^{Left}"        ; ALT + SHIFT + b    ->    SHIFT + CTRL + Left  (Select per word)

!l::Send "{Right}"          ; ALT + l            ->    Right                (Cursor right one character)
!w::Send "^{Right}"         ; ALT + w            ->    CTRL + Right         (Cursor right per word)
!+l::Send "+{Right}"        ; ALT + SHIFT + l    ->    SHIFT + Right        (Select one character)
!+w::Send "+^{Right}"       ; ALT + SHIFT + W    ->    SHIFT + CTRL + Right (Select per word)

!k::Send "{Up}"             ; ALT + k            ->    Up                   (Cursor up line)
!+k::Send "+{Up}"           ; ALT + SHIFT + k    ->    SHIFT + Up           (Select one line)

!j::Send "{Down}"           ; ALT + j            ->    Left                 (Cursor down line)
!+j::Send "+{Down}"         ; ALT + SHIFT + j    ->    SHIFT + Left         (Select one line)

!0::Send "{Home}"           ; ALT + a            ->    Home                 (Cursor to beginning of line)
!+0::Send "+{Home}"         ; ALT + SHIFT + a    ->    SHIFT + Home         (Select to beginning of line)

!4::Send "{End}"            ; ALT + f            ->    End                  (Cursor to end of line)
!+4::Send "+{End}"          ; ALT + SHIFT + f    ->    SHIFT + End          (Select to end of line)

!BackSpace::Send "{Del}"    ; ALT + m            ->    DEL                  (Delete one character)
!+BackSpace::Send "^{BS}"   ; ALT + SHIFT + BACKSPACE   ->  CTRL + DELETE   (Backspace one word)

;; --------------------------------------------------------------------------------------------------
;; Modified by @zeit
!^h::Send "{LWin Down}{Left}{LWin Up}"  ; ALT + CTRL + n            -> Home + Left
!^l::Send "{LWin Down}{Right}{LWin Up}" ; ALT + CTRL + m            -> Home + Right
!^k::Send "{LWin Down}{Up}{LWin Up}"    ; ALT + CTRL + m            -> Home + Up
!^j::Send "{LWin Down}{Down}{LWin Up}"  ; ALT + CTRL + m            -> Home + Down
#+h::Send "#+{Left}"                    ; WIN + SHIFT + h           -> WIN + SHIFT + Left
#+l::Send "#+{Right}"                   ; WIN + SHIFT + l           -> WIN + SHIFT + Right
!y::Send "^c"                           ; ALT + y                   -> Copy
!p::Send "^v"                           ; ALT + p                   -> Paste

#HotIf !WinActive("ahk_exe emacs.exe")
    !x::Send "^x"                           ; ALT + x                   -> Cut
#HotIf

!z::Send "^z"                           ; ALT + z                   -> Undo
!;::Send "{Esc}"                        ; ALT + ;                   -> Esc
!8::Send "{LAlt Down}{F4}{LAlt Up}"     ; Alt + 0                   -> Alt + F4
!/::Send "^f"                           ; ALT + /                   -> CTRL + F

#HotIf !WinActive("ahk_exe msedge.exe")
    !g::Send "^{Home}"                      ; ALT + G                   -> CTRL + HOME
    !+g::Send "^{End}"                      ; ALT + SHIFT + G           -> CTRL + END
#HotIf

#q::Send "^+{Esc}"                      ; WIN + BACKSPACE           -> CTRL + SHIFT + ESC (task manager)
^!r::{                                  ; Ctrl+Alt+R                -> Reload AHK
    ztReload()
}

;; ====================================================================================
;; My Functions
;; ====================================================================================
isInput(t_sleep:=50) {
    Sleep t_sleep  ; give function time to get pos
    if CaretGetPos(&x, &y) {
        return true
    } else {
        return false
    }
}

isCapsOn() {
    if GetKeyState("CapsLock", "T")
        return true
    else
        return false
}

switchTab(my_hotkey){
    if (InStr(my_hotkey, "+k")) {
        if !isInput()
            Send "^{Tab}"  ; next tab
        else
            SendInput "K"
    } else if (InStr(my_hotkey, "+j")) {
        if !isInput()
            Send "^+{Tab}"  ; previouse tab
        else
            SendInput "J"
    }
}

ztReload(font:=FONT_MSYAHEI) {
    my_gui := Gui()
    my_gui.OnEvent("Escape", func_cancel)

    my_gui.SetFont("s16", font)
    my_gui.Add("Text", "Center", "Sure to reload ")
    
    my_gui.SetFont("s16 bold italic", font)
    my_gui.Add("Text", "x+0 BackgroundSilver", A_ScriptName)

    my_gui.SetFont("s16 norm", font)
    my_gui.Add("Text", "x+0", " ?")

    my_gui.SetFont("s14", font)

    my_gui.Add("Button", "xs+83 w100 Center", "&Yes (y)").OnEvent("Click", func_reload)
    my_gui.Add("Button", "x+40 w100 Center", "&No (n)").OnEvent("Click", func_cancel)

    func_reload(*) {
        Reload
    }

    func_cancel(*) {
        my_gui.Destroy()
    }

    my_gui.Show("AutoSize Center")
    ; x := y := w := h := 19
    ; my_gui.GetClientPos(&x, &y, &w, &h)
    ; ToolTip(x . " " . y . " " . w . " " . h . " " . my_gui.MarginX)
}

;; --------------------------------------------------------------------------------
;; Borrowed from https://github.com/4strid/mouse-control.autohotkey
ztToolTip(
    msg, delay_ms:=600, font:=FONT_MSYAHEI, font_size:=16, title:="ztToolTip",
    gui_args:="+AlwaysOnTop -Caption +ToolWindow", show_args:="AutoSize Center NoActivate") {
    if WinExist(title)
        WinClose(title)
    my_gui := Gui(gui_args, title)
    ; https://lexikos.github.io/v2/docs/objects/Gui.htm#ExOSD
    my_gui.SetFont("s" . font_size, font)
    my_gui.Add("Text", "Center", msg)
    my_gui.Show(show_args)
    if (delay_ms > 0)
        SetTimer(ObjBindMethod(my_gui, "Destroy"), -delay_ms)
    return my_gui
}
;; --------------------------------------------------------------------------------

ztShowMode(mode, win_title) {
    x := A_ScreenWidth - 280
    y := A_ScreenHeight - 160
    gui_args := "+AlwaysOnTop +ToolWindow"
    show_args := Format("AutoSize x{1:u} y{2:u} NoActivate", x, y)
    ztToolTip(mode,-1,"Consolas",12,win_title,gui_args,show_args)
}

ztToggleModeWin(win_title, show_mode_win_func) {
    if WinExist(win_title)
        WinClose(win_title)
    else
        show_mode_win_func()
}

;; ====================================================================================
;; 音量调节 (Borrowed from https://www.cnblogs.com/hyaray/p/7507476.html)
;; ====================================================================================
!F3:: {
    hyf_SoundSetWaveVolume("+", 5)
}

!F2:: {
    hyf_SoundSetWaveVolume("-", 5)
}

!F1:: {
    SoundSetMute -1
    mute_on_off := SoundGetMute()
    if mute_on_off
        ztToolTip("静音  ON")
    else
        ztToolTip("静音  OFF")
}

hyf_SoundSetWaveVolume(mode, n) { ;mode为"+"或"-"
    Sound_Get := SoundGetVolume()

    if (mode = "+") {
        Sound_Now := Round(Sound_Get) + n
        if (Sound_Now > 100) {
            SoundSetVolume 100
            ztToolTip("音量 = 100")
            return
        }
    } else {
        Sound_Now := Round(Sound_Get) - n
        If (Sound_Now < 0) {
            SoundSetVolume 0
            ztToolTip("音量 = 0")
            return
        }
    }
    SoundSetVolume Sound_Now
    ztToolTip("音量 " . mode . " " . Sound_Now)
}

;; ====================================================================================
;; Edge
;; ====================================================================================
#HotIf WinActive("ahk_exe msedge.exe")
    !'::Send "{F10}"  ; Edge打开时的快捷键
#HotIf

;; ====================================================================================
;; Zotero
;; ====================================================================================
zotero_mode_insert := "Zotero: INSERT"
zotero_mode_normal := "Zotero: NORMAL"
zotero_mode := zotero_mode_normal
zotero_first_active := true
zotero_mode_win_title := "Zotero Mode"
zoteroShowMode() {
    ztShowMode(zotero_mode, zotero_mode_win_title)
    WinActivate("ahk_exe zotero.exe")
}
zoteroToggleModeWin() {
    if WinExist(zotero_mode_win_title)
        WinClose(zotero_mode_win_title)
    else
        zoteroShowMode()
}
#HotIf WinActive("ahk_exe zotero.exe") and (zotero_mode == zotero_mode_normal)
    if WinActive("ahk_exe zotero.exe") and zotero_first_active {
        zoteroShowMode()
        zotero_first_active := false
    }
    !e::Send "^+l"          ; focus library
    +k::
    +j::
    {
        switchTab(ThisHotKey)
    }
    +h::
    +l::
    {
        if InStr(ThisHotkey, "+h")
            if !isInput()
                Send "!{Left}"
            else
                SendInput "H"
        else if InStr(ThisHotKey, "+l")
            if !isInput()
                Send "!{Right}"
            else
                SendInput "L"
    }
    j:: {  ; scroll down
        if !isInput()
            Send "{Down}"
        else  ;; don't send original j/k to system, because j/k is hard-defined in zotero
            if isCapsOn()
                SendInput "J"
            else
                SendInput "j"
    }
    k:: { ; scroll up
        if !isInput()
            Send "{Up}"
        else
            if isCapsOn()
                SendInput "K"
            else
                SendInput "k"
    }
    ~h:: { ; left
        if !isInput()
            Send "{Left}"
    }
    ~l:: { ; right
        if !isInput()
            Send "{Right}"
    }
    ~u:: { ; scroll half-page up
        if !isInput()
            Send "{Up 9}"
    }
    ~d:: { ; scroll half-page down
        if !isInput()
            Send "{Down 9}"
    }
    ~/:: { ; find
        if !isInput()
            Send "^f"
    }
    ~a:: { ; SHIFT + F10
        if !isInput()
            Send "+{F10}"
    }
    !i:: {
        Click A_ScreenWidth//2, A_ScreenHeight//2
        global zotero_mode := zotero_mode_insert
        zoteroShowMode()
    }
    !n:: {
        global zotero_mode := zotero_mode_normal
        zoteroShowMode()
    }
    !q:: {
        zoteroToggleModeWin()
    }
#HotIf WinActive("ahk_exe zotero.exe") and (zotero_mode == zotero_mode_insert)
    !n:: {
        global zotero_mode := zotero_mode_normal
        zoteroShowMode()
    }
    !i:: {
        global zotero_mode := zotero_mode_insert
        zoteroShowMode()
    }
    !q:: {
        zoteroToggleModeWin()
    }
#HotIf

;; ====================================================================================
;; SumtraPDF
;; ====================================================================================
#HotIf WinActive("ahk_exe SumatraPDF.exe")
    +k::
    +j::
    {
        switchTab(ThisHotKey)
    }
    !d::Send "{Down 9}"                 ; scroll half-page down
    !u::Send "{Up 9}"                   ; scroll half-page up
#HotIf

;; ====================================================================================
;; Explorer
;; ====================================================================================
#HotIf WinActive("ahk_exe explorer.exe")
    !e:: {
        Send "^e"
        Sleep 10
        Send "{Esc}"
    }
    !':: {
        Send "^a{Up}{Down}"
    }
    !u::Send "!{Up}"
    !r::Send "!{Right}"
#HotIf

;; ====================================================================================
;; Emacs
;; ====================================================================================
#HotIf WinActive("ahk_exe emacs.exe")
    !x::Send "!x"
    ![::Send "+{Ins}"                   ; ALT + [                   -> SHIFT + INSERT
#HotIf

;; ====================================================================================
;; VSCode
;; ====================================================================================
vscode_mode_insert := "VSCode: INSERT"
vscode_mode_normal := "VSCode: NORMAL"
vscode_mode := vscode_mode_normal
vscode_first_active := true
vscode_mode_win_title := "VSCode Mode"
vscodeShowMode() {
    ztShowMode(vscode_mode, vscode_mode_win_title)
    WinActivate("ahk_exe Code.exe")
}
vscodeToggleModeWin() {
    ztToggleModeWin(vscode_mode_win_title, vscodeShowMode)
}
#HotIf WinActive("ahk_exe Code.exe") and (vscode_mode == vscode_mode_normal)
    if WinActive("ahk_exe Code.exe") and vscode_first_active {
        vscodeShowMode()
        vscode_first_active := false
    }
    k:: Send "^{Up}"                                    ; scroll up
    u:: Send "{LCtrl Down}{Up 20}{LCtrl Up}"            ; scroll half-page up
    j:: Send "^{Down}"                                  ; scroll down
    d:: Send "{LCtrl Down}{Down 20}{LCtrl Up}"          ; scroll half-page down
    +j:: Send "!["                                      ; previous tab
    +k:: Send "!]"                                      ; next tab
    x:: Send "^w"                                       ; close tab
    t:: Send "^t"                                       ; new tab
    w:: Send "^s"                                       ; save

    !e::Send "^+e"                                      ; goto file explorer panel
    !i:: {
        Click A_ScreenWidth//2, A_ScreenHeight//2
        global vscode_mode := vscode_mode_insert
        vscodeShowMode()
    }
    !n:: {
        global vscode_mode := vscode_mode_normal
        vscodeShowMode()
    }
    !q:: {
        vscodeToggleModeWin()
    }
#HotIf WinActive("ahk_exe Code.exe") and (vscode_mode == vscode_mode_insert)
    !e::Send "^+e"                                      ; goto file explorer panel
    !i:: {
        global vscode_mode := vscode_mode_insert
        vscodeShowMode()
    }
    !n:: {
        global vscode_mode := vscode_mode_normal
        vscodeShowMode()
    }
    !q:: {
        vscodeToggleModeWin()
    }
#HotIf
