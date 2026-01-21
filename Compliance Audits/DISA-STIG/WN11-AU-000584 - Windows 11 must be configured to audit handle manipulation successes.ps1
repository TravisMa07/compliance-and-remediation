<#
.SYNOPSIS
    This PowerShell script remediates STIG ID WN11-AU-000584 by enabling auditing for
    "Handle Manipulation" successes.

.NOTES
    Author          : Travis Ma
    LinkedIn        : https://www.linkedin.com/in/travis-maa/
    GitHub          : https://github.com/travisma07
    Date Created    : 1/20/2026
    Last Modified   : 1/20/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000584

.DESCRIPTION
    This script configures the Advanced Audit Policy setting:

        Category:    Object Access
        Subcategory: Handle Manipulation
        Setting:     Success

    It uses the auditpol.exe tool to set the subcategory to Success, which aligns with
    DISA STIG WN11-AU-000584 and how most SCAP/STIG tools validate the setting.

.TESTED ON
    Date(s) Tested  : 1/20/2026
    Tested By       : Travis Ma
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    Run from an elevated PowerShell session.

    Example:
        PS C:\> .\WN11-AU-000584 - Windows 11 must be configured to audit handle manipulation successes.ps1
#>

$Subcategory = 'Handle Manipulation'


# Enable Success, disable Failure (STIG requires Success; Success+Failure is also acceptable but not required here)
& auditpol.exe /set /subcategory:"$Subcategory" /success:enable /failure:disable | Out-Null

Write-Host "`nSTIG WN11-AU-000584 remediation complete (Handle Manipulation = Success)."
