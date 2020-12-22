# Refs
# https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest
# https://markheath.net/post/deploying-azure-functions-with-azure-cli
# https://docs.microsoft.com/en-us/dotnet/core/deploying/deploy-with-cli
# https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-publish?tabs=netcore21

az login
az account set --subscription "Visual Studio Professional with MSDN"
az account show

$resourceGroup = "rg-WebSite1" # resource group of the website and the corrisponding function apps
$functionAppName = "fa-ntt-fa1ws1" # the function app name on Azure

$scriptPath=Get-Location
$projectName="fa1ws1"
$projectFile="${projectName}.csproj"
$projectFolder = "${scriptPath}\FunctionApps\${projectName}"
$targetFramework="netcoreapp3.0"
$publishFolder = "${projectFolder}\bin\Release\${targetFramework}\publish"
$project = "${projectFolder}\${projectFile}"

# publish the code
dotnet publish $project -c Release 

# create the zip
$publishZip = "${projectFolder}\publish.zip"
if(Test-path $publishZip) {Remove-item $publishZip}
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::CreateFromDirectory($publishFolder, $publishZip)

# deploy the zipped package
az functionapp deployment source config-zip `
-g $resourceGroup `
-n $functionAppName `
--src $publishZip