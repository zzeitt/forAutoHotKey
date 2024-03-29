﻿;; ---------------------------------------------------------------------
; ██╗   ██╗██╗  ██╗██╗  ██╗
; ██║   ██║██║  ██║██║ ██╔╝
; ██║   ██║███████║█████╔╝ 
; ╚██╗ ██╔╝██╔══██║██╔═██╗ 
;  ╚████╔╝ ██║  ██║██║  ██╗
;   ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝
;; credit by @zeit
;; ---------------------------------------------------------------------

A_MenuMaskKey := "vkE8"  ; Change the masking key to something unassigned such as vkE8.
TraySetIcon "vim_style_arrows.ico"
FONT_MSYAHEI := "Microsoft YaHei UI"
SetTitleMatchMode("RegEx")

ztToolTip("Hello AHK!")

;; ====================================================================================
;  ██████╗ ██╗      ██████╗ ██████╗  █████╗ ██╗         ███╗   ███╗ █████╗ ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗ 
; ██╔════╝ ██║     ██╔═══██╗██╔══██╗██╔══██╗██║         ████╗ ████║██╔══██╗██╔══██╗██╔══██╗██║████╗  ██║██╔════╝ 
; ██║  ███╗██║     ██║   ██║██████╔╝███████║██║         ██╔████╔██║███████║██████╔╝██████╔╝██║██╔██╗ ██║██║  ███╗
; ██║   ██║██║     ██║   ██║██╔══██╗██╔══██║██║         ██║╚██╔╝██║██╔══██║██╔═══╝ ██╔═══╝ ██║██║╚██╗██║██║   ██║
; ╚██████╔╝███████╗╚██████╔╝██████╔╝██║  ██║███████╗    ██║ ╚═╝ ██║██║  ██║██║     ██║     ██║██║ ╚████║╚██████╔╝
;  ╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝     ╚═╝╚═╝  ╚═══╝ ╚═════╝ 
;; ====================================================================================
;; ----------------------------- Text Editing -----------------------------------------
!h::Send "{Left}"                           ; ALT + h            ->    Left                             (Cursor left one character)
!b::Send "^{Left}"                          ; ALT + b            ->    CTRL + Left                      (Cursor left per word)
!+h::Send "+{Left}"                         ; ALT + SHIFT + h    ->    SHIFT + Left                     (Select one character)
!+b::Send "+^{Left}"                        ; ALT + SHIFT + b    ->    SHIFT + CTRL + Left              (Select per word)

!l::Send "{Right}"                          ; ALT + l            ->    Right                            (Cursor right one character)
!w::Send "^{Right}"                         ; ALT + w            ->    CTRL + Right                     (Cursor right per word)
!+l::Send "+{Right}"                        ; ALT + SHIFT + l    ->    SHIFT + Right                    (Select one character)
!+w::Send "+^{Right}"                       ; ALT + SHIFT + W    ->    SHIFT + CTRL + Right             (Select per word)

!k::Send "{Up}"                             ; ALT + k            ->    Up                               (Cursor up line)
!+k::Send "+{Up}"                           ; ALT + SHIFT + k    ->    SHIFT + Up                       (Select one line)

!j::Send "{Down}"                           ; ALT + j            ->    Left                             (Cursor down line)
!+j::Send "+{Down}"                         ; ALT + SHIFT + j    ->    SHIFT + Left                     (Select one line)

!0::Send "{Home}"                           ; ALT + a            ->    Home                             (Cursor to beginning of line)
!+0::Send "+{Home}"                         ; ALT + SHIFT + a    ->    SHIFT + Home                     (Select to beginning of line)

!4::Send "{End}"                            ; ALT + f            ->    End                              (Cursor to end of line)
!+4::Send "+{End}"                          ; ALT + SHIFT + f    ->    SHIFT + End                      (Select to end of line)

