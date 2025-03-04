;; ====================================================================================
;
; ██╗   ██╗██╗  ██╗██╗  ██╗
; ██║   ██║██║  ██║██║ ██╔╝
; ██║   ██║███████║█████╔╝ 
; ╚██╗ ██╔╝██╔══██║██╔═██╗ 
;  ╚████╔╝ ██║  ██║██║  ██╗
;   ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝
;
;; Author:       zeit
;; Version:      1.0.0
;; Description:  Use vim-like key bindings in Windows environment.
;; Changelog:
;;   2024.09.10: Initialzied version number.
;; ====================================================================================
#Requires AutoHotkey v2.0+
A_MenuMaskKey := "vkE8"  ; Change the masking key to something unassigned such as vkE8.
PATH_ASSETS := "assets/"
TraySetIcon(PATH_ASSETS . "vhk.ico")
FONT_MSYAHEI := "Microsoft YaHei UI"
PATH_MOUSE_J := PATH_ASSETS . "mouse_j.cur"
PATH_MOUSE_K := PATH_ASSETS . "mouse_k.cur"
PATH_MOUSE_IDLE := PATH_ASSETS . "mouse_idle.cur"

SetTitleMatchMode("RegEx")

ztToolTip("Hello VHK!")

;; ====================================================================================
;  ██████╗ ██╗      ██████╗ ██████╗  █████╗ ██╗         ███╗   ███╗ █████╗ ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗ 
; ██╔════╝ ██║     ██╔═══██╗██╔══██╗██╔══██╗██║         ████╗ ████║██╔══██╗██╔══██╗██╔══██╗██║████╗  ██║██╔════╝ 
; ██║  ███╗██║     ██║   ██║██████╔╝███████║██║         ██╔████╔██║███████║██████╔╝██████╔╝██║██╔██╗ ██║██║  ███╗
; ██║   ██║██║     ██║   ██║██╔══██╗██╔══██║██║         ██║╚██╔╝██║██╔══██║██╔═══╝ ██╔═══╝ ██║██║╚██╗██║██║   ██║
; ╚██████╔╝███████╗╚██████╔╝██████╔╝██║  ██║███████╗    ██║ ╚═╝ ██║██║  ██║██║     ██║     ██║██║ ╚████║╚██████╔╝
;  ╚═════╝ ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝     ╚═╝╚═╝  ╚═══╝ ╚═════╝ 
;; ====================================================================================
; global
;; ----------------------------- Text Editing -----------------------------------------
!h::Send "{Left}"                           ; ALT + h            ->    Left                             (Cursor left one character)
!+h::Send "+{Left}"                         ; ALT + SHIFT + h    ->    SHIFT + Left                     (Select one character)
!l::Send "{Right}"                          ; ALT + l            ->    Right                            (Cursor right one character)
!+l::Send "+{Right}"                        ; ALT + SHIFT + l    ->    SHIFT + Right                    (Select one character)

!k::Send "{Up}"                             ; ALT + k            ->    Up                               (Cursor up line)
!+k::Send "+{Up}"                           ; ALT + SHIFT + k    ->    SHIFT + Up                       (Select one line)

!j::Send "{Down}"                           ; ALT + j            ->    Down                             (Cursor down line)
!+j::Send "+{Down}"                         ; ALT + SHIFT + j    ->    SHIFT + Left                     (Select one line)

!b::Send "^{Left}"                          ; ALT + b            ->    CTRL + Left                      (Cursor left per word)
!+b::Send "+^{Left}"                        ; ALT + SHIFT + b    ->    SHIFT + CTRL + Left              (Select per word)

!w::Send "^{Right}"                         ; ALT + w            ->    CTRL + Right                     (Cursor right per word)
!+w::Send "+^{Right}"                       ; ALT + SHIFT + W    ->    SHIFT + CTRL + Right             (Select per word)

!0::Send "{Home}"                           ; ALT + 0            ->    Home                             (Cursor to beginning of line)
!+0::Send "+{Home}"                         ; ALT + SHIFT + 0    ->    SHIFT + Home                     (Select to beginning of line)

!4::Send "{End}"                            ; ALT + 4            ->    End                              (Cursor to end of line)
!+4::Send "+{End}"                          ; ALT + SHIFT + 4    ->    SHIFT + End                      (Select to end of line)

