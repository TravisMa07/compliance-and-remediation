<#
.SYNOPSIS
    This PowerShell script remediates STIG ID WN11-CC-000110 by disabling printing over HTTP.

.NOTES
    Author          : Travis Ma
    LinkedIn        : https://www.linkedin.com/in/travis-maa/
    GitHub          : https://github.com/travisma07
    Date Created    : 1/20/2026
    Last Modified   : 1/20/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000110

.DESCRIPTION
    This script sets the following registry value:

        HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\DisableHTTPPrinting = 1 (DWORD)

    This enforces:
        Disabling printing over HTTP on Windows 11 systems, as required by DISA STIG
        WN11-CC-000110, to reduce the attack surface related to HTTP-based printing.

.TESTED ON
    Date(s) Tested  : 1/20/2026
    Tested By       : Travis Ma
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    Run from an elevated PowerShell session.

    Example:
        PS C:\> .\WN11-CC-000110 - Printing over HTTP must be prevented.ps1
#>

$RegPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers'
$RegName = 'DisableHTTPPrinting'
$RegValue = 1

if (-not (Test-Path -Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

New-ItemProperty -Path $RegPath -Name $RegName -PropertyType DWord -Value $RegValue -Force | Out-Null

Write-Host "STIG WN11-CC-000110 remediated: Printing over HTTP disabled (DisableHTTPPrinting = $RegValue)."