!BackSpace::Send "{Del}"                    ; ALT + m            ->    DEL                              (Delete one character)
!+BackSpace::Send "^{BS}"                   ; ALT + SHIFT + BS   ->    CTRL + DELETE                    (Backspace one word)
^!BackSpace::Send "^{Right}^{BS}"           ; CTRL + ALT + BS    ->    CTRL+RIGHT+CTRL+LEFT+CTRL+DELETE (Delete one word)

!v::Send "{Home}+{End}"                     ; ALT + v            ->    END + SHIFT + HOME               (Select current line)
!a::Send "^{Right}^+{Left}"                 ; ALT + a            ->    CTRL+RIGHT+CTRL+SHIFT+LEFT       (Select current word)

;; ----------------------------- Common User Access  ----------------------------------
!y::Send "^c"                           ; ALT + y                   -> Copy
!p::Send "^v"                           ; ALT + p                   -> Paste
!+a::Send "^a"                          ; ALT + SHIFT + a           -> Select all
!z::Send "^z"                           ; ALT + z                   -> Undo
#HotIf !WinActive(emacs_title)
    !x::Send "^x"                       ; ALT + x                   -> Cut
    !+;::Send "^w"                      ; ALT + SHIFT + ;           -> CTRL + w                         (关闭页面)
#HotIf
#HotIf !WinActive(edge_title)
    !g::Send "^{Home}"                  ; ALT + G                   -> CTRL + HOME
    !+g::Send "^{End}"                  ; ALT + SHIFT + G           -> CTRL + END
#HotIf
#HotIf !WinActive(vscode_title)
    !=::Send "^{Tab}"                   ; ALT + =                   -> CTRL + TAB
    !-::Send "^+{Tab}"                  ; ALT + -                   -> CTRL + SHIFT + TAB
#HotIf

;; ----------------------------- App Switching ----------------------------------------
#w::Send "#5"                               ; WIN + w            ->    WIN + 5                          (Toggle Wechat "微信")
#y::Send "#6"                               ; WIN + y            ->    WIN + 6                          (Toggle "网易云")
#q::Send "^+{Esc}"                          ; WIN + q            ->    CTRL + SHIFT + ESC               (task manager)
!;::Send "{Esc}"                            ; ALT + ;            ->    Esc
!8::Send "{LAlt Down}{F4}{LAlt Up}"         ; Alt + 0            ->    Alt + F4

;; ----------------------------- Window Manipulation ----------------------------------
!^h::Send "{LWin Down}{Left}{LWin Up}"  ; ALT + CTRL + h            -> Home + Left
!^l::Send "{LWin Down}{Right}{LWin Up}" ; ALT + CTRL + l            -> Home + Right
!^k::Send "{LWin Down}{Up}{LWin Up}"    ; ALT + CTRL + k            -> Home + Up
!^j::Send "{LWin Down}{Down}{LWin Up}"  ; ALT + CTRL + j            -> Home + Down
#+h::Send "#+{Left}"                    ; WIN + SHIFT + h           -> WIN + SHIFT + Left
#+l::Send "#+{Right}"                   ; WIN + SHIFT + l           -> WIN + SHIFT + Right
#^h::Send "#^{Left}"                    ; WIN + CTRL + h            -> WIN + CTRL + Left
#^l::Send "#^{Right}"                   ; WIN + CTRL + l            -> WIN + CTRL + Right

;; ----------------------------- AutoHotKey  -----------------------------------------
^!r::{                                  ; CTRL + ALT + R            -> Reload AHK
    ztReload()
}

^!e::{                                  ; CTRL + ALT + E            -> Edit AHK
    ztEdit()
}

;; ----------------------------- 音量调节  -----------------------------------------
;; Borrowed from https://www.cnblogs.com/hyaray/p/7507476.html
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
        ztToolTip("静音  🔇")
    else
        ztToolTip("开启声音  🔉")
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

;; ----------------------------- 鼠标移动 ---------------------------------------------
;; Partially borrowed from https://github.com/4strid/mouse-control.autohotkey
mouse_mode := False
VELOCITY_X := 0
VELOCITY_Y := 0

