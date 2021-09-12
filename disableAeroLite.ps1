$ErrorActionPreference = 'SilentlyContinue'
$wshell = New-Object -ComObject Wscript.Shell
$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}
cls
$ThemeFolder = "C:\Windows\Resources\Themes"
Start-Process -FilePath "$ThemeFolder\aero.theme"
Start-Sleep -Seconds 2
Remove-Item -Path "$ThemeFolder\aerolite8.theme" -Force | Out-Null
exit