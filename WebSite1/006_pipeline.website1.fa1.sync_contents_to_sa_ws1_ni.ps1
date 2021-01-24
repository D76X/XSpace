# Data transfer with AzCopy

# This script does the same as 005_sync_contents_to_sa_ws1_ni.ps1
# but it is ment to be run on as a Powershell task of an Azure Dev
# pepeline. 

# This scripts expects the $env:AZCOPY_SPA_CLIENT_SECRET to be set
# to the secret for the registered App-AzCopy-WebSite1 by the Azure
# Devops pipeline that makes use of it.

# This scripts expects a azcopy.exe at the root of the source code 
# directory.

# Regfs
# https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/utility/powershell?view=azure-devops 
# https://www.dotnetcurry.com/devops/1507/azure-key-vault-secrets-pipelines

$scriptPath=Get-Location
Set-Location $scriptPath
$sourcePath = "${scriptPath}\Contents"
$storageAccountName = "sawebsite120201221"
$containerName = '$web' # notice the '' to store the value as a literal!

.\azcopy.exe --version
.\azcopy.exe login --service-principal `
--application-id d6b56804-e02a-4ef4-a1b9-d8b5af9d4e6e `
--tenant-id 981b07d1-b261-4c3e-a400-b86f7809d9bc

$destinationPath = "https://${storageAccountName}.blob.core.windows.net/${containerName}"

# notice that recursive is on by default
.\azcopy.exe sync $sourcePath  $destinationPath --put-md5 --recursive=false

# clean up the envs 
$env:AZCOPY_SPA_CLIENT_SECRET=''
