<#
.SYNOPSIS
    This PowerShell script remediates STIG ID WN11-CC-000185 by configuring the default
    AutoRun behavior to prevent autorun commands.

.NOTES
    Author          : Travis Ma
    LinkedIn        : https://www.linkedin.com/in/travis-maa/
    GitHub          : https://github.com/travisma07
    Date Created    : 1/20/2026
    Last Modified   : 1/20/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000185

.DESCRIPTION
    This script configures the registry values corresponding to the Group Policy:

        Computer Configuration >>
        Administrative Templates >>
        Windows Components >>
        AutoPlay Policies >>
        "Turn off AutoPlay"
            Enabled
            Turn off AutoPlay on: All drives

    Registry values configured:

        HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer
            NoAutorun = 1       (DWORD)
            NoDriveTypeAutoRun = 255 (DWORD)

    This disables autorun behavior across all drive types, preventing execution of
    AutoRun-based commands and satisfying DISA STIG WN11-CC-000185.

.TESTED ON
    Date(s) Tested  : 1/20/2026
    Tested By       : Travis Ma
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    Run from an elevated PowerShell session.

    Example:
        PS C:\> .\WN11-CC-000185 - The default autorun behavior must be configured to prevent autorun commands.ps1
#>

# -----------------------------
# Configuration
# -----------------------------
$RegPath  = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
$NoAutorunName        = 'NoAutorun'
$NoDriveTypeAutoRun   = 'NoDriveTypeAutoRun'

# 1 = Prevent autorun
$NoAutorunValue       = 1

# 255 = Disable AutoRun for all drives
$NoDriveTypeValue     = 255

# -----------------------------
# Ensure registry path exists
# -----------------------------
if (-not (Test-Path -Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# -----------------------------
# Create/update registry values
# -----------------------------
New-ItemProperty -Path $RegPath -Name $NoAutorunName      -PropertyType DWord -Value $NoAutorunValue   -Force | Out-Null
New-ItemProperty -Path $RegPath -Name $NoDriveTypeAutoRun -PropertyType DWord -Value $NoDriveTypeValue -Force | Out-Null

Write-Host "STIG WN11-CC-000185 remediated: AutoRun disabled (NoAutorun=1, NoDriveTypeAutoRun=255)."
