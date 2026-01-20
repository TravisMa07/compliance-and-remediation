<#
.SYNOPSIS
    This PowerShell script remediates STIG ID WN11-AU-000150 by enabling auditing for
    "Security System Extension" successes.

.NOTES
    Author          : Travis Ma
    LinkedIn        : https://www.linkedin.com/in/travis-maa/
    GitHub          : https://github.com/travisma07
    Date Created    : 1/20/2026
    Last Modified   : 1/20/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000150

.DESCRIPTION
    This script sets the following registry value:

        HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit\SecuritySystemExtension = 1 (DWORD)

    This enforces:
        Advanced Audit Policy setting:
            Category: System
            Subcategory: Security System Extension
            Setting: Success

        This ensures auditing is generated for security system processes and components that
        extend or modify the system’s authentication or authorization capabilities, satisfying
        DISA STIG WN11-AU-000150.

.TESTED ON
    Date(s) Tested  : 1/20/2026
    Tested By       : Travis Ma
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    Run from an elevated PowerShell session.

    Example:
        PS C:\> .\WN11-AU-000150 - Audit Security System Extension Success.ps1
#>

$RegPath = 'HKLM:\SOFTWARE\Microsoft\WIndows\CurrentVersion\Policies\System\Audit'
$RegName = 'SecuritySystemExtension'
$RegValue = 1   # 1 = Success Auditing

if (-not (Test-Path -Path $RegPath)){
    New-Item -Path $RegPath -Force | Out-Null
}

New-ItemProperty -Path $RegPath -Name $RegName -PropertyType Dword -Value $RegValue -Force | Out-Null

Write-Host "STIG WN11-AU-000150 remediated: Security System Extension auditing set to Success (Value=$RegValue)."
