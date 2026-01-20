<#
.SYNOPSIS
    This PowerShell script remediates STIG ID WN11-CC-000315 by disabling elevated privilege MSI installations.

.NOTES
    Author          : Travis Ma
    LinkedIn        : https://www.linkedin.com/in/travis-maa/
    GitHub          : https://github.com/travisma07
    Date Created    : 1/20/2026
    Last Modified   : 1/20/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315

.DESCRIPTION
    This script sets the following registry value:

        HKLM\Software\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated = 0 (DWORD)

    This enforces:
        Disables the Windows Installer feature "Always install with elevated privileges"
        to prevent privilege escalation and satisfy DISA STIG WN11-CC-000315.

.TESTED ON
    Date(s) Tested  : 1/20/2026
    Tested By       : Travis Ma
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    Run from an elevated PowerShell session.

    Example:
        PS C:\> .\WN11-CC-000315 - Always install with elevated privileges must be disabled.ps1
#>

$RegPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer'
$RegName = 'AlwaysInstallElevated'
$RegValue = 0

if (-not (Test-Path -Path $RegPath)){
    New-Item -Path $RegPath -FOrce | Out-Null
}

New-ItemProperty -Path $RegPath -Name $RegName -PropertyType DWord -Value $RegValue -Force | Out-Null

Write-Host "STIG WN11-CC-000315 remediated: AlwaysInstallElevated set to $RegValue."
