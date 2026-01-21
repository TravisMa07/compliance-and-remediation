<#
.SYNOPSIS
    This PowerShell script remediates STIG ID WN11-CC-000285 by requiring secure
    RPC communications for Remote Desktop Session Host.

.NOTES
    Author          : Travis Ma
    LinkedIn        : https://www.linkedin.com/in/travis-maa/
    GitHub          : https://github.com/travisma07
    Date Created    : 1/20/2026
    Last Modified   : 1/20/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000285

.DESCRIPTION
    This script configures the registry value corresponding to the Group Policy:

        Computer Configuration >>
        Administrative Templates >>
        Windows Components >>
        Remote Desktop Services >>
        Remote Desktop Session Host >>
        Security >>
        "Require secure RPC communication"

    Registry value configured:

        HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services
            fEncryptRPCTraffic (DWORD) = 1

    Setting fEncryptRPCTraffic to 1 forces Remote Desktop Session Host to use
    secure RPC communications, helping protect RDP traffic from downgrade or
    tampering and satisfying DISA STIG WN11-CC-000285.

.TESTED ON
    Date(s) Tested  : 1/20/2026
    Tested By       : Travis Ma
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    Run from an elevated PowerShell session.

    Example:
        PS C:\> .\WN11-CC-000285 - The Remote Desktop Session Host must require secure RPC communications.ps1
#>

$RegPath  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
$RegName  = 'fEncryptRPCTraffic'
$RegValue = 1    # 1 = Require secure RPC communication


if (-not (Test-Path -Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

New-ItemProperty -Path $RegPath -Name $RegName -PropertyType DWord -Value $RegValue -Force | Out-Null

Write-Host "STIG WN11-CC-000285 remediated: fEncryptRPCTraffic set to $RegValue (Require secure RPC communication)."
