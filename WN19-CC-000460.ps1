<#
.SYNOPSIS
    This PowerShell script enables script block logging for PowerShell. Enabling PowerShell script block logging will record detailed information from the processing of PowerShell commands and scripts. This can provide additional detail when malware has run on a system.

.NOTES
    Author          : Wilson Arteaga
    LinkedIn        : linkedin.com/in/wilson-arteaga-v/
    GitHub          : github.com/art-wiju
    Date Created    : 2025-04-25
    Last Modified   : 2025-04-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN19-CC-000460

.TESTED ON
    Date(s) Tested  : 2025-04-25
    Tested By       : Wilson Arteaga
    Systems Tested  : Windows Server 2019 Datacenter
    PowerShell Ver. : 5.1.17763.7240

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
$valueName = "EnableScriptBlockLogging"
$valueData = 1

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Set the registry value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

Write-Output "Registry key and value have been set successfully."

