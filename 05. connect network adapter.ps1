####################################################################################
# Variables
####################################################################################
$vCenterName = "vspap090.man.cosng.net"

# Read credentials from file
$cred = Get-VICredentialStoreItem -file MyCredentialsFile.xml

# Connect to vCenter Server
Connect-VIServer -server $vCenterName -Protocol https -User $cred.User -Password $cred.Password

#Connect-VIServer -Server $vCenterName -User $Username -Password $Password

Get-VM EIKTS019 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:b8:33:83" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync
Get-VM EIKTS020 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:b8:78:c7" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync
Get-VM EIKTS052 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:b8:04:6d" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync
Get-VM EIKTS133 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:b8:76:32" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync


Disconnect-VIServer -Server $vCenterName -confirm:$FALSE

