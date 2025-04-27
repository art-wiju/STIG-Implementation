<#
.SYNOPSIS
    This PowerShell script configures Windows Server 2019 to audit Account Logon - Credential Validation Failures. Maintaining an audit trail of system activity logs can help identify configuration errors, troubleshoot service disruptions, and analyze compromises that have occurred, as well as detect attacks. Collecting this data is essential for analyzing the security of information assets and detecting signs of suspicious and unexpected behavior.

Credential Validation records events related to validation tests on credentials for a user account logon.

You would think that this is already enabled in Windows by default...

.NOTES
    Author          : Wilson Arteaga
    LinkedIn        : linkedin.com/in/wilson-arteaga-v/
    GitHub          : github.com/art-wiju
    Date Created    : 2025-04-25
    Last Modified   : 2025-04-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN19-AU-000080

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

# Ensure the script runs with elevated privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "This script must be run as Administrator. Exiting."
    exit 1
}

# 1. Set the registry key to force subcategory audit policy override
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$regName = "SCENoApplyLegacyAuditPolicy"
$desiredValue = 1

Write-Host "Enabling subcategory audit policy override..."
New-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -PropertyType DWord -Force | Out-Null
Write-Host "Subcategory audit override enabled successfully."

# 2. Enable auditing for Credential Validation (Failure)
Write-Host "Enabling 'Credential Validation - Failure' auditing..."
$auditCommand = 'auditpol /set /subcategory:"Credential Validation" /failure:enable'
Invoke-Expression $auditCommand

Write-Host "`nAll audit settings have been configured successfully."