moveCursor() {
    LEFT := 0
    DOWN := 0
    UP := 0
    RIGHT := 0
    
    h_pressed := GetKeyState("h", "P")
    j_pressed := GetKeyState("j", "P")
    k_pressed := GetKeyState("k", "P")
    l_pressed := GetKeyState("l", "P")
    LEFT := LEFT - h_pressed
    DOWN := DOWN + j_pressed
    UP := UP - k_pressed
    RIGHT := RIGHT + l_pressed
    if j_pressed {
        changeCursor("vim_mouse_j.cur")
    } else if k_pressed {
        changeCursor("vim_mouse_k.cur")
    } else {
        changeCursor("vim_mouse_idle.cur")
    }
    
    if (mouse_mode == False) {
        VELOCITY_X := 0
        VELOCITY_Y := 0
        SetTimer , 0
        restoreCursors()
    }
    accelerate(velocity, pos, neg, RESISTANCE:=0.982, FORCE:=1.8) {
        If (pos == 0 && neg == 0) {
            Return 0
        }
        ; smooth deceleration :)
        Else If (pos + neg == 0) {
            Return velocity * 0.666
        }
        ; physicszzzzz
        Else {
            Return velocity * RESISTANCE + FORCE * (pos + neg)
        }
    }
    
    global VELOCITY_X := accelerate(VELOCITY_X, LEFT, RIGHT)
    global VELOCITY_Y := accelerate(VELOCITY_Y, UP, DOWN)

    RestoreDPI:=DllCall("SetThreadDpiAwarenessContext","ptr",-3,"ptr") ; enable per-monitor DPI awareness

    MouseMove VELOCITY_X, VELOCITY_Y, 0, 'R'
}

changeCursor(file:="vim_mouse_j.cur") {
    cursor_handle := DllCall( "LoadCursorFromFile", "Str",file)
    arr_cursors := [32512,32513,32514,32515,32516,32640,32641,32642,32643,32644,32645,32646,32648,32649,32650,32651]
    for (cursor in arr_cursors) {
        DllCall( "SetSystemCursor", "UInt",cursor_handle, "Int",cursor)
    }
}

restoreCursors() {
	SPI_SETCURSORS := 0x57
	DllCall( "SystemParametersInfo", "UInt",SPI_SETCURSORS, "UInt",0, "UInt",0, "UInt",0 )
}

#HotIf mouse_mode
    h::
    j::
    k::
    l::
    {}
    o::Click
    a::Click "Right"
    ; MButton::changeCursor()
    ; MButton Up::restoreCursors()
#HotIf

#o::{
    global mouse_mode := !mouse_mode ; toggle mode
    if mouse_mode {
        SetTimer MoveCursor, 16
        ztToolTip("开启鼠标控制  🖱️")
        changeCursor("vim_mouse_idle.cur")
        ; MouseMove A_ScreenWidth/2, A_ScreenHeight/2
    } else {
        ztToolTip("关闭鼠标控制  💟")
        restoreCursors()
    }
}

;; ----------------------------- 切换双拼  -----------------------------------------
enable_double_pinyin := False
setPinyin(enable_double_pinyin) {
    RegWrite(
    enable_double_pinyin, "REG_DWORD", 
        "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS", 
        "Enable Double Pinyin")
    b_double_pinyin := RegRead(
        "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS", 
        "Enable Double Pinyin")
    if b_double_pinyin {
        ztToolTip("双拼  🍻")
    } else {
        ztToolTip("全拼  🍺")
    }
}

#p::{
    global enable_double_pinyin := !enable_double_pinyin
    setPinyin(enable_double_pinyin)
}
#+p::{
    global enable_double_pinyin := 1
    setPinyin(enable_double_pinyin)
}

