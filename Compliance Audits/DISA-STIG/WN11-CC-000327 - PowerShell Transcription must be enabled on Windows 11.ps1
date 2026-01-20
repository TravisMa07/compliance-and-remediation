<#
.SYNOPSIS
    This PowerShell script remediates STIG ID WN11-CC-000327 by enabling
    PowerShell Transcription on Windows 11.

.NOTES
    Author          : Travis Ma
    LinkedIn        : https://www.linkedin.com/in/travis-maa/
    GitHub          : https://github.com/travisma07
    Date Created    : 1/20/2026
    Last Modified   : 1/20/2026
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000327

.DESCRIPTION
    This script configures the registry values corresponding to the Group Policy:

        Computer Configuration >>
        Administrative Templates >>
        Windows Components >>
        Windows PowerShell >>
        "Turn on PowerShell Transcription"

    It enables script block transcription and sets a transcript output directory so
    that PowerShell commands and scripts executed on the system are recorded,
    satisfying DISA STIG WN11-CC-000327.

    Registry values configured:

        HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription
            EnableTranscripting   (DWORD) = 1
            EnableInvocationHeader (DWORD) = 1
            OutputDirectory       (STRING) = C:\Logs\PowerShellTranscripts

.TESTED ON
    Date(s) Tested  : 1/20/2026
    Tested By       : Travis Ma
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1

.USAGE
    Run from an elevated PowerShell session.

    Example:
        PS C:\> .\WN11-CC-000327 - PowerShell Transcription must be enabled on Windows 11.ps1
#>

# Correct registry path for the GPO-equivalent setting
$RegPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription'

$EnableTranscriptName = 'EnableTranscripting'
$EnableHeaderName     = 'EnableInvocationHeader'
$OutputDirectoryName  = 'OutputDirectory'

# Change this path as appropriate for your environment where you store these logs
$TranscriptPath = 'C:\Logs\PowerShellTranscripts'

if (-not (Test-Path -Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

if (-not (Test-Path -Path $TranscriptPath)) {
    New-Item -Path $TranscriptPath -ItemType Directory -Force | Out-Null
}


New-ItemProperty -Path $RegPath -Name $EnableTranscriptName -PropertyType DWord  -Value 1              -Force | Out-Null
New-ItemProperty -Path $RegPath -Name $EnableHeaderName     -PropertyType DWord  -Value 1              -Force | Out-Null
New-ItemProperty -Path $RegPath -Name $OutputDirectoryName  -PropertyType String -Value $TranscriptPath -Force | Out-Null

Write-Host "STIG WN11-CC-000327 remediated: PowerShell Transcription enabled. OutputDirectory = $TranscriptPath."

