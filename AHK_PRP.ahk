#SingleInstance, force
If WinActive("Outlook") {
    ;Switch between Email/ Calendar / Notes / ToDo's
    !NumpadEnter::
        cntr_Taskbar++
        if cntr_Taskbar = 1
            Send, ^1
        else if cntr_Taskbar = 2
            Send, ^2
        else if cntr_Taskbar = 3
            Send,  ^5
        else if cntr_Taskbar = 4
        {
            Send, ^4
            cntr_Taskbar = 0
        }
    return

    ;Switch between Read / Unread
    !NumpadDot::
        counter++
        if counter = 1
            Send, ^U
        else if counter = 2
        {
            Send, ^O
            counter = 0
        }

    ;Switch between different Calendar Views
    !Numpad0:: 
        cntr_Views++
        if cntr_Views = 1
            Send, ^!2
        else if cntr_Views = 2
        {
            Send, ^!4
            cntr_Views = 0
        }
    return

    ;Set Label Antworten
    !Numpad1::
        Send, ^+1
    return

    ;Set Label In Bearbeitung erwarten
    !Numpad2::
        Send, ^+8
    return

    ;Set Label Antwort erwarten
    !Numpad3::
        Send, ^+2
    return

    ;Set Label Archiv - Random
    !Numpad4::
        Send, ^+3
    return

    ;Set Label Archiv - Tosca
    !Numpad5::
        Send, ^+4
    return

    ;Set Label Archiv - Gehalt
    !Numpad6::
        Send, ^+5
    return

    ;Set Label Archiv - PrP: Projekt Intern
    !Numpad7::
        Send, ^+6
    return

    ;Set Label PrP: Service Enabling
    !Numpad8::
        SEND, ^+7
    return

    ;Set Label PrP: Zurückgestellt
    !Numpad9::
        SEND, ^+9
    return
}

; Open Downloads folder
#+e::
    GoTo_FileManagment()
return

;Prepare PRP folder for commit
#IfWinActive ahk_exe ConEmu64.exe
!Numpad1::
    Send, cd /mnt/d/file-managment/p/prp
    Send, {Enter}
    Send, git add .    
    Send, {Enter}
    Send, git commit -m "%A_YYYY%-%A_MM%-%A_DD%:     
return

;Push to pi
#IfWinActive ahk_exe ConEmu64.exe
!Numpad2::
    Send, git push pi master
    Send, {Enter}
return

;Check Syntax
#IfWinActive ahk_exe saplogon.exe
!Numpad1::
    Send, ^{F2}
return

;Run Pretty Printer
#IfWinActive ahk_exe saplogon.exe
!Numpad2::
    Send, +{F1}
return

;Activate Code
#IfWinActive ahk_exe saplogon.exe
!Numpad3::
    Send, ^{F3}
return

;Jump Into Abap-Editor
#IfWinActive ahk_exe saplogon.exe
!Numpad4::
    Send, ^{F6}
return

;Jump Out of Abap-Editor
#IfWinActive ahk_exe saplogon.exe
!Numpad5::
    Send, {F3}
return

;Swap between show and edit
#IfWinActive ahk_exe saplogon.exe
!Numpad6::
    Send, ^{F1}
return

;Set Session Break-Point 
#IfWinActive ahk_exe saplogon.exe
!Numpad7::
    Send, ^+{F12}
return

;Set External Break-Point
#IfWinActive ahk_exe saplogon.exe
!Numpad8::
    Send, ^+{F9}
return

;Set Objectlist
#IfWinActive ahk_exe saplogon.exe
!Numpad9::
    Send, ^+{F5}
return

;Close all Windows for MANDT
#IfWinActive ahk_exe saplogon.exe
^Numpad0::
    GoTo_Transaction("ex", "N", "Y")
return

;Go To SE80
#IfWinActive ahk_exe saplogon.exe
^Numpad1::
    GoTo_Transaction("se80", "N", "Y")
return

;Go To SE16N
#IfWinActive ahk_exe saplogon.exe
^Numpad2::
    GoTo_Transaction("se16n", "N", "Y")
return

;Go To TCODE Search
#IfWinActive ahk_exe saplogon.exe
^Numpad3::
    GoTo_Transaction("", "N", "N")
return

;Go To SE80
#IfWinActive ahk_exe saplogon.exe
^Numpad4::
    GoTo_Transaction("se80", "O", "Y")
return

;Go To SE16N
#IfWinActive ahk_exe saplogon.exe
^Numpad5::
    GoTo_Transaction("se16n", "O", "Y")
return

;Go To TCODE Search
#IfWinActive ahk_exe saplogon.exe
^Numpad6::
    GoTo_Transaction("", "O", "N")
return

GoTo_Transaction(TCode, Modus, Execute) 
{
    ;Select TCODE SearchBar
    Send, ^+7
    Sleep 10

    ;Decide Between New Window and Reuse Window
    ;subsequently send needed command
    If (Modus = "N") 
    {
        Send /n%TCode%
        Sleep 10
    }
    else if (Modus = "O")
    {
        Send /o%TCode%
        Sleep 10
    }

    ;Open Transaction
    If (Execute = "Y")
    {
        Send {Enter}
    }
}

GoTo_FileManagment()
{
    ; Work-Laptop
    if (A_UserName = "Marklowski") {
        Run "C:\File-Managment" ; ctrl+shift+d
    }
    ; Desktop-PC at Home
    else if (A_UserName = "Home") {
        Run "D:\File-Managment" ; ctrl+shift+d
    }
}