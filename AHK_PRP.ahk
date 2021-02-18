#SingleInstance, force

;
;   HOTKEYS
;

; Open Downloads folder
#+e::GoTo_FileManagment()

;Hotkeys for OUTLOOK
#IfWinActive ahk_exe OUTLOOK.EXE
    !NumpadEnter::Switch_TaskBar()  ;Switch between Email/ Calendar / Notes / ToDo's
    !NumpadDot::Switch_Un_Read()    ;Switch between Read / Unread
    !Numpad0::Switch_Calendar()     ;Switch between different Calendar Views
    !Numpad1::Send, ^+1   ;Set Label Antworten
    !Numpad2::Send, ^+8   ;Set Label In Bearbeitung erwarten
    !Numpad3::Send, ^+2   ;Set Label Antwort erwarten
    !Numpad4::Send, ^+3   ;Set Label Archiv - Random
    !Numpad5::Send, ^+4   ;Set Label Archiv - Tosca
    !Numpad6::Send, ^+5   ;Set Label Archiv - Gehalt
    !Numpad7::Send, ^+6   ;Set Label Archiv - PrP: Projekt Intern
    !Numpad8::SEND, ^+7   ;Set Label PrP: Service Enabling
    !Numpad9::SEND, ^+9   ;Set Label PrP: Zurückgestellt

;Hotkeys for CMDER
#IfWinActive ahk_exe ConEmu64.exe
    !Numpad1::Prepare_PrP_Commit()  ;Prepare PRP folder for commit
    !Numpad2::Push_PrP_Pi()         ;Push to pi

;Hotkeys for SAP
#IfWinActive ahk_exe saplogon.exe
    !Numpad1::Send, ^{F2}   ;Check Syntax
    !Numpad2::Send, +{F1}   ;Run Pretty Printer
    !Numpad3::Send, ^{F3}   ;Activate Code
    !Numpad4::Send, ^{F6}   ;Jump Into Abap-Editor
    !Numpad5::Send, {F3}    ;Jump Out of Abap-Editor
    !Numpad6::Send, ^{F1}   ;Swap between show and edit
    !Numpad7::Send, ^+{F12} ;Set Session Break-Point
    !Numpad8::Send, ^+{F9}  ;Set External Break-Point
    !Numpad9::Send, ^+{F5}  ;Set Objectlist
    ^Numpad0::GoTo_Transaction("ex", "N", "Y")      ;Close all Windows for MANDT
    ^Numpad1::GoTo_Transaction("se80", "N", "Y")    ;Go To SE80 Same Window
    ^Numpad2::GoTo_Transaction("se16n", "N", "Y")   ;Go To SE16N Same Window
    ^Numpad3::GoTo_Transaction("", "N", "N")        ;Go To TCODE Search Same Window
    ^Numpad4::GoTo_Transaction("se80", "O", "Y")    ;Go To SE80 New Window
    ^Numpad5::GoTo_Transaction("se16n", "O", "Y")   ;Go To SE16N New Window
    ^Numpad6::GoTo_Transaction("", "O", "N")        ;Go To TCODE Search New Window

;
;   FUNCTIONS
;
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

; Functions for OUTLOOK Hotkeys
Switch_Calendar()
{
    cntr_Views++
    if cntr_Views = 1
        Send, ^!2
    else if cntr_Views = 2
    {
        Send, ^!4
        cntr_Views = 0
    }
}

Switch_Un_Read()
{
    counter++
    if counter = 1
        Send, ^U
    else if counter = 2
    {
        Send, ^O
        counter = 0
    }
}

Switch_TaskBar()
{
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
}

; Functions for CMDER Hotkeys
Prepare_PrP_Commit()
{
    Send, cd /mnt/d/file-managment/p/prp
    Send, {Enter}
    Send, git add .    
    Send, {Enter}
    Send, git commit -m "%A_YYYY%-%A_MM%-%A_DD%:    
}

Push_PrP_Pi()
{
    Send, git push pi master
    Send, {Enter}
}


;Functions for SAP Hotkeys
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