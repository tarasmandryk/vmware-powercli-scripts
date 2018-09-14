####################################################################################
# Variables
####################################################################################
$vCenterName = "vspap090.man.cosng.net"
$StagingHost = "ucsesx1068.vmware.cosng.net"
$VMFolder = "Migration"
$Datastores = Get-datastore "Migrate-to-SL-20180907-DS-*"

# Read credentials from file
$cred = Get-VICredentialStoreItem -file MyCredentialsFile.xml

# Connect to vCenter Server
Connect-VIServer -server $vCenterName -Protocol https -User $cred.User -Password $cred.Password

foreach($Datastore in Get-Datastore $Datastores) {
	write "Processing $Datastore"
	# Set up Search for .VMX Files in Datastore
	New-PSDrive -Name TgtDS -Location $Datastore -PSProvider VimDatastore -Root '\' | Out-Null
	$unregistered = @(Get-ChildItem -Path TgtDS: -Recurse | `
		where {$_.FolderPath -notmatch ".snapshot" -and $_.Name -like "*.vmx"})
	Remove-PSDrive -Name TgtDS
 
	#Register all .vmx Files as VMs on the datastore
	foreach($VMXFile in $unregistered) {
		write "Registering VMX-file $VMXFile"
		New-VM -VMFilePath $VMXFile.DatastoreFullPath -VMHost $StagingHost -Location $VMFolder -RunAsync
   }
}

Disconnect-VIServer -Server $vCenterName -confirm:$FALSE