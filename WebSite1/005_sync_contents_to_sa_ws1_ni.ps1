# Data transfer with AzCopy

# This is the version of the script sync_contents_to_sa_ws1.ps1
# that does not require any interactive login. The script makes
# use of a Service Principal registered in the Azure AD tenant 
# of the Storage Account with which the local content is synched 
# and a corresponding application registered in the same Azure AD
# tenant represented by this Service Principal.
# This script is meant to be run on-premise as opposed to on a VM
# in Azure and this is the reason why a Service Principal is used 
# instead of a Managed Identity as specified in trhe related docs.

#-----------------------------------------------------------------------------------------------
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

#-----------------------------------------------------------------------------------------------

#tenantId = 981b07d1-b261-4c3e-a400-b86f7809d9bc #NewThinkingTechnologies

#-----------------------------------------------------------------------------------------------

# STEP 1 
# In the Azure Portal or via CLI create an Application in AzureAD registered in the tenant
# NewThinkingTechnologies. The following are the details of the application. To this app
# permissions will then later granted to let it copy the HTML files from the local folder
# Contents to the $web blob container for the Storage Account sawebsite120201221.

# Client App
# Display Name : App-AzCopy-WebSite1 
# ObjectID : 50753459-0cf9-4034-a369-cfdeb8edb0c0

#-----------------------------------------------------------------------------------------------

# STEP 2
# Create a Security Principal to allow the App-AzCopy-WebSite1 app to access the 
# sawebsite120201221/$web blob container.

# Notice that the App-AzCopy-WebSite1 is only the client application registered in AzureAD
# for the tenant NewThinkingTechnologies. Each client application may have 0 or more 
# Service Principals associated with it. A SP represents the set of permissions granted to 
# an application in AzureAD in relation to some other resource in the same tenant. We call 
# each of such sets of  permission a security context of the app. For example in the following 
# we need to provide the App-AzCopy-WebSite1 app with a set of permissions to access the 
# Storage Account blob container sawebsite120201221/$web so that the app may be employed to 
# to copy the HTMl files from the local Contents folder to the $web blob container. 

# The same application may be granted other sets of permissions to interact with other resources
# available on the same tenant in which case you would have a SP for each of these.

# A Sevice Principal may be created in various way i.e. via the Azure Portal, Azure CLI, etc.
# For example from the Azure Portal go to sawebsite120201221/$web blob container and in the 
# blade Access Control (IAM) create the SP for the App-AzCopy-WebSite1 app to access 
# sawebsite120201221/$web  by pressing the +Add button > Add Role Assignment then assign the 
# Storage Blob Data Contributor Role to App-AzCopy-WebSite1. The net result will be the creation of
# a Security Principal for the app App-AzCopy-WebSite1 which represents it in the context of the
# the resource sawebsite120201221/$web and to which the permissions of the Role(s) 
# Storage Blob Data Contributor are granted.

# This process may also be carried out in the Azure CLI or Powershell.

#-----------------------------------------------------------------------------------------------

# STEP 3

# We now want this script to be able to leverage the App-AzCopy-WebSite1 app and its Service Principal
# to the sawebsite120201221/$web to copy the HTML files from the local folder Contents to the $web blob
# container sawebsite120201221/$web.

# In order to do so we must provide this script with credentials that are granted to the Service Pricipal
# it wants to make use of. One form in which such credentials can be provided by AzureAD is that of a
# client secret. A client secret is a string value that is generated for an application registered in 
# AzureAD in a tenant. Any scripts or client apps that are able to store and present such secret to AzureAD
# are going to be granted the same permissions of the Security Principals for which such secret has been 
# generated.

# Notice that the client app or script that makes use of the secret has also the responsibility to keep 
# the secret value safe. This is to say that this mechanism of authentication is actually meant for 
# scripts and applications that run on safe systems with secure private storage from where stealing the
# secret is difficult or impossible. This is NOT the case of WEB apps that run in the browser.
# Only server side applications or native apps can give such guarantee and of course any script running
# on server machines.  

# The simple way to create such secret is via the Azure Portal. In the AzureAD resource for the tenant
# select the App Registration tab and select the registetred application tab and then select the 
# registered application of interest which in this case is App-AzCopy-WebSite1 then in the tab
# Certificate &Secrets it is possible to create such secret. Secrets may be created with an expiry date
# or to have permanent validity. However, in all cases secrets may be deleted from the same tab and 
# consequentely all application still using them would lose their access to any of the tenant resources. 

# Client Secret
# Description : App-AzCopy-WebSite-Permanent-Secret
# id : fd7418e5-8b99-443f-a6ba-dc495a2d288c
# value: KEEP THIS VALUE SECRET ON THE AZURE PORTAL OR LOCALLY IN SECURE STORAGE NOT IN SOURCE CONTROL!
# Expires : 12/31/2299

# In this example _PLDAbX.Zv4iks70~368zGvsieuB_CpwMD is stored in the script itself but this is not
# secure obviously (this secret will be deleted after testing this script). Never check secrets in 
# source control!


#-------------------------------------------------------------------------------------------

# STEP 4

# Set env:AZCOPY_SPA_CLIENT_SECRET to the secret
# https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-authorize-azure-active-directory

# Interactive when you run this script manually
# $env:AZCOPY_SPA_CLIENT_SECRET="$(Read-Host -prompt "Enter key")"

# Never do thisas it ends up in source control
# $env:AZCOPY_SPA_CLIENT_SECRET='_PLDAbX.Zv4iks70~368zGvsieuB_CpwMD'

# Set the Working Folder of the script to the root folder 
# Make sure a copy of azcopy.exe is in this folder
$scriptPath=Get-Location
Set-Location $scriptPath
$sourcePath = "${scriptPath}\Contents"
$storageAccountName = "sawebsite120201221"
$containerName = '$web' # notice the '' to store the value as a literal!
$secretPath='C:\VSProjects\xspace.secret.app.azcopy.website1.txt'
$env:AZCOPY_SPA_CLIENT_SECRET=(Get-Content -Path $secretPath -TotalCount 1)

# https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10
# https://docs.microsoft.com/en-us/azure/storage/common/storage-ref-azcopy-login
.\azcopy.exe login --service-principal `
--application-id d6b56804-e02a-4ef4-a1b9-d8b5af9d4e6e `
--tenant-id 981b07d1-b261-4c3e-a400-b86f7809d9bc

$destinationPath = "https://${storageAccountName}.blob.core.windows.net/${containerName}"

# notice that recursive is on by default
.\azcopy.exe sync $sourcePath  $destinationPath --put-md5 --recursive=false

# clean up the envs 
$env:AZCOPY_SPA_CLIENT_SECRET=''
#-------------------------------------------------------------------------------------------

