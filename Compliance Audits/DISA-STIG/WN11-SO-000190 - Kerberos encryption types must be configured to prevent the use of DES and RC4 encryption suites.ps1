<#
.SYNOPSIS
    This PowerShell script remediates STIG ID WN11-SO-000190 by configuring Kerberos
    encryption types to prevent the use of DES and RC4 encryption suites.

.NOTES
    Author          : Travis Ma
    LinkedIn        : https://www.linkedin.com/in/travis-maa/
    GitHub          : https://github.com/travisma07
    Date Created    : 1/20/2026
    Last Modified   : 1/20/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000190

.DESCRIPTION
    This script sets the following registry value:

        HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters\SupportedEncryptionTypes = 0x7FFFFFF8 (DWORD)

    This enforces the Security Option policy:

        Computer Configuration >>
        Windows Settings >>
        Security Settings >>
        Local Policies >>
        Security Options >>
        "Network security: Configure encryption types allowed for Kerberos"

    configured as:
        Enabled, with only:
            AES128_HMAC_SHA1
            AES256_HMAC_SHA1
            Future encryption types

    This configuration prevents the use of DES and RC4 encryption suites for Kerberos,
    satisfying DISA STIG WN11-SO-000190.

.TESTED ON
    Date(s) Tested  : 1/20/2026
    Tested By       : Travis Ma
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    Run from an elevated PowerShell session.

    Example:
        PS C:\> .\WN11-SO-000190 - Kerberos encryption types must be configured to prevent the use of DES and RC4 encryption suites.ps1
#>

# NOTE:
#   SupportedEncryptionTypes is a bitmask value. 0x7FFFFFF8 corresponds to enabling
#   AES128, AES256, and future encryption types while excluding DES and RC4.

$RegPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters'
$RegName = 'SupportedEncryptionTypes'
$RegValue = 0x7FFFFFF8 

if (-not (Test-Path -Path $RegPath)){
    New-Item -Path $RegPath -Force | Out-Null
}

New-ItemProperty -Path $RegPath -Name $RegName -PropertyType Dword -Value $RegValue -Force | Out-Null

Write-Host "STIG WN11-SO-000190 remediated: SupportedEncryptionTypes set to ($RegValue)."
