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

#shut down VMs from the list
foreach ($vmName in $vmList) {
	$vm = Get-VM -Name $vmName
	write "$vmName shutting down guest OS"
	Shutdown-VMGuest -VM $vm -Confirm:$false
}

start-sleep -s 30

foreach ($vmName in $vmList) {
	get-vm -Name $vmName | new-snapshot -name VirtualHWupgrade -Description "Created $(Get-Date)" -Confirm:$false
	write "$vmName creating VM snapshot"
}

start-sleep -s 30

foreach ($vmName in $vmList) {
	Set-VM -VM $vmName -Version v11
	write "$vmName upgrading virtual hardware"
	Start-VM $vmName -Confirm:$false
	write "$vmName starting VM"
}

Disconnect-VIServer -Server $vCenterName -confirm:$FALSE