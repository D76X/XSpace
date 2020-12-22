# Refs
# https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest
# https://markheath.net/post/deploying-azure-functions-with-azure-cli

#$rand = Get-Random -Minimum 10000 -Maximum 99999

az login
az account set --subscription "Visual Studio Professional with MSDN"

# web site resources
$appInsightsName = "ai-WebSite1-20201221" 
$resourceGroup = "rg-WebSite1" # resource group of the website
# Note : https://docs.microsoft.com/en-us/cli/azure/functionapp?view=azure-cli-latest#az-functionapp-create
# a function app can be attached to an instance of application insights but only if this is in the same RG.

# resource group of the function app assets
$location = "westeurope"
$storageAccountName = "sawebsite1fa120201221" # storage account for the function app
$functionAppName = "fa-ntt-fa1ws1" # the function app

# create the storage account for this function app
az storage account create `
  -n $storageAccountName `
  -l $location `
  -g $resourceGroup `
  --kind StorageV2 `
  --sku Standard_LRS

# create the function app notice the --consumption-plan-location
az functionapp create `
  -n $functionAppName `
  --storage-account $storageAccountName `
  --consumption-plan-location $location `
  --app-insights $appInsightsName `
  --runtime dotnet `
  -g $resourceGroup