Dim WShell
Set WShell = CreateObject("WScript.Shell")
WShell.Run "anydesk.exe", 0
Set WShell = Nothing