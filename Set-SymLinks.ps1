#Requires -RunAsAdministrator

#Run in SteamLibrary\steamapps\common\Left 4 Dead 2\sdk_content\mapsrc\l4d2_der_riese
$vscriptPath = Join-Path -Path $PSScriptRoot -ChildPath "../../../left4dead2/scripts/vscripts"

# Remove old files
Get-ChildItem -Path $vscriptPath | Where-Object {
    $_.Mode -eq '-a---l' -and
    (Split-Path -Path $_.Target) -eq (Join-Path -Path $PSScriptRoot -ChildPath "vscripts")
} | Remove-Item -Force

# Remove old directories
Get-ChildItem -Path $vscriptPath -Attributes ReparsePoint | Where-Object {
    $_.Mode -eq 'd----l' -and
    (Split-Path -Path $_.Target) -eq (Join-Path -Path $PSScriptRoot -ChildPath "vscripts")
} | %{$_.Delete()}

Get-ChildItem -Path $PSScriptRoot\vscripts | ForEach-Object {
    $splat = @{
        Path = Join-Path -Path $vscriptPath -ChildPath $_.Name
        ItemType = "SymbolicLink"
        Value = $_.FullName
        Force = $true
    }
    New-Item @splat
}
