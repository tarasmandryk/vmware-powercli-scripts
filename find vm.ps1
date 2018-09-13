####################################################################################
# Variables
####################################################################################

# Read credentials from file
$cred = Get-VICredentialStoreItem -file MyCredentialsFile.xml
# Read VMs list from file vm_list.csv
$vmList = Get-Content vm_list.csv
# Read vCS list from file vCenterServers_list.csv
$vCSsList = Get-Content vCenterServers_list.csv
# Report will be output here
$outputfile = "vm-report.csv"
# Array for VMs' data
$allvminfo = @()

####################################################################################
function Drawline {
    for($i=0; $i -lt (get-host).ui.rawui.buffersize.width; $i++) {write-host -nonewline -foregroundcolor cyan "-"}
}
####################################################################################

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

Drawline

# Get info for each VM from the list
foreach ($vmName in $vmList) 
{
	$vminfo = "" | Select VM_Name, vCS_Name, Cluster
	$VM = Get-VM $vmName
	$VMvCS = $VM.Uid.Substring($vm.Uid.IndexOf('@')+1).Split(":")[0] 
	$VMCluster = get-cluster -VM $vmName
	
	$vminfo.VM_Name = $VM.Name
	$vminfo.vCS_Name = $VMvCS
	$vminfo.Cluster = $VMCluster.Name
	
	$allvminfo += $vminfo
	
	write-host -foregroundcolor Cyan "$vmName is now running on "
	write-host -foregroundcolor Cyan "	vCS: $VMvCS"
	write-host -foregroundcolor Cyan "	cluster: $VMCluster.Name"
	
	Drawline
}

#Output data to file
$allvminfo | Select VM_Name, vCS_Name, Cluster | Export-Csv $outputfile -noTypeInformation

#Disconnect from all vCenter Servers
foreach ($vc in $vCSsList) 
{     
	Disconnect-VIServer -Server $vc -confirm:$FALSE   
}