;; ====================================================================================
; ███╗   ███╗██╗   ██╗    ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
; ████╗ ████║╚██╗ ██╔╝    ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
; ██╔████╔██║ ╚████╔╝     █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
; ██║╚██╔╝██║  ╚██╔╝      ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
; ██║ ╚═╝ ██║   ██║       ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
; ╚═╝     ╚═╝   ╚═╝       ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
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

ztDialog(
    arr_q, func_yes, title:="ztDialog", btn_font:=FONT_MSYAHEI, btn_font_size:=14,
    gui_args:="", show_args:="AutoSize Center") {
    func_cancel(*) {
        my_gui.Destroy()
    }

    my_gui := Gui(gui_args, title)
    my_gui.OnEvent("Escape", func_cancel)

    for (q in arr_q) {
        t := q[1]
        f_style := q[2][1]
        f_name := q[2][2]
        t_style := q[2][3]
        my_gui.SetFont(f_style, f_name)
        my_gui.Add("Text", t_style, t)
    }

    my_gui.SetFont("norm s" btn_font_size, btn_font)
    my_gui.Add("Button", "xs+83 w100 Center", "&Yes (y)").OnEvent("Click", func_yes)
    my_gui.Add("Button", "x+40 w100 Center", "&No (n)").OnEvent("Click", func_cancel)

    my_gui.Show(show_args)
}

ztEdit() {
    title := "ztEdit"
    font := FONT_MSYAHEI
    font_size := 16
    arr_q := [
        ["Sure to edit ",    ["s" font_size, font, "Center"]],
        [A_ScriptName,       ["bold italic s" font_size, font, "x+0 BackgroundSilver"]],
        [" ?",               ["norm s" font_size, font, "x+0"]],
    ]
    func_yes(*) {
        Edit
        if WinExist(title)
            WinClose(title)
    }
    ztDialog(arr_q, func_yes, title)
}

ztReload() {
    title := "ztReload"
    font := FONT_MSYAHEI
    font_size := 16
    arr_q := [
        ["Sure to reload ", ["s" font_size, font, "Center"]],
        [A_ScriptName,      ["bold italic s" font_size, font, "x+0 BackgroundSilver"]],
        [" ?",              ["norm s" font_size, font, "x+0"]]
    ]
    func_yes(*) {
        Reload
    }
    ztDialog(arr_q, func_yes, title)
}

