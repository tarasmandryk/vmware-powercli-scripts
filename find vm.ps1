# Before executing this script run "01. connect to multiple vCSs.ps1"
####################################################################################
# Variables
####################################################################################

$vmList = Get-Content vm_list.csv
$outputfile = "vm-report.csv"
#Array for VMs' data
$allvminfo = @()

####################################################################################
function Drawline {
    for($i=0; $i -lt (get-host).ui.rawui.buffersize.width; $i++) {write-host -nonewline -foregroundcolor cyan "-"}
}
####################################################################################

Drawline

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