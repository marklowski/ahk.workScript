#SingleInstance, force

;
;   HOTKEYS
;

; Gloabl Variables
OutlookTaskBar = 0
OutlookUnRead = 0
OutlookCalender = 0
MainVersion = 0
SubVersion = 0

;check / create config file
initializeScript()

#+e::goToFileManagment()   ; Open Downloads folder
!Numpad1::launchPrograms("SAP")
!Numpad2::launchPrograms("ECLIPSE")
!Numpad3::launchPrograms("WORKSPACE1")
!Numpad4::launchPrograms("WORKSPACE2")

;Hotkeys for OUTLOOK
#IfWinActive ahk_exe OUTLOOK.EXE
    !NumpadEnter::switchTaskBar(OutlookTaskBar)   ;Switch between Email/ Calendar / Notes / ToDo's
    !NumpadDot::switchUnRead(OutlookUnRead)      ;Switch between Read / Unread
    !Numpad0::switchCalendar(OutlookCalender)     ;Switch between different Calendar Views
    !Numpad1::Send, ^+1   ;Move eMail to specific Outlook Directory
    !Numpad2::Send, ^+2   ;Move eMail to specific Outlook Directory
    !Numpad3::Send, ^+3   ;Move eMail to specific Outlook Directory
    !Numpad4::Send, ^+4   ;Move eMail to specific Outlook Directory
    !Numpad5::Send, ^+5   ;Move eMail to specific Outlook Directory
    !Numpad6::Send, ^+6   ;Move eMail to specific Outlook Directory
    !Numpad7::Send, ^+7   ;Move eMail to specific Outlook Directory
    !Numpad8::SEND, ^+8   ;Move eMail to specific Outlook Directory
    !Numpad9::SEND, ^+9   ;Move eMail to specific Outlook Directory

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
    !NumpadDiv::sendHeader("H", MainVersion, SubVersion)    ;Set Abap Header
    !NumpadMult::sendHeader("E", MainVersion, SubVersion)   ;Set Abap Header-Entry
    !NumpadSub::MainVersion:=MainVersion+1
    !NumpadAdd::SubVersion:=SubVersion+1
    ^Numpad0::goToTransaction("ex", "N", "Y")      ;Close all Windows for MANDT
    ^Numpad1::goToTransaction("se80", "N", "Y")    ;Go To SE80 Same Window
    ^Numpad2::goToTransaction("se16n", "N", "Y")   ;Go To SE16N Same Window
    ^Numpad3::goToTransaction("", "N", "N")        ;Go To TCODE Search Same Window
    ^Numpad4::goToTransaction("se80", "O", "Y")    ;Go To SE80 New Window
    ^Numpad5::goToTransaction("se16n", "O", "Y")   ;Go To SE16N New Window
    ^Numpad6::goToTransaction("", "O", "N")        ;Go To TCODE Search New Window

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
initializeScript()
{

    if !FileExist( "sapHeader.txt" ) {
        FileAppend, `n, %A_WorkingDir%\sapHeader.txt
    }

    if !FileExist( "sapSubHeader.txt" ) {
        FileAppend, `n, %A_WorkingDir%\sapSubHeader.txt
    }

    if !FileExist( "Config.txt" ) {
        FileAppend, FileManagment=`nEclipseVersion=`nVisualStudioWorkspace1=`nVisualStudioWorkspace2=`n, %A_WorkingDir%\Config.txt

        MsgBox, 4, Config File was created,  Open Config File Folder?        
        IfMsgBox, Yes
            Run "%A_WorkingDir%"
    }
}

readConfigParameter(Setting)
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

goToFileManagment()
{
    Config := Read_Config("FileManagment")
    Run %Config%
    return
}

launchPrograms(Program)
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
switchTaskBar(ByRef OutlookTaskBar)
{
    OutlookTaskBar++
    if OutlookTaskBar = 1
        Send, ^1
    else if OutlookTaskBar = 2
        Send, ^2
    else if OutlookTaskBar = 3
        Send,  ^5
    else if OutlookTaskBar = 4
    {
        Send, ^4
        OutlookTaskBar = 0
    }
}

switchUnRead(ByRef OutlookUnRead)
{
    OutlookUnRead++
    if OutlookUnRead = 1
        Send, ^U
    else if OutlookUnRead = 2
    {
        Send, ^Q
        OutlookUnRead = 0
    }
}

switchCalendar(ByRef OutlookCalender)
{
    OutlookCalender++
    if OutlookCalender = 1
        Send, ^!2
    else if OutlookCalender = 2
    {
        Send, ^!4
        OutlookCalender = 0
    }
}

;Functions for SAP Hotkeys
goToTransaction(TCode, Modus, Execute) 
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
sendHeader(Modus, byref MainVersion, byref SubVersion)
{
    FormatTime, CurrentDateTime,, dd.MM.yyyy
    clipboard := ""    
    if (Modus = "H")
    {
        FileRead, clipboard, sapHeader.txt
        StringReplace, clipboard, clipboard, ##CurrentDateTime, %CurrentDateTime%, All
    }
    else if (Modus = "E")
    {
        if(MainVersion = 0)
            MainVersion = 1
        
        FileRead, clipboard, sapSubHeader.txt
        StringReplace, clipboard, clipboard, ##CurrentDateTime, %CurrentDateTime%, All
        StringReplace, clipboard, clipboard, ##MainVersion, %MainVersion%, All
        StringReplace, clipboard, clipboard, ##SubVersion, %SubVersion%, All
    }

    ClipWait, 2    
    if (!ErrorLevel)
        Send, ^v
    
    Sleep, 300
    MainVersion = 0
    SubVersion = 0
    return
}
