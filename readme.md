# Shortcuts

## General Shortcuts

- WIN+SHIFT+E: Open Specified File.Managment Folder
- ALT+1: Open SAP Login
- ALT+2: Open Eclipse
- ALT+3: Open VS Workspace 1
- ALT+4: Open VS Workspace 2

## SAP Shortcuts

### ALT

- ALT+1:    Check Syntax
- ALT+2:    Run PrettyPrinter
- ALT+3:    Activate Code
- ALT+4:    Jump Into Abap-Editor
- ALT+5:    Jump Out of Abap-Editor
- ALT+6:    Swap between show and edit
- ALT+7:    Set Session Break-Point
- ALT+8:    Set External Break-Point
- ALT+9:    Set Objectlist
- ALT+'/':  Set Abap Header
- ALT+'*':  Set Abap Header-Entry ( the following two shortcuts can be used to determine the version
- ALT+'+':  ABAP Header Entry Increment Main Version ('1.*' -> '2.*' )
- ALT+'-':  ABAP Header Entry Increment Sub Version  ('*.1' -> '*.2' )

### STRG

- STRG+0: Close all SAP Windows for current Mandt
- STRG+1: Same Window -> Open SE80
- STRG+2: Same Window -> Open SE16N
- STRG+3: Focus SAP Searchbar -> and add /n to open TCODE within the Same Window
- STRG+4: New Window -> Open SE80
- STRG+5: New Window -> Open SE16N
- STRG+6: Focus SAP Searchbar -> and add /o to open TCODE within the New Window

## Eclipse Shortcuts

- ALT+1:    Check Syntax
- ALT+2:    Run PrettyPrinter
- ALT+3:    Activate Code
- ALT+4:    Change between Commented & Uncommented
- ALT+7:    Set Session Break-Point
- ALT+8:    Set External Break-Point

## Outlook Shortcuts

- ALT+Enter:    Switch between Email / Calender / Notes / ToDo's
- ALT+Dot:      Switch eMail between Read/ Unread
- ALT+0:        Switch between different Calender Views
- ALT+1:        Send CTRL+1, can be used to move eMails to specific folders
- ALT+2:        Send CTRL+2, can be used to move eMails to specific folders
- ALT+3:        Send CTRL+3, can be used to move eMails to specific folders
- ALT+4:        Send CTRL+4, can be used to move eMails to specific folders
- ALT+5:        Send CTRL+5, can be used to move eMails to specific folders
- ALT+6:        Send CTRL+6, can be used to move eMails to specific folders
- ALT+7:        Send CTRL+7, can be used to move eMails to specific folders
- ALT+8:        Send CTRL+8, can be used to move eMails to specific folders
- ALT+9:        Send CTRL+9, can be used to move eMails to specific folders

## Config Files

Die Dateien befinden sich innerhalb der autoHotKey.exe, und es gibt momentan 3 verschiedene Dateien.

### General Settings - Config.txt

Die möglichen Allgemeinen Einstellungen lauten wie folgt:

- **invertTCode: (Yes/No)** Mithilfe dieser Option kann man innerhalb die SAP Shortcuts für neues Fenster / gleiches Fenster invertieren
- **fileManagment:** Mithilfe dieser Einstellung kann man einen bestimmten Ordner direkt aufrufen.
- **eclipseVersion:** Wird benötigt damit die korrekte Eclipse Version gestartet wird.
- **visualStudioWorkspace1:** Mithilfe dieser Option ist man in der Lage einen Visual Studio Code Workspace aufzurufen.
- **visualStudioWorkspace2:** Mithilfe dieser Option ist man in der Lage einen Visual Studio Code Workspace aufzurufen.

Beispiel Config.txt

```ini
    invertTCode=No
    fileManagment=C:\file.managment
    eclipseVersion=platform-2022-12
    visualStudioWorkspace1=C:\file.managment\v\visual-studio-code\<Name 1>.code-workspace
    visualStudioWorkspace2=C:\file.managment\v\visual-studio-code\<Name 2>.code-workspace
```

## SAP Header Settings - sapHeader.txt

Mithilfe dieser Datei kann der gewünschte SAP Standard Header Dynamisch hinzugefügt werden.
Hierzu gibt es eine extra Optionen:

- **##CurrentDateTime**: Diese kann verwendet werden um das aktuelle Datum hinzuzufügen (dd-MM-yyyy)

Beispiel sapHeader.txt:

```ini
*<D>-------------------------------------------------------------------
* Autor.........: Philipp von Marklowski
* Angelegt am...: ##CurrentDateTime
*----------------------------------------------------------------------
* Beschreibung:
*
*----------------------------------------------------------------------
* Datum       Autor     Info
*----------------------------------------------------------------------
*
*</D>------------------------------------------------------------------
```

## SAP Sub Header Settings - sapSubHeader.txt

Abschließende gibt es noch die sapSubHeader Datei, mithilfe dieser Datei kann der gewünschte SAP Sub Header Dynamisch hinzugefügt werden.
Hierzu gibt es auch extra Optionen:

- **##CurrentDateTime**: Diese kann verwendet werden um das aktuelle Datum hinzuzufügen (dd-MM-yyyy)
- **##MainVersion**: Dadurch kann man eine Haupt Version hinzufügen.
- **##SubVersion**: Dadurch kann man eine Sub Version hinzufügen.

Beispiel sapSubHeader.txt 1:

```ini
* ##CurrentDateTime  PVM
```

Beispiel sapSubHeader.txt 2:

```ini
* ##MainVersion.##SubVersion   ##CurrentDateTime  PVM
```
