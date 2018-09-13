param(
	[parameter(Mandatory = $true)]
	$HostName
)
$cred = Get-Credential 
New-VICredentialStoreItem -Host $HostName -User $cred.UserName -Password $cred.GetNetworkCredential().password -file MyCredentialsFile.xml

####################################################################################
# Alternative approach
# This will save clear-text username and encrypted password in xml file
####################################################################################
#Get-Credential | Export-CliXml  -Path MyCredential.xml