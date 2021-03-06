####################################################################################
# Variables
####################################################################################
$vCenterName = "vspap090.man.cosng.net"
$StagingHost = "ucsesx1068.vmware.cosng.net"

# Read credentials from file
$cred = Get-VICredentialStoreItem -file MyCredentialsFile.xml

# Connect to vCenter Server
Connect-VIServer -server $vCenterName -Protocol https -User $cred.User -Password $cred.Password

Get-VMHostStorage -VMHost $StagingHost -RescanAllHba -RescanVmfs

#Disconnect from vCenter Server
Disconnect-VIServer -Server $vCenterName -confirm:$FALSE