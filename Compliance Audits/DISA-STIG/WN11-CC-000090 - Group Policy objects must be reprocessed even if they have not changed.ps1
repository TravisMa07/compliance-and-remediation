<#
.SYNOPSIS
    This PowerShell script remediates STIG ID WN11-CC-000090 by ensuring Group Policy
    objects are reprocessed even if they have not changed.

.NOTES
    Author          : Travis Ma
    LinkedIn        : https://www.linkedin.com/in/travis-maa/
    GitHub          : https://github.com/travisma07
    Date Created    : 1/20/2026
    Last Modified   : 1/20/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000090

.DESCRIPTION
    This script sets the following registry value:

        HKLM\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}\NoGPOListChanges = 0 (DWORD)

    This enforces:
        Computer Configuration >>
        Administrative Templates >>
        System >>
        Group Policy >>
        "Configure registry policy processing"
        set to "Enabled" with
        "Process even if the Group Policy objects have not changed" checked.

        With NoGPOListChanges = 0, registry-related Group Policy settings are
        re-applied at each processing cycle, overwriting any unauthorized changes
        and keeping the system aligned with domain Group Policy.

    NOTE:
        {35378EAC-683F-11D2-A89A-00C04FBBCFA2} is the GUID for the Registry Client-Side Extension (CSE).
        This CSE handles registry-based Group Policy processing. Setting NoGPOListChanges = 0 forces
        registry policies to reprocess even if no changes are detected, ensuring GPO enforcement.


.TESTED ON
    Date(s) Tested  : 1/20/2026
    Tested By       : Travis Ma
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    Run from an elevated PowerShell session.

    Example:
        PS C:\> .\WN11-CC-000090 - Group Policy objects must be reprocessed even if they have not changed.ps1
#>

$RegPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}'
$RegName = 'NoGPOListChanges'
$RegValue = 0

if (-not (Test-Path -Path $RegPath)){
   New-Item -Path $RegPath -Force | Out-Null
}

New-ItemProperty -Path $RegPath -Name $RegName -PropertyType Dword -Value $RegValue -Force | Out-Null

Write-Host "STIG WN11-CC-000090 remediated: NoGPOListChanges set to $RegValue (GPOs reprocessed even if unchanged.)"
