<#
.SYNOPSIS
    This PowerShell script blocks Windows from downloading updates from other PCs on the internet, but only from trusted sources (Directly from Microsoft). Windows Update can obtain updates from additional sources instead of Microsoft, but to minimize outside exposure, obtaining updates from or sending to systems on the Internet must be prevented.

.NOTES
    Author          : Wilson Arteaga
    LinkedIn        : linkedin.com/in/wilson-arteaga-v/
    GitHub          : github.com/art-wiju
    Date Created    : 2025-04-25
    Last Modified   : 2025-04-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN19-CC-000260

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

# Define the registry path and value name
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization"
$valueName = "DODownloadMode"

# Check if the registry path exists
if (-not (Test-Path -Path $registryPath)) {
    Write-Host "Registry path does not exist. Creating the registry path."
    New-Item -Path $registryPath -Force
}

# Check if the registry value exists
if (Test-Path -Path "$registryPath\$valueName") {
    # Get the current value
    $currentValue = Get-ItemProperty -Path $registryPath -Name $valueName | Select-Object -ExpandProperty $valueName
    
    # Verify if the current value is 0x00000003 (3)
    if ($currentValue -eq 3) {
        Write-Host "Current value is 0x00000003 (3), which is a finding. Updating to 0x00000000 (0)."
        
        # Set the value to 0x00000000 (0)
        Set-ItemProperty -Path $registryPath -Name $valueName -Value 0
        
        Write-Host "Registry value updated to 0x00000000 (0)."
    } else {
        Write-Host "Current value is $currentValue. No update needed."
    }
} else {
    Write-Host "Registry value does not exist. Creating and setting it to 0x00000000 (0)."
    
    # Create the registry value and set it to 0x00000000 (0)
    New-ItemProperty -Path $registryPath -Name $valueName -Value 0 -PropertyType DWORD
    
    Write-Host "Registry value created and set to 0x00000000 (0)."
}
