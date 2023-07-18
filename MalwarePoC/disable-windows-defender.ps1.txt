
Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" -Name "DisableEnhancedNotifications" -Type DWord  -Value 1 
Set-MpPreference -EnableControlledFolderAccess Disabled
Set-MpPreference -DisableIntrusionPreventionSystem $true 
Set-MpPreference -DisableIOAVProtection $true 
Set-MpPreference -DisableRealtimeMonitoring $true 
Set-MpPreference -DisableScriptScanning $true 
Set-MpPreference -EnableControlledFolderAccess Disabled 
Set-MpPreference -EnableNetworkProtection AuditMode -Force 
Set-MpPreference -MAPSReporting Disabled
Set-MpPreference -SubmitSamplesConsent NeverSend
