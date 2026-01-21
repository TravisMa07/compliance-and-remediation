<#
.SYNOPSIS
    This PowerShell script remediates STIG ID WN11-AC-000010 by configuring the
    maximum allowed bad logon attempts to three.

.NOTES
    Author          : Travis Ma
    LinkedIn        : https://www.linkedin.com/in/travis-maa/
    GitHub          : https://github.com/travisma07
    Date Created    : 1/20/2026
    Last Modified   : 1/20/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000010

.DESCRIPTION
    This script configures the local Account Lockout Policy equivalent to:

        Computer Configuration >>
        Windows Settings >>
        Security Settings >>
        Account Policies >>
        Account Lockout Policy >>
        "Account lockout threshold" = 3 invalid logon attempts

    It uses the built-in 'net accounts' command to set the lockout threshold,
    which is how most STIG/SCAP tools validate local password and lockout policy.

    Setting the account lockout threshold to 3 helps reduce the risk of
    brute-force password attacks and satisfies DISA STIG WN11-AC-000010.

.TESTED ON
    Date(s) Tested  : 1/20/2026
    Tested By       : Travis Ma
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    Run from an elevated PowerShell session.

    Example:
        PS C:\> .\WN11-AC-000010 - The number of allowed bad logon attempts must be configured to three or less.ps1
#>

$MaxBadLogonAttempts = 3  # STIG requires 3 or fewer

Write-Host "Configuring account lockout threshold to $MaxBadLogonAttempts invalid logon attempts..."

# 'net accounts' updates the local security policy for lockout threshold
& net accounts /lockoutthreshold:$MaxBadLogonAttempts | Out-Null


Write-Host "`nCurrent account policy:"
& net accounts

Write-Host "STIG WN11-AC-000010 remediation completed."
