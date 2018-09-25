#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force

!^s::
IfWinNotExist ahk_exe SnakeTail.exe
{
	Run C:\Program Files\SnakeTail\SnakeTail.exe, C:\Program Files\SnakeTail\
	WinWait ahk_exe SnakeTail.exe
	Send !f
	Sleep 100
	Send {Enter}
	Sleep 100
	Send scriptslog.txt
	Sleep 100
	Send {Enter}
	Sleep 200
	Send !f
	Sleep 100
	Send w
	Sleep 500
}
IfWinNotExist ahk_exe TheWitcher3ModManager.exe
{
	Run C:\Test\TheWitcher3ModManager.exe, C:\Test
	WinWait ahk_exe TheWitcher3ModManager.exe
	Sleep 200
}
WinActivate ahk_exe TheWitcher3ModManager.exe
Send ^e
Sleep 100
Send PrimalNeeds2
Send {Enter}
Sleep 200
Send {left}
Send {Enter}
Sleep 200
WinMinimize ahk_exe TheWitcher3ModManager.exe
WinActivate ahk_exe idea64.exe
Sleep 500
WinActivate ahk_exe SnakeTail.exe
RunWait C:\Games\The Witcher 3 - Wild Hunt\bin\x64\witcher3.exe -net -debugscripts, C:\Games\The Witcher 3 - Wild Hunt\bin\x64
WinMinimize ahk_exe SnakeTail.exe
return

