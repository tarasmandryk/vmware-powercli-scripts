$vCenterName = "vspap090.man.cosng.net"
$Username = "MGMT\E215667"
$Password = "Game0N!2323"

Connect-VIServer -Server $vCenterName -User $Username -Password $Password

Get-VM EIKTS177 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:b8:47:6b" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync
Get-VM EIKTS178 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:b8:2e:64" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync
Get-VM EIKTS008 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:8e:10:0d" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync
Get-VM EIKTS030 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:8e:10:2b" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync
Get-VM EIKTS022 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:8e:10:23" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync
Get-VM EIKTS023 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:8e:10:24" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync
Get-VM EIKTS024 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:8e:10:25" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync
Get-VM EIKTS025 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:8e:10:26" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync
Get-VM EIKTS026 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:8e:10:27" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync
Get-VM EIKTS029 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:8e:10:2a" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync
Get-VM EIKTS921 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:b8:0b:a4" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync
Get-VM EIKTS923 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:b8:72:32" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync
Get-VM EIKTS004 | Get-NetworkAdapter | Where {$_.MacAddress -eq "00:50:56:8e:10:08" } | Set-NetworkAdapter -NetworkName "1930_vSwitch1" -Confirm:$false -RunAsync

Disconnect-VIServer -Server $vCenterName -confirm:$FALSE

