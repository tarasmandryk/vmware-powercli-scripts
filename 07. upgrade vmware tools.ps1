####################################################################################
# Variables
####################################################################################
$vCenterName = "vspap090.man.cosng.net"

# Read credentials from file
$cred = Get-VICredentialStoreItem -file MyCredentialsFile.xml

# Connect to vCenter Server
Connect-VIServer -server $vCenterName -Protocol https -User $cred.User -Password $cred.Password -wa 0

#Read VMs list from file vm_list.csv
$vmList = Get-Content vm_list.csv

foreach ($vmName in $vmList) {
	Write-Host "Updating VMware Tools on $vmName"
	#Update VMware tools with rebooting the VM
	Update-Tools $vmName -RunAsync
	#Update VMware tools without rebooting the VM
	#Update-Tools $vm -NoReboot
}

Disconnect-VIServer -Server $vCenterName -confirm:$FALSE