;; --------------------------------------------------------------------------------
;; Borrowed from https://github.com/4strid/mouse-control.autohotkey
ztToolTip(
    msg, delay_ms:=600, font:=FONT_MSYAHEI, font_size:=16, title:="ztToolTip", owner:="",
    gui_args:="+AlwaysOnTop -Caption +ToolWindow", show_args:="AutoSize Center NoActivate") {
    if WinExist(title)
        WinClose(title)
    if (owner!="")
        gui_args := Format("{1:s} +Owner{2:s}", gui_args, owner)
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

ztShowMode(mode, win_title, hwnd_owner, margin_x:=340, margin_y:=150) {
    x := A_ScreenWidth - margin_x
    y := A_ScreenHeight - margin_y
    gui_args := "+ToolWindow"
    show_args := Format("AutoSize x{1:u} y{2:u} NoActivate", x, y)
    ztToolTip(mode,-1,"Consolas",12,win_title,hwnd_owner,gui_args,show_args)
}

ztToggleModeWin(win_title, func_showModeWin) {
    if WinExist(win_title)
        WinClose(win_title)
    else
        func_showModeWin()
}


;; ====================================================================================
; ███████╗██████╗  ██████╗ ███████╗
; ██╔════╝██╔══██╗██╔════╝ ██╔════╝
; █████╗  ██║  ██║██║  ███╗█████╗  
; ██╔══╝  ██║  ██║██║   ██║██╔══╝  
; ███████╗██████╔╝╚██████╔╝███████╗
; ╚══════╝╚═════╝  ╚═════╝ ╚══════╝
;; ====================================================================================
edge_title := "ahk_exe msedge.exe"
#HotIf WinActive(edge_title)
    !'::Send "^{F6}"    ; 回到页面聚焦
    >!d::Send "!+b"     ; 聚焦至收藏夹栏第一项
    !t::Send "^t"       ; 新建标签页
    !r:: Send "{F5}"    ; 刷新
#HotIf

;; ====================================================================================
; ███████╗ ██████╗ ████████╗███████╗██████╗  ██████╗ 
; ╚══███╔╝██╔═══██╗╚══██╔══╝██╔════╝██╔══██╗██╔═══██╗
;   ███╔╝ ██║   ██║   ██║   █████╗  ██████╔╝██║   ██║
;  ███╔╝  ██║   ██║   ██║   ██╔══╝  ██╔══██╗██║   ██║
; ███████╗╚██████╔╝   ██║   ███████╗██║  ██║╚██████╔╝
; ╚══════╝ ╚═════╝    ╚═╝   ╚══════╝╚═╝  ╚═╝ ╚═════╝ 
;; ====================================================================================
~#9:: {                                  ; WIN + 9                   -> run/min zotero
    if !WinExist(zotero_title) {
        Sleep 7000
        zoteroShowMode() ; first open zotero
    } else if !WinActive(zotero_title) {
        Sleep 600
        zoteroShowMode() ; reenter zotero
    }
}
zotero_title := "ahk_exe zotero.exe"
zotero_mode_insert := "Zotero: INSERT"
zotero_mode_normal := "Zotero: NORMAL"
zotero_mode := zotero_mode_normal
zotero_first_active := true ; actually doesn't work, reopen after close will lose mode_win
zotero_mode_win_title := "Zotero Mode"
zoteroShowMode() {
    hwnd := WinExist(zotero_title)
    ztShowMode(zotero_mode, zotero_mode_win_title, hwnd)
    WinActivate(zotero_title)
}
zoteroToggleModeWin() {
    ztToggleModeWin(zotero_mode_win_title, zoteroShowMode)
}
zoteroClose() {
    if WinExist(zotero_mode_win_title)
        WinClose(zotero_mode_win_title)
    if WinExist(zotero_title)
        WinClose(zotero_title)
}
#HotIf WinActive(zotero_title) and (zotero_mode == zotero_mode_normal)
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
    x::Send "^w"                                                            ; close tab


    !i:: {
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
    !8:: {
        zoteroClose()
    }
    !f::Send "^f"                                                           ; find
#HotIf WinActive(zotero_title) and (zotero_mode == zotero_mode_insert)
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
    !8:: {
        zoteroClose()
    }
    !f::Send "^f"                                                           ; find
#HotIf

;; ====================================================================================
; ███████╗██╗   ██╗███╗   ███╗████████╗██████╗  █████╗     ██████╗ ██████╗ ███████╗
; ██╔════╝██║   ██║████╗ ████║╚══██╔══╝██╔══██╗██╔══██╗    ██╔══██╗██╔══██╗██╔════╝
; ███████╗██║   ██║██╔████╔██║   ██║   ██████╔╝███████║    ██████╔╝██║  ██║█████╗  
; ╚════██║██║   ██║██║╚██╔╝██║   ██║   ██╔══██╗██╔══██║    ██╔═══╝ ██║  ██║██╔══╝  
; ███████║╚██████╔╝██║ ╚═╝ ██║   ██║   ██║  ██║██║  ██║    ██║     ██████╔╝██║     
; ╚══════╝ ╚═════╝ ╚═╝     ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝     ╚═════╝ ╚═╝     
;; ====================================================================================
#HotIf WinActive("ahk_exe SumatraPDF.exe")
    +k::
    +j::
    {
        switchTab(ThisHotKey)
    }
    d::Send "{Down 24}"                 ; scroll half-page down
    u::Send "{Up 24}"                   ; scroll half-page up
#HotIf

;; ====================================================================================
; ███████╗██╗  ██╗██████╗ ██╗      ██████╗ ██████╗ ███████╗██████╗ 
; ██╔════╝╚██╗██╔╝██╔══██╗██║     ██╔═══██╗██╔══██╗██╔════╝██╔══██╗
; █████╗   ╚███╔╝ ██████╔╝██║     ██║   ██║██████╔╝█████╗  ██████╔╝
; ██╔══╝   ██╔██╗ ██╔═══╝ ██║     ██║   ██║██╔══██╗██╔══╝  ██╔══██╗
; ███████╗██╔╝ ██╗██║     ███████╗╚██████╔╝██║  ██║███████╗██║  ██║
; ╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
;; ====================================================================================
explorer_title := "ahk_exe explorer.exe"
#HotIf WinActive(explorer_title)
    !e::Send "!d{Tab}{Tab}"                 ; 聚焦侧边栏
    !'::Send "!d{Tab}{Tab}^a{Up}{Down}"     ; 聚焦文件区域
    !t::Send "^t"                           ; 新建标签页
    !r::Send "{F5}"                         ; 刷新
    ![::Send "!{Left}"                      ; 后退
    !]::Send "!{Right}"                     ; 前进
    !+[::Send "!{Up}"                       ; 向上一级
    #HotIf WinActive(explorer_title) and WinExist("ahk_class #32768") ; 右键菜单栏模式
        j::Send "{Down}"
        k::Send "{Up}"
        h::Send "{Left}"
        l::Send "{Right}"
    #HotIf
#HotIf

;; ====================================================================================
; ███████╗███╗   ███╗ █████╗  ██████╗███████╗
; ██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝
; █████╗  ██╔████╔██║███████║██║     ███████╗
; ██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║
; ███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║
; ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝
;; ====================================================================================
emacs_name := "emacs.exe"
emacs_title := Format("ahk_exe {1:s}", emacs_name)
emacs_term_title := "emacs* ahk_class ConsoleWindowClass|CASCADIA_HOSTING_WINDOW_CLASS"
emacsHideTerminal() {
    title := "emacsHideTerminal"
    font := FONT_MSYAHEI
    font_size := 16
    arr_q := [
        ["Force hiding emacs terminal?",    ["s" font_size, font, "Center"]],
    ]
    func_yes(*) {
        if WinExist(emacs_term_title)
            WinHide(emacs_term_title)
            WinClose(title)
    }
    ztDialog(arr_q, func_yes, title)
}
~#2:: {
    if !WinExist(emacs_title) {
        if WinWait(emacs_term_title, , 2)
            WinHide
        else
            emacsHideTerminal()
    }
}

#HotIf WinActive(emacs_title)
    !x::Send "!x"
#HotIf

;; ====================================================================================
; ██╗   ██╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗
; ██║   ██║██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
; ██║   ██║███████╗██║     ██║   ██║██║  ██║█████╗  
; ╚██╗ ██╔╝╚════██║██║     ██║   ██║██║  ██║██╔══╝  
;  ╚████╔╝ ███████║╚██████╗╚██████╔╝██████╔╝███████╗
;   ╚═══╝  ╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
;; ====================================================================================
~#3:: {                                  ; WIN + 3                   -> run/min vscode
    if !WinExist(vscode_title) {
        Sleep 10000
        vscodeShowMode() ; first open vscode
    } else if !WinActive(vscode_title) {
        Sleep 600
        vscodeShowMode() ; reenter vscode
    }
}
vscode_name := "Code.exe"
vscode_title := Format("ahk_exe {1:s}", vscode_name)
vscode_mode_insert := "VSCode: INSERT"
vscode_mode_normal := "VSCode: NORMAL"
vscode_mode := vscode_mode_insert
vscode_mode_win_title := "VSCode Mode"
vscodeShowMode() {
    hwnd := WinExist(vscode_title)
    ztShowMode(vscode_mode, vscode_mode_win_title, hwnd)
    WinActivate(vscode_title)
}
vscodeToggleModeWin() {
    ztToggleModeWin(vscode_mode_win_title, vscodeShowMode)
}
vscodeClose() {
    if WinExist(vscode_mode_win_title)
        WinClose(vscode_mode_win_title)
    if WinExist(vscode_title)
        WinClose(vscode_title)
}
#HotIf WinActive(vscode_title) and (vscode_mode == vscode_mode_normal)
    k::Send "^{Up}"                                                         ; scroll up
    u::Send "{LCtrl Down}{Up 20}{LCtrl Up}"                                 ; scroll half-page up
    j::Send "^{Down}"                                                       ; scroll down
    d::Send "{LCtrl Down}{Down 20}{LCtrl Up}"                               ; scroll half-page down
    +j::Send "!-"                                                           ; previous tab
    +k::Send "!="                                                           ; next tab
    x::Send "^w"                                                            ; close tab
    t::Send "^n"                                                            ; new tab
    w::Send "^s"                                                            ; save
    o::Click                                                                ; click
    /::Send "^f"                                                            ; find
    g::Send "^{Home}"                                                       ; goto top
    +g::Send "^{End}"                                                       ; goto bottom
    ,::Send "{LCtrl Down}{LShift Down}{PgUp}{LCtrl Up}{LShift Up}"          ; move editor left
    .::Send "{LCtrl Down}{LShift Down}{PgDn}{LCtrl Up}{LShift Up}"          ; move editor right
    +,::Send "^!{Left}"                                                     ; move editor to previous group
    +.::Send "^!{Right}"                                                    ; move editor to next group
    !h::{
        MouseMove -5, 0, 100, "R"
    }                                                                       ; move mouse left
    !l::{
        MouseMove 5, 0, 100, "R"
    }                                                                       ; move mouse right
    !k::{
        MouseMove 0, -5, 100, "R"
    }                                                                       ; move mouse up
    !j::{
        MouseMove 0, 5, 100, "R"
    }                                                                       ; move mouse down

    !e::Send "^+e"                                                          ; goto file explorer panel
    ^!g::Send "^+g"                                                         ; goto git panel
    !o::Send "{End}{Enter}"                                                 ; new line below
    !+o::Send "{Home}{Enter}{Up}"                                           ; new line above
    !f::Send "^f"                                                           ; find
    !r::Send "^y"                                                           ; redo
    !d::Send "{Down 18}"                                                    ; half page down
    !u::Send "{Up 18}"                                                      ; half page up
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
    !8:: {
        vscodeClose()
    }
