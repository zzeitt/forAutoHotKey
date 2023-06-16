#Requires AutoHotkey v2.0-beta


;- show selected keyboard language 
SetFormat, Integer, H
a2:= DllCall("user32.dll\GetKeyboardLayout", "UInt", ThreadId, "UInt")
msgbox,Now=%a2%
Return

x Keyboardchangelanguage
;- can change keyboard , but use WIN+SPACE or alt+Shift to select ( WIN-10 ) 
;--------------------------------------------------------------------------
;- (0x0406)=danish  (0x0409)=English (USA)  (0x0411)=Japanese
;-------------------------------------------------------------
; https://docs.microsoft.com/de-de/windows/desktop/Intl/language-identifier-constants-and-strings
F6::SetDefaultKeyboardLang(0x0409)  ; english -USA
F7::SetDefaultKeyboardLang(0x0408)  ; greek el-GR
F8::SetDefaultKeyboardLang(0x0807)  ; swiss german de-CH
;-------------------------------
; https://autohotkey.com/boards/viewtopic.php?f=6&t=18519
SetDefaultKeyboardLang(LocaleID){
	Static SPI_SETDEFAULTINPUTLANG := 0x005A, SPIF_SENDWININICHANGE := 2	
	Lan := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
	VarSetCapacity(binaryLocaleID, 4, 0)
	NumPut(LocaleID, binaryLocaleID)
	DllCall("SystemParametersInfo", "UInt", SPI_SETDEFAULTINPUTLANG, "UInt", 0, "UPtr", &binaryLocaleID, "UInt", SPIF_SENDWININICHANGE)	
	WinGet, windows, List
	Loop % windows {
		PostMessage 0x50, 0, % Lan, , % "ahk_id " windows%A_Index%
	}
}
;===========================================================================================