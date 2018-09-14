#Read vCS list from the file vCenterServers_list.csv
$vCSsList = Get-Content vCenterServers_list.csv
$cred = Get-VICredentialStoreItem -file MyCredentialsFile.xml
$StagingHost = "ucsesx1068.vmware.cosng.net"

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

Get-VMHostStorage -VMHost $StagingHost -RescanAllHba -RescanVmfs

#Disconnect from all vCenter Servers
foreach ($vc in $vCSsList) 
{     
	Disconnect-VIServer -Server $vc -confirm:$FALSE   
}