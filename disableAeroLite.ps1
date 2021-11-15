If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}
Clear-Host
$ThemeFolder = "$env:SystemRoot\Resources\Themes"
if(Test-Path "$ThemeFolder\aerolite8.theme"){
    Write-Host "Trying to delete Aero Lite theme file!" -ForegroundColor Green
    Remove-Item -LiteralPath "$ThemeFolder\aerolite8.theme" -Force -ErrorAction SilentlyContinue | Out-Null
    Start-Sleep -Milliseconds 200
    if(Test-Path "$ThemeFolder\aerolite8.theme"){
        Clear-Host
        Write-Host "Couldn't remove Aero Lite theme file..." -ForegroundColor Yellow
        Write-Host "You can do it manually, file is located at `"$ThemeFolder`"" -ForegroundColor Yellow
        Return;
    }
    Write-Host "Aero Lite theme successfuly removed!" -ForegroundColor Green
    Write-Host "Applying default theme..." -ForegroundColor Yellow
    if(!(Test-Path "$ThemeFolder\aero.theme")){
        $DefaultTheme = "@; Copyright � Microsoft Corp.

[Theme]
; Windows - IDS_THEME_DISPLAYNAME_AERO
DisplayName=@%SystemRoot%\System32\themeui.dll,-2013
SetLogonBackground=0

; Computer - SHIDI_SERVER
[CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\DefaultIcon]
DefaultValue=%SystemRoot%\System32\imageres.dll,-109

; UsersFiles - SHIDI_USERFILES
[CLSID\{59031A47-3F72-44A7-89C5-5595FE6B30EE}\DefaultIcon]
DefaultValue=%SystemRoot%\System32\imageres.dll,-123

; Network - SHIDI_MYNETWORK
[CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}\DefaultIcon]
DefaultValue=%SystemRoot%\System32\imageres.dll,-25

; Recycle Bin - SHIDI_RECYCLERFULL SHIDI_RECYCLER
[CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon]
Full=%SystemRoot%\System32\imageres.dll,-54
Empty=%SystemRoot%\System32\imageres.dll,-55

[Control Panel\Cursors]
AppStarting=%SystemRoot%\cursors\aero_working.ani
Arrow=%SystemRoot%\cursors\aero_arrow.cur
Crosshair=
Hand=%SystemRoot%\cursors\aero_link.cur
Help=%SystemRoot%\cursors\aero_helpsel.cur
IBeam=
No=%SystemRoot%\cursors\aero_unavail.cur
NWPen=%SystemRoot%\cursors\aero_pen.cur
SizeAll=%SystemRoot%\cursors\aero_move.cur
SizeNESW=%SystemRoot%\cursors\aero_nesw.cur
SizeNS=%SystemRoot%\cursors\aero_ns.cur
SizeNWSE=%SystemRoot%\cursors\aero_nwse.cur
SizeWE=%SystemRoot%\cursors\aero_ew.cur
UpArrow=%SystemRoot%\cursors\aero_up.cur
Wait=%SystemRoot%\cursors\aero_busy.ani
DefaultValue=Windows Aero
DefaultValue.MUI=@main.cpl,-1020

[Control Panel\Desktop]
Wallpaper=%SystemRoot%\web\wallpaper\Windows\img0.jpg
TileWallpaper=0
WallpaperStyle=10
Pattern=

[VisualStyles]
Path=%ResourceDir%\Themes\Aero\Aero.msstyles
ColorStyle=NormalColor
Size=NormalSize
AutoColorization=1

[boot]
SCRNSAVE.EXE=

[MasterThemeSelector]
MTSM=RJSPBS

[Sounds]
; IDS_SCHEME_DEFAULT
SchemeName=@%SystemRoot%\System32\mmres.dll,-800

@"
        New-Item -Path "$ThemeFolder\aero.theme" -ItemType File -Value $DefaultTheme
    }
    Start-Process -FilePath "$ThemeFolder\aero.theme" -WindowStyle Hidden -ErrorAction SilentlyContinue | Out-Null
    Exit-PSSession
}