!BackSpace::Send "{Del}"                    ; ALT + m            ->    DEL                              (Delete one character)
!+BackSpace::Send "^{BS}"                   ; ALT + SHIFT + BS   ->    CTRL + DELETE                    (Backspace one word)
^!BackSpace::Send "^{Right}^{BS}"           ; CTRL + ALT + BS    ->    CTRL+RIGHT+CTRL+LEFT+CTRL+DELETE (Delete one word)

!v::Send "{Home}+{End}"                     ; ALT + v            ->    END + SHIFT + HOME               (Select current line)
!a::Send "^{Right}^+{Left}"                 ; ALT + a            ->    CTRL+RIGHT+CTRL+SHIFT+LEFT       (Select current word)

;; Space -> Alt
; Space::Send "{Space}"
#Hotif !isEditCursor() and WinActive("ahk_group BROWSER")
    ~Space & h::Send "{Left}"
    ~Space & l::Send "{Right}"
    ~Space & k::Send "{Up}"
    ~Space & j::Send "{Down}"
    ~Space & =::Send "^{Tab}"
    ~Space & -::Send "^+{Tab}"
    #HotIf !isEditCursor() and WinActive("ahk_group BROWSER") and GetKeyState("Shift", "P")
        ~Space & h::Send "+{Left}"
        ~Space & l::Send "+{Right}"
        ~Space & k::Send "+{Up}"
        ~Space & j::Send "+{Down}"
        ~Space & u::Send "!+u"
        ~Space & d::Send "!+d"
    #HotIf
#HotIf

;; ----------------------------- Common User Access  ----------------------------------
!y::Send "^c"                           ; ALT + y                   -> Copy
!p::Send "^v"                           ; ALT + p                   -> Paste
!+a::Send "^a"                          ; ALT + SHIFT + a           -> Select all
!z::Send "^z"                           ; ALT + z                   -> Undo
#HotIf !WinActive(emacs_title) and !WinActive(winterm_title) and !WinActive(etx_title)
    !x::Send "^x"                       ; ALT + x                   -> Cut
    !+;::Send "^w"                      ; ALT + SHIFT + ;           -> CTRL + w                         (关闭页面)
#HotIf
#HotIf !WinActive("ahk_group BROWSER")
    !g::Send "^{Home}"                  ; ALT + G                   -> CTRL + HOME
    !+g::Send "^{End}"                  ; ALT + SHIFT + G           -> CTRL + END
#HotIf
#HotIf !WinActive(vscode_title)
    !=::Send "^{Tab}"                   ; ALT + =                   -> CTRL + TAB
    !-::Send "^+{Tab}"                  ; ALT + -                   -> CTRL + SHIFT + TAB
#HotIf

;; ----------------------------- App Switching ----------------------------------------
#y::Send "#6"                               ; WIN + y            ->    WIN + 6                          (Toggle "网易云")
#q::Send "^+{Esc}"                          ; WIN + q            ->    CTRL + SHIFT + ESC               (task manager)
!;::Send "{Esc}"                            ; ALT + ;            ->    Esc
!8::Send "{LAlt Down}{F4}{LAlt Up}"         ; Alt + 0            ->    Alt + F4

;; ----------------------------- Window Manipulation ----------------------------------
!^h::Send "{LWin Down}{Left}{LWin Up}"  ; ALT + CTRL + h            -> Home + Left
!^l::Send "{LWin Down}{Right}{LWin Up}" ; ALT + CTRL + l            -> Home + Right
!^k::WinMaximize "A"                    ; ALT + CTRL + k            -> Home + Up
!^j::Send "{LWin Down}{Down}{LWin Up}"  ; ALT + CTRL + j            -> Home + Down
#+,::Send "#+{Left}"                    ; WIN + SHIFT + h           -> WIN + SHIFT + Left
#+.::Send "#+{Right}"                   ; WIN + SHIFT + l           -> WIN + SHIFT + Right
#[::Send "#z"                           ; WIN + [                   -> WIN + z
#+-::{
    ztResizeCurrentWindow(-0.05)        ; Shrink the window
}
#+=::{
    ztResizeCurrentWindow(+0.05)        ; Enlarge the window
}
#+k::{
    ztMoveCurrentWindow(0,-15)          ; Move up the window
}
#+j::{
    ztMoveCurrentWindow(0,15)           ; Move down the window
}
#+h::{
    ztMoveCurrentWindow(-15,0)          ; Move up the window
}
#+l::{
    ztMoveCurrentWindow(15,0)           ; Move down the window
}

