# Data transfer with AzCopy

# This is the version of the script sync_contents_to_sa_ws1.ps1
# that does not require any interactive login. The script makes
# use of a Service Principal registered in the Azure AD tenant 
# of the SA with which the local content is synched and a 
# corresponding application registered in the same Azure AD tenant 
# with the same Service Principal.
# This script is meant to be run on-premise as opposed to on a VM
# in Azure and this is the reason why a Service Principal is used 
# instead of a Managed Identity as specified in trhe related docs.

#Refs

# Authorize access to blobs with AzCopy and Azure Active Directory (Azure AD)
# https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-authorize-azure-active-directory

# How to: Use the portal to create an Azure AD application and service principal that can access resources
# https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal

# Authorize access to blobs and queues using Azure Active Directory
# https://docs.microsoft.com/en-us/azure/storage/common/storage-auth-aad

# Acquire a token from Azure AD for authorizing requests from a client application
# https://docs.microsoft.com/en-us/azure/storage/common/storage-auth-aad-app?tabs=dotnet

# Use the Azure portal to assign an Azure role for access to blob and queue data
# https://docs.microsoft.com/en-us/azure/storage/common/storage-auth-aad-rbac-portal

# Issue using OAuth for blob copy operations
# https://github.com/Azure/azure-storage-azcopy/issues/819

# Issue running azcopy non-interactively with Service Principle 
# https://github.com/Azure/azure-storage-azcopy/issues/561

# Unable to authenticate via service principal client id + secret
# https://github.com/Azure/azure-storage-azcopy/issues/1160

# Client Secret
# Description : App-AzCopy-WebSite-Permanent-Secret
# id : 8657344b-a57b-4282-b83d-e50313bd7e1f
# value: _PLDAbX.Zv4iks70~368zGvsieuB_CpwMD
# Expires : 12/31/2299

#tenantId = 981b07d1-b261-4c3e-a400-b86f7809d9bc #NewThinkingTechnologies

# https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-authorize-azure-active-directory
# $env:AZCOPY_SPA_CLIENT_SECRET="$(Read-Host -prompt "Enter key")"
$env:AZCOPY_SPA_CLIENT_SECRET='_PLDAbX.Zv4iks70~368zGvsieuB_CpwMD'

# we no longer need this!
# Connect-AzureRmAccount -Subscription "Visual Studio Professional with MSDN"

# https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10
# https://docs.microsoft.com/en-us/azure/storage/common/storage-ref-azcopy-login
.\azcopy.exe login --service-principal `
--application-id 8657344b-a57b-4282-b83d-e50313bd7e1f `
--tenant-id 981b07d1-b261-4c3e-a400-b86f7809d9bc

$storageAccountName = "sawebsite120201221"

#$resourceGroup = "rg-WebSite1" # resource group of the website
#$storKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $resourceGroup -Name $storageAccountName).Value[0]
#$storContext = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storKey
#$sasToken = New-AzureStorageAccountSASToken -Service Blob -ResourceType Service,Container,Object -Permission "rwdlaup" -Protocol HttpsOnly -Context $storContext

$scriptPath=Get-Location
$sourcePath = "${scriptPath}\Contents"
$containerName = '$web' # notice the '' to store the value as a literal!

#$destinationPath = "https://${storageAccountName}.blob.core.windows.net/${containerName}/${sasToken}"
$destinationPath = "https://${storageAccountName}.blob.core.windows.net/${containerName}"

# notice that recursive is on by default
C:\"Program Files"\AzCopy\azcopy.exe sync $sourcePath  $destinationPath --put-md5 --recursive=false