#HotIf WinActive(vscode_title) and (vscode_mode == vscode_mode_insert)
    !e::Send "^+e"                                                          ; goto file explorer panel
    ^!g::Send "^+g"                                                         ; goto git panel
    !o::Send "{End}{Enter}"                                                 ; new line below
    !+o::Send "{Home}{Enter}{Up}"                                           ; new line above
    !f::Send "^f"                                                           ; find
    !r::Send "^y"                                                           ; redo
    !d::Send "{Down 18}"                                                    ; half page down
    !u::Send "{Up 18}"                                                      ; half page up
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
    !8:: {
        vscodeClose()
    }
#HotIf

;; ====================================================================================
; ██╗    ██╗██████╗ ██╗  ██╗
; ██║    ██║██╔══██╗╚██╗██╔╝
; ██║ █╗ ██║██████╔╝ ╚███╔╝ 
; ██║███╗██║██╔═══╝  ██╔██╗ 
; ╚███╔███╔╝██║     ██╔╝ ██╗
;  ╚══╝╚══╝ ╚═╝     ╚═╝  ╚═╝
;; ====================================================================================
; excel & ppt
GroupAdd("WPX", "ahk_exe EXCEL.EXE")
GroupAdd("WPX", "ahk_exe POWERPNT.EXE")
#HotIf WinActive("ahk_group WPX")
    !s::Send "^s"
#HotIf