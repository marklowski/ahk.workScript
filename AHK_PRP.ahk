#SingleInstance, force

;
;   HOTKEYS
;

; Gloabl Variables
Outlook_TaskBar = 0
Outlook_UnRead = 0
Outlook_Calender = 0
SAP_VersionMain = 0
SAP_VersionSub = 0

;check / create config file
Initialize_Script()

#+e::GoTo_FileManagment()   ; Open Downloads folder
!Numpad1::Launch_Programs("SAP")
!Numpad2::Launch_Programs("ECLIPSE")
!Numpad3::Launch_Programs("WORKSPACE1")
!Numpad4::Launch_Programs("WORKSPACE2")

;Hotkeys for OUTLOOK
#IfWinActive ahk_exe OUTLOOK.EXE
    !NumpadEnter::Switch_TaskBar(Outlook_TaskBar)   ;Switch between Email/ Calendar / Notes / ToDo's
    !NumpadDot::Switch_Un_Read(Outlook_UnRead)      ;Switch between Read / Unread
    !Numpad0::Switch_Calendar(Outlook_Calender)     ;Switch between different Calendar Views
    !Numpad1::Send, ^+1   ;Set Label Antworten
    !Numpad2::Send, ^+8   ;Set Label In Bearbeitung erwarten
    !Numpad3::Send, ^+2   ;Set Label Antwort erwarten
    !Numpad4::Send, ^+3   ;Set Label Archiv - Random
    !Numpad5::Send, ^+4   ;Set Label Archiv - Tosca
    !Numpad6::Send, ^+5   ;Set Label Archiv - Gehalt
    !Numpad7::Send, ^+6   ;Set Label Archiv - PrP: Projekt Intern
    !Numpad8::SEND, ^+7   ;Set Label PrP: Service Enabling
    !Numpad9::SEND, ^+9   ;Set Label PrP: Zurückgestellt

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
    !NumpadDiv::Send_Header("H", SAP_VersionMain, SAP_VersionSub)    ;Set Abap Header
    !NumpadMult::Send_Header("E", SAP_VersionMain, SAP_VersionSub)   ;Set Abap Header-Entry
    !NumpadSub::SAP_VersionMain:=SAP_VersionMain+1
    !NumpadAdd::SAP_VersionSub:=SAP_VersionSub+1
    ^Numpad0::GoTo_Transaction("ex", "N", "Y")      ;Close all Windows for MANDT
    ^Numpad1::GoTo_Transaction("se80", "N", "Y")    ;Go To SE80 Same Window
    ^Numpad2::GoTo_Transaction("se16n", "N", "Y")   ;Go To SE16N Same Window
    ^Numpad3::GoTo_Transaction("", "N", "N")        ;Go To TCODE Search Same Window
    ^Numpad4::GoTo_Transaction("se80", "O", "Y")    ;Go To SE80 New Window
    ^Numpad5::GoTo_Transaction("se16n", "O", "Y")   ;Go To SE16N New Window
    ^Numpad6::GoTo_Transaction("", "O", "N")        ;Go To TCODE Search New Window

;Hotkeys for Eclipse
#IfWinActive ahk_exe eclipse.exe    
    !Numpad1::Send, ^{F2}   ;Check Syntax
    !Numpad2::Send, +{F1}   ;Run Pretty Printer
    !Numpad3::Send, ^+{F3}   ;Activate Code
    !Numpad4::Send, ^7   ;Change between Commented & Uncommented
    !Numpad7::Send, !B ;Set Soft Breakpoint
    !Numpad8::Send, ^!B  ;Set Break-Point

;
;   FUNCTIONS
;
Initialize_Script()
{
    if !FileExist( "Config.txt" ) {
        FileAppend, FileManagment=`nEclipseVersion=`nVisualStudioWorkspace1=`nVisualStudioWorkspace2=`n, %A_WorkingDir%\Config.txt

        MsgBox, 4, Config File was created,  Open Config File Folder?        
        IfMsgBox, Yes
            Run "%A_WorkingDir%"
    }
}

Read_Config(Setting)
{
    SearchString := Setting
    Loop, read, Config.txt
    {
        if InStr(A_LoopReadLine, SearchString)
        {
            FileLine := A_LoopReadLine
            break
        }
    }

    FileLineParts := StrSplit(FileLine, "=")
    return FileLineParts[2]
}

GoTo_FileManagment()
{
    Config := Read_Config("FileManagment")
    Run %Config%
    return
}

Launch_Programs(Program)
{
    switch Program
    {
        case "SAP":
            Run, saplogon.exe
            return
        case "ECLIPSE":
            eclipseVersion := Read_Config("EclipseVersion")
            Run, C:\Users\%A_UserName%\eclipse\%eclipseVersion%\eclipse\eclipse.exe
            return
        case "WORKSPACE1":
            WS1Path := Read_Config("VisualStudioWorkspace1")
            Run, %WS1Path%
            return
        case "WORKSPACE2":
            WS2Path := Read_Config("VisualStudioWorkspace2")
            Run, %WS2Path%
            return
    }
}
; Functions for OUTLOOK Hotkeys
Switch_TaskBar(ByRef Outlook_TaskBar)
{
    Outlook_TaskBar++
    if Outlook_TaskBar = 1
        Send, ^1
    else if Outlook_TaskBar = 2
        Send, ^2
    else if Outlook_TaskBar = 3
        Send,  ^5
    else if Outlook_TaskBar = 4
    {
        Send, ^4
        Outlook_TaskBar = 0
    }
}

Switch_Un_Read(ByRef Outlook_UnRead)
{
    Outlook_UnRead++
    if Outlook_UnRead = 1
        Send, ^U
    else if Outlook_UnRead = 2
    {
        Send, ^O
        Outlook_UnRead = 0
    }
}

Switch_Calendar(ByRef Outlook_Calender)
{
    Outlook_Calender++
    if Outlook_Calender = 1
        Send, ^!2
    else if Outlook_Calender = 2
    {
        Send, ^!4
        Outlook_Calender = 0
    }
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

;Functions for Header Texts
Send_Header(Modus, byref SAP_VersionMain, byref SAP_VersionSub)
{
    ClipSaved := ClipboardAll
    FormatTime, CurrentDateTime,, dd.MM.yyyy
    clipboard := ""    
    if (Modus = "H")
    {
        clipboard = 
        (
************************************************************************
* Author:     Marklowski                                               *
* Company:    PrP Project People GmbH                                  *
* Date:       %CurrentDateTime%                                               *
************************************************************************
* Functionality:
* 
*
************************************************************************
* History                                                              *
* Ver   Date        Author      Changes                                *
* 1.0   %CurrentDateTime%  Marklowski  First version                          *
************************************************************************
        )
    }
    else if (Modus = "E")
    {
        if(SAP_VersionMain = 0)
            SAP_VersionMain = 1
        
        clipboard =
        (
            * %SAP_VersionMain%.%SAP_VersionSub%   %CurrentDateTime%  Marklowski  *
        )
    }

    ClipWait, 2    
    if (!ErrorLevel)
        Send, ^v
    
    Sleep, 300
    clipboard := ClipSaved
    ClipSaved = ""
    SAP_VersionMain = 0
    SAP_VersionSub = 0
    return
}