Set-MpPreference -DisableIntrusionPreventionSystem $false
Set-MpPreference -DisableIOAVProtection $false
Set-MpPreference -DisableRealtimeMonitoring $false 
Set-MpPreference -DisableScriptScanning $false
Set-MpPreference -EnableControlledFolderAccess Enabled 
Set-MpPreference -EnableNetworkProtection AuditMode -Force 
Set-MpPreference -MAPSReporting Basic
Set-MpPreference -SubmitSamplesConsent SendAllSamples
