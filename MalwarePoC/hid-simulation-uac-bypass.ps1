# Activating the Windows Key
powershell -c (New-Object -ComObject "Shell.Application").FileRun() | Out-Null

Add-Type -AssemblyName System.Windows.Forms
Start-Sleep -Seconds 2
[System.Windows.Forms.SendKeys]::SendWait('cmd')
Start-Sleep -Seconds 2
[System.Windows.Forms.SendKeys]::SendWait('^+{ENTER}')
Start-Sleep -Seconds 2    
[System.Windows.Forms.SendKeys]::SendWait('{LEFT}')
Start-Sleep -Seconds 2    
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
<#
#Abrir PowerShell y escribir: window skey
[System.Windows.Forms.SendKeys]::SendWait("^({ESC})")
Start-Sleep -Seconds 2
[System.Windows.Forms.SendKeys]::SendWait("EJECUTAR")
Start-Sleep -Seconds 2
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Seconds 2
[System.Windows.Forms.SendKeys]::SendWait("msedge.exe")
Start-Sleep -Seconds 2
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Seconds 2
[System.Windows.Forms.SendKeys]::SendWait("pruebas.com")
Start-Sleep -Seconds 2
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Seconds 5
 
$MouseEventSig=@'
[DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
'@
 
$MouseEvent = Add-Type -memberDefinition $MouseEventSig -name "MouseEventWinApi" -passThru
 
[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point(125,192)
$MouseEvent::mouse_event(0x00000002, 0, 0, 0, 0)
$MouseEvent::mouse_event(0x00000004, 0, 0, 0, 0)
#>
