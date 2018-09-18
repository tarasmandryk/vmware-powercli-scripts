####################################################################################
# Variables
####################################################################################
$vCenterName = "vspap090.man.cosng.net"
$outputfile = "hwvirtualization-report.csv"


# Read credentials from file
$cred = Get-VICredentialStoreItem -file MyCredentialsFile.xml

# Connect to vCenter Server
Connect-VIServer -server $vCenterName -Protocol https -User $cred.User -Password $cred.Password -wa 0

Get-VM -Server $vCenterName |
where {$_.ExtensionData.Config.NestedHVEnabled -eq $TRUE} |
Select Name,PowerState |
Export-Csv $outputfile -noTypeInformation -UseCulture

Disconnect-VIServer -Server $vCenterName -confirm:$FALSE