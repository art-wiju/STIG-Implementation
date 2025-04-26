<#
.SYNOPSIS
    This PowerShell script changes the name on the guest account. The built-in guest account is a well-known user account on all Windows systems and, as initially installed, does not require a password. This can allow access to system resources by unauthorized users. Renaming this account to an unidentified name improves the protection of this account and the system.

.NOTES
    Author          : Wilson Arteaga
    LinkedIn        : linkedin.com/in/wilson-arteaga-v/
    GitHub          : github.com/art-wiju
    Date Created    : 2025-04-25
    Last Modified   : 2025-04-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN19-SO-000040

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

# Define the new name for the Guest account
$newGuestName = "NotGuest"

# Get the SID for the Guest account
$guestSID = (Get-WmiObject -Class Win32_UserAccount -Filter "Name='Guest'").SID

# Rename the Guest account
Rename-LocalUser -SID $guestSID -NewName $newGuestName

# Verify the change
$updatedGuestName = (Get-WmiObject -Class Win32_UserAccount -Filter "SID='$guestSID'").Name

if ($updatedGuestName -eq $newGuestName) {
    Write-Host "Guest account successfully renamed to $newGuestName."
} else {
    Write-Host "Failed to rename Guest account."
}
