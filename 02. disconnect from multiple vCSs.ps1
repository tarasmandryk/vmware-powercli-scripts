####################################################################################
# Variables
####################################################################################
#Read vCS list from the file vCenterServers_list.csv
$vCSsList = Get-Content vCenterServers_list.csv

foreach ($vc in $vCSsList) 
{     
	Disconnect-VIServer -Server $vc -confirm:$FALSE   
}