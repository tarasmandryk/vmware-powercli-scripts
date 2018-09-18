####################################################################################
# Variables
####################################################################################
$vCenterName = "vspap090.man.cosng.net"

# Read credentials from file
$cred = Get-VICredentialStoreItem -file MyCredentialsFile.xml

# Connect to vCenter Server
Connect-VIServer -server $vCenterName -Protocol https -User $cred.User -Password $cred.Password

#Connect-VIServer -Server $vCenterName -User $Username -Password $Password

Get-VM GFJNSGW001 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:b8:36:9b" } | Set-NetworkAdapter -NetworkName "1041_vSwitch1" -Confirm:$false -RunAsync
Get-VM GFJNSGW001 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:b8:55:4f" } | Set-NetworkAdapter -NetworkName "1045_vSwitch1" -Confirm:$false -RunAsync
Get-VM GFJNSGW001 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:b8:63:51" } | Set-NetworkAdapter -NetworkName "3135_vSwitch1" -Confirm:$false -RunAsync
Get-VM P-114-250-001 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:8e:0c:23" } | Set-NetworkAdapter -NetworkName "3758_vSwitch1" -Confirm:$false -RunAsync
Get-VM P-114-250-001 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:8e:0c:24" } | Set-NetworkAdapter -NetworkName "1409_vSwitch1" -Confirm:$false -RunAsync
Get-VM P-147-270-006 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:8e:0c:33" } | Set-NetworkAdapter -NetworkName "2907_vSwitch1" -Confirm:$false -RunAsync
Get-VM P-147-270-006 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:8e:0c:34" } | Set-NetworkAdapter -NetworkName "3758_vSwitch1" -Confirm:$false -RunAsync
Get-VM SAMAP001 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:8e:1b:4e" } | Set-NetworkAdapter -NetworkName "868_vSwitch1" -Confirm:$false -RunAsync
Get-VM SAMAP001 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:8e:3a:fe" } | Set-NetworkAdapter -NetworkName "3764_vSwitch1" -Confirm:$false -RunAsync


Disconnect-VIServer -Server $vCenterName -confirm:$FALSE

