# Data transfer with AzCopy

# This is the version of the script sync_contents_to_sa_ws1.ps1
# that does not require any interactive login. The script makes
# use of a Service Principal registered in the Azure AD tenant 
# of the SA with which the local content is synched and a 
# corresponding application registered in the same Azure AD tenant 
# with the same Service Principal.

Refs

Connect-AzureRmAccount -Subscription "Visual Studio Professional with MSDN"

$storageAccountName = "sawebsite120200103"
$resourceGroup = "rg-WebSite1" # resource group of the website
$storKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $resourceGroup -Name $storageAccountName).Value[0]
$storContext = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storKey
$sasToken = New-AzureStorageAccountSASToken -Service Blob -ResourceType Service,Container,Object -Permission "rwdlaup" -Protocol HttpsOnly -Context $storContext
$scriptPath=Get-Location
$sourcePath = "${scriptPath}\Contents"
$containerName = '$web' # notice the '' to store the value as a literal!
$destinationPath = "https://${storageAccountName}.blob.core.windows.net/${containerName}/${sasToken}"
# notice that recursive is on by default
C:\"Program Files"\AzCopy\azcopy.exe sync $sourcePath  $destinationPath --put-md5 --recursive=false




