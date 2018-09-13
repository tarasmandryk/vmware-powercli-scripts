####################################################################################
# Variables
####################################################################################

# Read credentials from file
$cred = Get-VICredentialStoreItem -file MyCredentialsFile.xml
# Read VMs list from file vm_list.csv
$vmList = Get-Content vm_list.csv
# Read vCS list from file vCenterServers_list.csv
$vCSsList = Get-Content vCenterServers_list.csv

# Connect to all vCenter Servers from the list
foreach ($vc in $vCSsList) 
{     
	if( Connect-VIServer -server $vc -Protocol https -User $cred.User -Password $cred.Password -ErrorAction Ignore)
	{        
		Write-Host "vCenter $vc Connected"  -ForegroundColor Cyan     
	}
	else
	{
		Write-Host "Failed to Connect vCenter $vc"  -ForegroundColor Cyan
	}    
}

foreach ($vmName in $vmList) {
    $vm = Get-VM -Name $vmName
    if($vm.Guest.State -eq "Running"){
        write "$vmName - shuting down guest OS"
		Shutdown-VMGuest -VM $vm -Confirm:$false
		write $vm.Guest.State
    }
#    else{
#		write "$vmName - powering off VM"
#		Stop-VM -VM $vm -Confirm:$false
#		write "$vmName - $vm.Guest.State"
#    }
}

#Disconnect from all vCenter Servers
foreach ($vc in $vCSsList) 
{     
	Disconnect-VIServer -Server $vc -confirm:$FALSE   
}