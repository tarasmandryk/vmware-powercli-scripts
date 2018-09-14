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

# Retrieve VM's info and save in a list
foreach ($vmName in $vmList) {
	$vminfo = "" | Select VM_Name, vCS_Name, Cluster, Datastore, PortGroup, MAC, Folder, ToolsStatus, ResourcePool
	$VM = Get-VM $vmName
	$NetworkAdapters = Get-NetworkAdapter -vm $VM
	$VMvCS = $VM.Uid.Substring($vm.Uid.IndexOf('@')+1).Split(":")[0]
	$VMHost = Get-VMHost -VM $vmName
	$VMCluster = get-cluster -VM $vmName
	$VMDatastore = Get-Datastore -Id $VM.DatastoreIdList
	$VMPortGroup = $NetworkAdapters.NetworkName -join '|'
	$VMMACs = $NetworkAdapters.MacAddress -join '|'
	$VMFolder = $VM.Folder.Name
	$VMToolsStatus = $VM.ExtensionData.Guest.ToolsStatus
	$VMResourcePool = $VM.ResourcePool.Name
	
	$vminfo.VM_Name = $VM.Name
	$vminfo.vCS_Name = $VMvCS
	$vminfo.Cluster = $VMCluster.Name
	$vminfo.Datastore = $VMDatastore.Name
	$vminfo.PortGroup = $VMPortGroup
	$vminfo.MAC = $VMMACs
	$vminfo.Folder = $VMFolder
	$vminfo.ToolsStatus = $VMToolsStatus
	$vminfo.ResourcePool = $VMResourcePool
	
	$allvminfo += $vminfo

}

#Output data to file
$allvminfo | Select VM_Name, vCS_Name, Cluster, Datastore, PortGroup, MAC, Folder, ToolsStatus, ResourcePool | Export-Csv $outputfile -noTypeInformation

#Disconnect from all vCenter Servers
foreach ($vc in $vCSsList) 
{     
	Disconnect-VIServer -Server $vc -confirm:$FALSE   
}