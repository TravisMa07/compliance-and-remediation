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
    This script configures the Advanced Audit Policy setting:

        Category:    System
        Subcategory: Security System Extension
        Setting:     Success

    It uses the auditpol.exe tool to set the subcategory to Success, which aligns with
    DISA STIG WN11-AU-000150 and how most SCAP/STIG tools validate the setting.

.TESTED ON
    Date(s) Tested  : 1/20/2026
    Tested By       : Travis Ma
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    Run from an elevated PowerShell session.

    Example:
        PS C:\> .\WN11-AU-000150 - The system must be configured to audit System - Security System Extension successes.ps1
#>

# -----------------------------
# Configuration
# -----------------------------
$Subcategory = 'Security System Extension'

# -----------------------------
# Set audit policy (Success only)
# -----------------------------
Write-Host "Configuring Advanced Audit Policy for '$Subcategory' to: Success..."

# Enable Success, disable Failure (STIG requires Success; Success+Failure would also be acceptable)
& auditpol.exe /set /subcategory:"$Subcategory" /success:enable /failure:disable | Out-Null

# -----------------------------
# Optional: Verify current setting
# -----------------------------
Write-Host "`nCurrent effective setting for '$Subcategory':"
& auditpol.exe /get /subcategory:"$Subcategory"

Write-Host "`nSTIG WN11-AU-000150 remediation complete (Security System Extension = Success)."
