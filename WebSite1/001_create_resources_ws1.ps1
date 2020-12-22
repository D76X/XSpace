# Refs
# https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest
# https://markheath.net/post/deploying-azure-functions-with-azure-cli
# https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website
# https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website-host

# $rand = Get-Random -Minimum 10000 -Maximum 99999

az login
az account set --subscription "Visual Studio Professional with MSDN"

$location = "westeurope"
$resourceGroup = "rg-WebSite1" # resource group of the website
$storageAccountName = "sawebsite120201221" # Storage Account to hold the WebSite static content
$appInsightsName = "ai-WebSite1-20201221"# Instance of Application Insight for the all site
$errorPage = "error.html"
$indexPage = "index.html"

# create the rg for the site resources
az group create -n $resourceGroup -l $location

# create the application insights resource for the site
az resource create `
  -g $resourceGroup -n $appInsightsName `
  --resource-type "Microsoft.Insights/components" `
  --properties '{\"Application_Type\":\"web\"}'

# create the storage account to hold the static content of the site
# Static websites are only supported for StorageV2 (general-purpose v2) 
# accounts!
az storage account create `
  -n $storageAccountName `
  -l $location `
  -g $resourceGroup `
  --kind StorageV2 `
  --sku Standard_LRS

# enable the site storage account to serve static content 
az storage blob service-properties update `
--account-name $storageAccountName `
--static-website `
--404-document $errorPage `
--index-document $indexPage