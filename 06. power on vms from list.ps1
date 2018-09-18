####################################################################################
# Variables
####################################################################################
$vCenterName = "vspap090.man.cosng.net"

# Read credentials from file
$cred = Get-VICredentialStoreItem -file MyCredentialsFile.xml

# Connect to vCenter Server
Connect-VIServer -server $vCenterName -Protocol https -User $cred.User -Password $cred.Password

#Read VMs list from file vm_list.csv
$vmList = Get-Content vm_list.csv

foreach ($vmName in $vmList) {
	Get-VM $vmName | where {$_.status -eq "powered off"}
	Start-VM $vmName -Confirm:$false
	Write-Host "$vmName is starting"
	start-sleep -s 2
	Get-VM $vmName | Get-VMQuestion | Set-VMQuestion -Option button.uuid.movedTheVM -Confirm:$false
	Write-Host "$vmName - option _i moved it_ has been selected"
}

Disconnect-VIServer -Server $vCenterName -confirm:$FALSE