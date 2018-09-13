####################################################################################
# Variables
####################################################################################
#Read vCS list from the file vCenterServers_list.csv
$vCSsList = Get-Content vCenterServers_list.csv
$cred = Get-VICredentialStoreItem -file MyCredentialsFile.xml

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