#Requires -RunAsAdministrator

$reg = Get-Item -Path 'HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache'
$l4d = $reg.Property | Where-Object {$_ -like '*left4dead2.exe*'}

if(-not $l4d)
{
    throw "Could not find Left 4 Dead 2"
}

$path = Split-Path $l4dValue

$addonPath = Join-Path -Path $path -ChildPath "left4dead2/addons"
$targetPath = Join-Path -Path $PSScriptRoot -ChildPath 'src'

$splat = @{
    Path = Join-Path -Path $addonPath -ChildPath "l4d2_der_riese"
    ItemType = "SymbolicLink"
    Value = $targetPath
    Force = $true
}
New-Item @splat