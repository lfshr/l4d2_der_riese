#Requires -RunAsAdministrator

#worksonmymachine tm
$addonPath = Join-Path -Path $PSScriptRoot -ChildPath "../../../left4dead2/addons"
$targetPath = Join-Path -Path $PSScriptRoot -ChildPath 'src'

$splat = @{
    Path = Join-Path -Path $addonPath -ChildPath "l4d2_der_riese"
    ItemType = "SymbolicLink"
    Value = $targetPath
    Force = $true
}
New-Item @splat