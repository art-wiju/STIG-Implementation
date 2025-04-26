<#
.SYNOPSIS
    This PowerShell script set the minimum password length to 14 characters via the local group policy editor. Weak-short passwords provide the opportunity for anyone to crack the password, thus gaining access to the system and compromising the device, information, or the local network.

.NOTES
    Author          : Wilson Arteaga
    LinkedIn        : linkedin.com/in/wilson-arteaga-v/
    GitHub          : github.com/art-wiju
    Date Created    : 2025-04-25
    Last Modified   : 2025-04-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN19-AC-000070

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

# Check the current minimum password length
$currentLength = (net accounts | Select-String "Minimum password length").Line.Split(":")[1].Trim()

# Verify if the current length is less than 14
if ($currentLength -lt 14) {
    Write-Host "Current minimum password length is $currentLength. Updating to 14 characters."
    
    # Set the minimum password length to 14
    net accounts /minpwlen:14
    
    Write-Host "Minimum password length updated to 14 characters."
} else {
    Write-Host "Current minimum password length is $currentLength. No update needed."
}
