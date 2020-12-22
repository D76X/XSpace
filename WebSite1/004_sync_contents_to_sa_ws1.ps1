# Data transfer with AzCopy

# azcopy sync
# The last modified times are used for comparison. 
# The file is skipped if the last modified time in the destination is more recent.

# The sync command differs from the copy command in several ways:

# 1-By default, the recursive flag is true 
# 2-sync copies all subdirectories
# 3-Sync only copies the top-level files inside a directory if the recursive flag is false.
# 4-If the 'deleteDestination' flag is set to true or prompt, then sync will delete files and blobs at the destination that are not present at the source.
# 5-When syncing between virtual directories, add a trailing slash to the path (refer to examples) if there's a blob with the same name as one of the virtual directories.

# Refs
# https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10
# https://docs.microsoft.com/en-us/azure/storage/common/storage-ref-azcopy-sync?toc=/azure/storage/blobs/toc.json

# Videos
# https://www.youtube.com/watch?v=K_2yUH2FqaY

# Other Refs
# https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-blobs
# https://docs.microsoft.com/en-us/azure/storage/common/storage-ref-azcopy-copy
# https://github.com/Azure/azure-storage-azcopy/issues/470
# https://github.com/Azure/azure-storage-azcopy/issues/220

# Attain credentials for the current Powershell session by logging to the Azure AD
# tenant for the subscription of the storage accountto to which the content of the local 
# folder must be synced. Then by means of this authentication credentials request a SAS a 
# token in order to access the storage account AD tenant with enough permissions to allow
# the sync to happen. This is an interactive log-in.

Connect-AzureRmAccount -Subscription "Visual Studio Professional with MSDN"

$storageAccountName = "sawebsite120201221"
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



