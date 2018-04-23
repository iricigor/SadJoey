$ModName = 'SadJoey'
Get-Module $ModName | Remove-Module -Force

Write-Host "`n`n$ModName module import starting`n" -ForegroundColor Cyan


#
# Import main functions
#

$Private = @(Get-ChildItem (Join-Path $PSScriptRoot 'Private') -Filter *.ps1)
$Public = @(Get-ChildItem (Join-Path $PSScriptRoot 'Public') -Filter *.ps1)

foreach ($F in ($Private+$Public) ) {

    Write-Host ("Importing $($F.Name)... ") -NoNewline
    
    try {
        . ($F.FullName)
        Write-Host '  OK  ' -ForegroundColor Green
    } catch {
        Write-Host 'FAILED' -ForegroundColor Red
    }
}

$Public | % {Export-ModuleMember -Function $F.BaseName}
Write-Host "Exported $($Public.Count) member(s)"
Export-ModuleMember -Alias *


Write-Host "`nType 'Get-Command -Module $ModName' for list of commands, 'Get-Help <CommandName>' for help, or"
Write-Host "'Get-Command -Module $ModName | Get-Help | Select Name, Synopsis' for explanation on all commands`n"

if (!$Key1) {
    $Global:Key1 = Read-Host "Please enter application key here"
}