;; ----------------------------- AutoHotKey  -----------------------------------------
^!r::{                                  ; CTRL + ALT + R            -> Reload AHK
    ztReload()
}

^!e::{                                  ; CTRL + ALT + E            -> Edit AHK
    ztEdit()
}

;; ----------------------------- 音量调节  -----------------------------------------
;; *********************************************************
;; @warning Will be deprecated soon.
;; Borrowed from https://www.cnblogs.com/hyaray/p/7507476.html
!F3:: {
    hyf_SoundSetWaveVolume("+", 5)
}

!F2:: {
    hyf_SoundSetWaveVolume("-", 5)
}
!+F3:: {
    hyf_SoundSetWaveVolume("+", 1)
}

!+F2:: {
    hyf_SoundSetWaveVolume("-", 1)
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
;; *********************************************************

#HotIf !WinActive(explorer_title) and !WinActive("ahk_group WPX") and !WinActive("ahk_group BROWSER")
~F3:: {
    Send "{Volume_Up}"
    ztToolTip(Format("{:d}%", SoundGetVolume()))
}
~F2:: {
    Send "{Volume_Down}"
    ztToolTip(Format("{:d}%", SoundGetVolume()))
}
#HotIf

!F1:: {
    SoundSetMute -1
    mute_on_off := SoundGetMute()
    if mute_on_off
        ztToolTip("静音  🔇")
    else
        ztToolTip("开启声音  🔉")
}

;; Adapted from https://www.autohotkey.com/docs/v2/lib/_HotIf.htm#ExVolume
GroupAdd("TaskBar", "ahk_class Shell_SecondaryTrayWnd")
GroupAdd("TaskBar", "ahk_class Shell_TrayWnd")
#HotIf isMouseOver("ahk_group TaskBar")
    WheelUp::{
        Send "{Volume_Up}"
        ztToolTip(Format("{:d}%", SoundGetVolume()))
    }
    WheelDown::{
        Send "{Volume_Down}"
        ztToolTip(Format("{:d}%", SoundGetVolume()))
    }
    ;; LButton:: {
    ;;     ;; Adapted from https://stackoverflow.com/a/20551554/8561448
    ;;     if(A_PriorHotkey = A_ThisHotkey && A_TimeSincePriorHotkey < 500) {
    ;;         Send "{Media_Next}"
    ;;         ztToolTip("下一首")
    ;;     } else {
    ;;         Send "{Media_Play_Pause}"
    ;;         ztToolTip("暂停/继续")
    ;;     }
    ;; }
    ;; RButton::{
    ;;     Send "{Media_Prev}"
    ;;     ztToolTip("下一首")
    ;; }
#HotIf


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
        changeCursor(PATH_MOUSE_J)
    } else if k_pressed {
        changeCursor(PATH_MOUSE_K)
    } else {
        changeCursor(PATH_MOUSE_IDLE)
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

changeCursor(file:=PATH_MOUSE_IDLE) {
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

enterMouseMode() {
    ztToolTip("开启鼠标控制  🖱️")
    changeCursor()
}

quitMouseMode() {
    ztToolTip("关闭鼠标控制  💟")
    restoreCursors()
}

#HotIf mouse_mode
    h::
    j::
    k::
    l::
    {}
    o::Click
    a::Click "Right"
    q::{
        global mouse_mode := False ; quit
        quitMouseMode()
    }

    ; MButton::changeCursor()
    ; MButton Up::restoreCursors()
#HotIf

#o::{
    global mouse_mode := !mouse_mode ; toggle mode
    if mouse_mode {
        SetTimer MoveCursor, 16
        enterMouseMode()
        ; MouseMove A_ScreenWidth/2, A_ScreenHeight/2
    } else {
        quitMouseMode()
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

;; ---------------------------- 旋转屏幕 -------------------------------------------
#^r::ChangeScreenOrientation("Clockwise", 3)

ChangeScreenOrientation(Orientation:='Landscape', MonNumber:=3) {
    static DMDO_DEFAULT := 0, DMDO_90 := 1, DMDO_180 := 2, DMDO_270 := 3, dmSize := 220
    NumPut('Short', dmSize, DEVMODE := Buffer(dmSize, 0), 68)
    display := '\\.\DISPLAY' MonNumber
    DllCall('EnumDisplaySettings', 'Str', display, 'Int', -1, 'Ptr', DEVMODE)
    n0 := NumGet(DEVMODE, 172, 'UInt')
    n1 := NumGet(DEVMODE, 176, 'UInt')
    b := n0 < n1
    dimension1 := n% b% | n%!b% << 32
    dimension2 := n%!b% | n% b% << 32
    currentOrientation := NumGet(DEVMODE, 84, 'Int')
    switch Orientation, false {
        case 'Clockwise':
            Orientation := (--currentOrientation) < DMDO_DEFAULT ? DMDO_270 : currentOrientation
            i := (Orientation&1) + 1
        case 'CClockwise', 'CounterClockwise':
            Orientation := (++currentOrientation) > DMDO_270 ? DMDO_DEFAULT : currentOrientation
            i := (Orientation&1) + 1
        case 'Landscape'          ,   0: i := 1, orientation := DMDO_DEFAULT
        case 'Portrait'           ,  90: i := 2, orientation := DMDO_90
        case 'Landscape (flipped)', 180: i := 1, orientation := DMDO_180
        case 'Portrait (flipped)' , 270: i := 2, orientation := DMDO_270
        default:                         i := 1, orientation := DMDO_DEFAULT
    }
    NumPut('Int'  , orientation , DEVMODE,  84)
    NumPut('Int64', dimension%i%, DEVMODE, 172)
    DllCall('ChangeDisplaySettingsEx', 'Str', display, 'Ptr', DEVMODE, 'Ptr', 0, 'Int', 0, 'Int', 0)
}

;; ------------------------------ 媒体播放 -------------------------------------------
!3::{
    Send "{Media_Next}"
    ztToolTip("下一首")
}
!2::{
    Send "{Media_Prev}"
    ztToolTip("上一首")
}
!1::{
Send "{Media_Play_Pause}"
    ztToolTip("暂停/继续")
}

;; ------------------------------ 打开输入法设置 -------------------------------------------
#^i::{
  Run "ms-settings:regionlanguage-chsime-pinyin-udp"
  Sleep 400
  Send "{Tab 3}"
}

;; ====================================================================================
; ███╗   ███╗██╗   ██╗    ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
; ████╗ ████║╚██╗ ██╔╝    ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
; ██╔████╔██║ ╚████╔╝     █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
; ██║╚██╔╝██║  ╚██╔╝      ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
; ██║ ╚═╝ ██║   ██║       ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
; ╚═╝     ╚═╝   ╚═╝       ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
;; ====================================================================================
; functions
isInput(t_sleep:=50) {
    Sleep t_sleep  ; give function time to get pos
    if CaretGetPos(&x, &y) {
        return true
    } else {
        return false
    }
}

isEditCursor() {
    if (A_Cursor == "IBeam")
        return true
    else
        return false
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

isMouseOver(WinTitle) {
    MouseGetPos ,, &Win
    return WinExist(WinTitle " ahk_id " Win)
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

;; --------------------------------------------------------------------------------
;; Borrowed from https://zhuanlan.zhihu.com/p/425951648
ztSwitchIME(lang:="en") {
    if (lang == "en") {
        lang_id := 0
        lang_msg := "English Input"
    } else if (lang == "ch") {
        lang_id := 1025
        lang_msg := "中文输入"
    }

    DetectHiddenWindows True
    hWnd := WinGetID("A")
    tmp := SendMessage(
        0x283,                  ; WM_IME_CONTROL
        0x002,                  ; IMC_SETCONVERSIONMODE
        lang_id,                ; 0->english, 1025->中文
        ,                       ; Control
        "ahk_id " DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hWnd, "Uint"))
    ztToolTip(lang_msg)
}
;; --------------------------------------------------------------------------------
ztResizeCurrentWindow(zoom) {
    if (zoom < 1.0) {
        id := WinExist("A")
        WinGetPos(&x, &y, &w, &h, id)
        WinMove(,,(1+zoom)*w, (1+zoom)*h)
    }
}

ztMoveCurrentWindow(dx, dy) {
    id := WinExist("A")
    WinGetPos(&x, &y, &w, &h, id)
    WinMove(x+dx,y+dy,,,id)
}

;; ====================================================================================
; ███████╗██████╗  ██████╗ ███████╗       ██╗       ███████╗██╗██████╗ ███████╗███████╗ ██████╗ ██╗  ██╗
; ██╔════╝██╔══██╗██╔════╝ ██╔════╝       ██║       ██╔════╝██║██╔══██╗██╔════╝██╔════╝██╔═══██╗╚██╗██╔╝
; █████╗  ██║  ██║██║  ███╗█████╗      ████████╗    █████╗  ██║██████╔╝█████╗  █████╗  ██║   ██║ ╚███╔╝ 
; ██╔══╝  ██║  ██║██║   ██║██╔══╝      ██╔═██╔═╝    ██╔══╝  ██║██╔══██╗██╔══╝  ██╔══╝  ██║   ██║ ██╔██╗ 
; ███████╗██████╔╝╚██████╔╝███████╗    ██████║      ██║     ██║██║  ██║███████╗██║     ╚██████╔╝██╔╝ ██╗
; ╚══════╝╚═════╝  ╚═════╝ ╚══════╝    ╚═════╝      ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═╝      ╚═════╝ ╚═╝  ╚═╝
;; ====================================================================================
; edge & firefox, i.e. BROWSER
edge_title := "ahk_exe msedge.exe"
firefox_title := "ahk_exe firefox.exe"
GroupAdd("BROWSER", edge_title)
GroupAdd("BROWSER", firefox_title)
#HotIf WinActive("ahk_group BROWSER")
    !'::Send "^{F6}{Esc}"    ; 回到页面聚焦
    >!d::Send "!+b"          ; 聚焦至收藏夹栏第一项
    !t::Send "^t"            ; 新建标签页
    !r::Send "{F5}"          ; 刷新
    ![::Send "!{Left}"       ; 后退
    !]::Send "!{Right}"      ; 前进
    !+-::Send "^+{PgUp}"     ; 左移标签
    !+=::Send "^+{PgDn}"     ; 右移标签
    !+y::Send "^+y"          ; 打开集锦
    !s::Send "^+d"           ; 收藏
    !+'::Send "{F12}"        ; 开发者模式
    !+i::{                   ; Quickey搜索bookmark
        Send "!i"
        Sleep 400
        ztSwitchIME("en")
        Send "/b "
    }
    F3:: Send "{Volume_Up}"
    F2:: Send "{Volume_Down}"
    #HotIf WinActive("ahk_group BROWSER") and !isEditCursor()
        ~Space & '::Send "^{F6}{Esc}"    ; 回到页面聚焦
        ~Space & t::Send "^t"            ; 新建标签页
        ~Space & r::Send "{F5}"          ; 刷新
        ~Space & [::Send "!{Left}"       ; 后退
        ~Space & ]::Send "!{Right}"      ; 前进
        ~Space & s::Send "^d"            ; 收藏
        ~Space & d::Send "!d"            ; 搜索栏
        #HotIf WinActive("ahk_group BROWSER") and !isEditCursor() and GetKeyState("Shift", "P")
            Space & -::Send "^+{PgUp}"      ; 左移标签
            Space & =::Send "^+{PgDn}"      ; 右移标签
            Space & y::Send "^+y"           ; 打开集锦
            Space & i::{                   ; Quickey搜索bookmark
                    Send "!i"
                    Sleep 400
                    ztSwitchIME("en")
                    Send "/b "
            }
            Space & `;::Send "^w"
        #HotIf
    #HotIf
; #HotIf

;; ====================================================================================
; ███████╗ ██████╗ ████████╗███████╗██████╗  ██████╗ 
; ╚══███╔╝██╔═══██╗╚══██╔══╝██╔════╝██╔══██╗██╔═══██╗
;   ███╔╝ ██║   ██║   ██║   █████╗  ██████╔╝██║   ██║
;  ███╔╝  ██║   ██║   ██║   ██╔══╝  ██╔══██╗██║   ██║
; ███████╗╚██████╔╝   ██║   ███████╗██║  ██║╚██████╔╝
; ╚══════╝ ╚═════╝    ╚═╝   ╚══════╝╚═╝  ╚═╝ ╚═════╝ 
;; ====================================================================================
; zotero

zotero_title := "ahk_exe zotero.exe"
zotero_mode_insert := "Zotero: INSERT"
zotero_mode_normal := "Zotero: NORMAL"
zotero_mode := zotero_mode_insert
zotero_first_active := true ; actually doesn't work, reopen after close will lose mode_win
zotero_mode_win_title := "Zotero Mode"

#HotIf !WinExist(zotero_title)
~#9:: {
    Sleep 7000
    zoteroShowMode() ; first time open zotero
}
#HotIf

#HotIf WinExist(zotero_title)
~#9:: {
    WinActivate(zotero_title)
}
#HotIf

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
#HotIf WinActive(zotero_title)
    !e::Send "^e"           ; toggle left sidebar
    !+e::Send "^+l"         ; focus library
    !+'::Send "^+'"         ; toggle right sidebar
    !+y::Send "^+c"         ; copy bibliography
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
    !o::Send "!{Left}"
    !+o::Send "!{Right}"
    #HotIf WinActive(zotero_title) and (zotero_mode == zotero_mode_normal)
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
    #HotIf
#HotIf

;; ====================================================================================
; ███████╗██╗   ██╗███╗   ███╗████████╗██████╗  █████╗     ██████╗ ██████╗ ███████╗
; ██╔════╝██║   ██║████╗ ████║╚══██╔══╝██╔══██╗██╔══██╗    ██╔══██╗██╔══██╗██╔════╝
; ███████╗██║   ██║██╔████╔██║   ██║   ██████╔╝███████║    ██████╔╝██║  ██║█████╗  
; ╚════██║██║   ██║██║╚██╔╝██║   ██║   ██╔══██╗██╔══██║    ██╔═══╝ ██║  ██║██╔══╝  
; ███████║╚██████╔╝██║ ╚═╝ ██║   ██║   ██║  ██║██║  ██║    ██║     ██████╔╝██║     
; ╚══════╝ ╚═════╝ ╚═╝     ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝     ╚═════╝ ╚═╝     
;; ====================================================================================
; sumtra pdf
#HotIf WinActive("ahk_exe SumatraPDF.exe")
    +k::
    +j::
    {
        switchTab(ThisHotKey)
    }
    d::Send "{Down 24}"                 ; scroll half-page down
    u::Send "{Up 24}"                   ; scroll half-page up
    !f::Send "^f"
#HotIf

;; ====================================================================================
; ███████╗██╗  ██╗██████╗ ██╗      ██████╗ ██████╗ ███████╗██████╗ 
; ██╔════╝╚██╗██╔╝██╔══██╗██║     ██╔═══██╗██╔══██╗██╔════╝██╔══██╗
; █████╗   ╚███╔╝ ██████╔╝██║     ██║   ██║██████╔╝█████╗  ██████╔╝
; ██╔══╝   ██╔██╗ ██╔═══╝ ██║     ██║   ██║██╔══██╗██╔══╝  ██╔══██╗
; ███████╗██╔╝ ██╗██║     ███████╗╚██████╔╝██║  ██║███████╗██║  ██║
; ╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
;; ====================================================================================
; explorer
explorer_title := "ahk_exe explorer.exe"

#HotIf WinExist(explorer_title)
#e:: Send "#1"
#+e:: {
    Send "#+1"
}
#HotIf

#HotIf WinActive(explorer_title)
    !e::Send "!d{Tab}{Tab}"                 ; 聚焦侧边栏
    !'::Send "!d{Tab}{Tab}^a{Up}{Down}"     ; 聚焦文件区域
    !t::Send "^t"                           ; 新建标签页
    !m::{                                   ; 打开右键菜单 "Shift+F10"
        Sleep 180 ; 关键，magic
        Send "+{F10}"
        return
    }
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
; emacs
emacs_name := "emacs.exe"
emacs_title := Format("ahk_exe {1:s}", emacs_name)
emacs_term_title := "emacs* ahk_class ConsoleWindowClass|CASCADIA_HOSTING_WINDOW_CLASS"
emacs_hide_term_title := "emacsHideTerminal"
emacsHideTerminal() {
    font := FONT_MSYAHEI
    font_size := 16
    arr_q := [
        ["Force hiding emacs terminal?",    ["s" font_size, font, "Center"]],
    ]
    func_yes(*) {
        if WinExist(emacs_term_title) {
            WinHide(emacs_term_title)
            WinClose(emacs_hide_term_title)
        }
    }
    ztDialog(arr_q, func_yes, emacs_hide_term_title)
}
~#2:: {
    if !WinExist(emacs_title) {
        WinHide(WinWait(emacs_term_title, , ,))
        WinActivate(WinWait(emacs_title, , ,))
        Sleep 400
        ztSwitchIME("en") ; 初始化英文输入
    }
}

#HotIf WinActive(emacs_title)
    !x::Send "!x"
    !;:: {
        Send "{Esc}"
        ztSwitchIME("en") ; 英文输入
    }
    ~!+,:: {
        ztSwitchIME("en") ; insert template时切换英文
    }
#HotIf

;; ====================================================================================
; ██╗   ██╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗
; ██║   ██║██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
; ██║   ██║███████╗██║     ██║   ██║██║  ██║█████╗  
; ╚██╗ ██╔╝╚════██║██║     ██║   ██║██║  ██║██╔══╝  
;  ╚████╔╝ ███████║╚██████╗╚██████╔╝██████╔╝███████╗
;   ╚═══╝  ╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
;; ====================================================================================
; vscode
; ~#3:: {                                  ; WIN + 3                   -> run/min vscode
;     if !WinExist(vscode_title) {
;         Sleep 10000
;         vscodeShowMode() ; first open vscode
;     } else if !WinActive(vscode_title) {
;         Sleep 600
;         vscodeShowMode() ; reenter vscode
;     }
; }
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
#HotIf WinActive(vscode_title)
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
    #HotIf WinActive(vscode_title) and GetKeyState("Shift", "P")
        ~Space & [::Send "!+["
        ~Space & ]::Send "!+]"
        ~Space & u::Send "+!u"
        ~Space & d::Send "+!d"
    #HotIf

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
    #HotIf
#HotIf

;; ====================================================================================
; ██╗    ██╗██████╗ ██╗  ██╗███████╗
; ██║    ██║██╔══██╗╚██╗██╔╝██╔════╝
; ██║ █╗ ██║██████╔╝ ╚███╔╝ █████╗  
; ██║███╗██║██╔═══╝  ██╔██╗ ██╔══╝  
; ╚███╔███╔╝██║     ██╔╝ ██╗███████╗
;  ╚══╝╚══╝ ╚═╝     ╚═╝  ╚═╝╚══════╝
;; ====================================================================================
; excel & ppt & ...
excel_title := "ahk_exe EXCEL.EXE"
word_title := "ahk_exe WINWORD.EXE"
ppt_title := "ahk_exe POWERPNT.EXE"
outlook_title := "ahk_exe OUTLOOK.EXE"
GroupAdd("WPX", excel_title)
GroupAdd("WPX", word_title)
GroupAdd("WPX", ppt_title)
GroupAdd("WPX", outlook_title)
#HotIf WinActive("ahk_group WPX")
    !s::Send "^s"
    !d::Send "{PgDn}"
    !u::Send "{PgUp}"
    !f::Send "^e"
    #HotIf WinActive(excel_title)
        !i::Send "{F2}"
    #HotIf
#HotIf

#HotIf WinActive(outlook_title)
    ^j::Send "^+1" ;; Done & Move (need to be configured on Outlook, mapped to "C-S-1")
    ^k::Send "^+2" ;; Read (need to be configured on Outlook, mapped to "C-S-2")
#HotIf

;; ====================================================================================
; ██╗    ██╗██╗███╗   ██╗    ████████╗███████╗██████╗ ███╗   ███╗
; ██║    ██║██║████╗  ██║    ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
; ██║ █╗ ██║██║██╔██╗ ██║       ██║   █████╗  ██████╔╝██╔████╔██║
; ██║███╗██║██║██║╚██╗██║       ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
; ╚███╔███╔╝██║██║ ╚████║       ██║   ███████╗██║  ██║██║ ╚═╝ ██║
;  ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝       ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
;; ====================================================================================
; Windows Terminal
winterm_title := "ahk_exe WindowsTerminal.exe"
~#4:: {
    if !WinExist(winterm_title) {
        WinActivate(WinWait(winterm_title, , ,))
        Sleep 400
        ztSwitchIME("en") ; 初始化英文输入
    }
}
#HotIf WinActive(winterm_title)
    !p::Send "+{Insert}"
    ^v::Send "^v"
    !+h::Send "+{Left}"                    ; ALT + SHIFT + h    ->    CRLT+SHIFT+Left
    !+l::Send "+{Right}"                   ; ALT + SHIFT + l    ->    CRLT+SHIFT+Right
    !+j::Send "+{Down}"
    !+k::Send "+{Up}"
    !+BackSpace::Send "!{Del}"             ; ALT + SHIFT + BS   ->    BackSpace Word
    !a::Send "^_"                          ; ALT + a            ->    Let terminal configures
    #HotIf WinActive(winterm_title) and GetKeyState("Shift", "P")
        ~Space & [::Send "!+["
        ~Space & ]::Send "!+]"
        ~Space & u::Send "+!u"
        ~Space & d::Send "+!d"
    #HotIf
#HotIf


;; ====================================================================================
; ███████╗████████╗██╗  ██╗
; ██╔════╝╚══██╔══╝╚██╗██╔╝
; █████╗     ██║    ╚███╔╝ 
; ██╔══╝     ██║    ██╔██╗ 
; ███████╗   ██║   ██╔╝ ██╗
; ╚══════╝   ╚═╝   ╚═╝  ╚═╝
;; ====================================================================================
; ETX
etx_title := "ahk_exe etxc.exe"
#HotIf WinActive(etx_title)
    !x::Send "!x"
#HotIf


;; ====================================================================================
; ██╗    ██╗███████╗ ██████╗██╗  ██╗ █████╗ ████████╗
; ██║    ██║██╔════╝██╔════╝██║  ██║██╔══██╗╚══██╔══╝
; ██║ █╗ ██║█████╗  ██║     ███████║███████║   ██║   
; ██║███╗██║██╔══╝  ██║     ██╔══██║██╔══██║   ██║   
; ╚███╔███╔╝███████╗╚██████╗██║  ██║██║  ██║   ██║   
;  ╚══╝╚══╝ ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   
;; ====================================================================================
; WeChat
wechat_name := "WeChat.exe"
wechat_title := "ahk_exe WeChat.exe"
wechat_login_title := "ahk_class WeChatLoginWndForPC"
; #w:: {
;     if WinExist(wechat_title) {
;         if WinExist(wechat_login_title) {
;             Send "#5"
;         } else {
;             Send "^[" ; WIN + w -> Ctrl + [  (Toggle Wechat "微信")
;         }
;     } else {
;         Send "#5"
;     }
; }
#w::Send "^[" ; WIN + w -> Ctrl + [  (Toggle Wechat "微信")
#HotIf WinActive(wechat_title)
    !f::Send "^f" ; Search
#HotIf

;; ====================================================================================
; ███████╗ ██████╗  ██████╗██╗   ██╗███████╗████████╗██╗███╗   ███╗███████╗██████╗ 
; ██╔════╝██╔═══██╗██╔════╝██║   ██║██╔════╝╚══██╔══╝██║████╗ ████║██╔════╝██╔══██╗
; █████╗  ██║   ██║██║     ██║   ██║███████╗   ██║   ██║██╔████╔██║█████╗  ██████╔╝
; ██╔══╝  ██║   ██║██║     ██║   ██║╚════██║   ██║   ██║██║╚██╔╝██║██╔══╝  ██╔══██╗
; ██║     ╚██████╔╝╚██████╗╚██████╔╝███████║   ██║   ██║██║ ╚═╝ ██║███████╗██║  ██║
; ╚═╝      ╚═════╝  ╚═════╝ ╚═════╝ ╚══════╝   ╚═╝   ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
;; ====================================================================================
; ; FocusTimer
#f:: {
    focus_duration := InputBox("Enter Duration", "FocusTimer", "w200 h100", 45).value
    Run "ms-clock://createfocustimer?skipBreaks=false&displayMode=aot&force=true&duration=" . focus_duration
}
#+f:: {
    Run "ms-clock://pausefocustimer"
}
#^f:: {
    Run "ms-clock://resetfocustimer"
}



;; ====================================================================================
; ███╗   ███╗██╗███████╗ ██████╗
; ████╗ ████║██║██╔════╝██╔════╝
; ██╔████╔██║██║███████╗██║     
; ██║╚██╔╝██║██║╚════██║██║     
; ██║ ╚═╝ ██║██║███████║╚██████╗
; ╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝
;; ====================================================================================
; miscellaneous
#^!z:: ztToolTip("love you!")
