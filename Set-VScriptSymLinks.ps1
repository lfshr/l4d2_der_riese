#Requires -RunAsAdministrator

#worksonmymachine tm
$vscriptPath = "D:\SteamLibrary\steamapps\common\left 4 dead 2\left4dead2\scripts\vscripts"

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
