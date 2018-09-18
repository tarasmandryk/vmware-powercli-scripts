####################################################################################
# Variables
####################################################################################
$vCenterName = "vspap090.man.cosng.net"
$ClusterName = "SL_COMPUTE-FS-DEVELOPMENT-01"

####################################################################################
function Drawline {
    for($i=0; $i -lt (get-host).ui.rawui.buffersize.width; $i++) {write-host -nonewline -foregroundcolor cyan "-"}
}
####################################################################################

# Read credentials from file
$cred = Get-VICredentialStoreItem -file MyCredentialsFile.xml

# Connect to vCenter Server
Connect-VIServer -server $vCenterName -Protocol https -User $cred.User -Password $cred.Password -wa 0

Drawline
write-host -foregroundcolor Cyan "VMs with media"
Get-Cluster $ClusterName | Get-VM | Get-CDDrive | select @{N="VM";E="Parent"},IsoPath | where {$_.IsoPath -ne $null}
Drawline
write-host -foregroundcolor Cyan "dismounting media..."
Get-Cluster $ClusterName | Get-VM | Get-CDDrive | where {$_.IsoPath -ne $null} | Set-CDDrive -NoMedia -Confirm:$False
Drawline
write-host -foregroundcolor Cyan "These VMs still have media mounted"
Get-Cluster $ClusterName | Get-VM | Get-CDDrive | select @{N="VM";E="Parent"},IsoPath | where {$_.IsoPath -ne $null}

Disconnect-VIServer -Server $vCenterName -confirm:$FALSE