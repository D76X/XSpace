<#-----------------------------------------------------------------------------
Subject: Generate a Service Identity for an AppService 
Author : Davide Spano
Refs : https://docs.microsoft.com/en-us/azure/sql-database/sql-database-copy
       https://docs.microsoft.com/en-us/powershell/module/az.sql/new-azsqldatabasecopy?view=azps-2.0.0
       https://www.powershellgallery.com/packages/Az/1.3.0
-----------------------------------------------------------------------------#>

Login-AzureRmAccount
Set-AzureRmContext -SubscriptionId "df17c9fe-de76-4143-bbae-77b75fa0705b"


# get all the AppServices on the subscription 
Get-AzureRmWebApp


$ts = Get-Date -format "yyyyMMdd-mm-ss-fff"
$rgname = "SomeResourceGroup"
$servername = "SomeServerName"
$elasticPool = "SomeSqlServerPool"

# get all the AppServices on the subscription for a specific RG
Get-AzureRmWebApp -ResourceGroupName $rgname


# get all the AppServices on the subscription for a specific RG and a name AppService
Get-AzureRmWebApp -ResourceGroupName $rgname -Name "slphxdev"

#----------------------------------------------------------------------------------
# get the service principlas for AppServices on the subscriptions
# you might not have enough permissions to do so and might need the admin of the 
# directory to do this for you
# https://docs.microsoft.com/en-us/powershell/module/azuread/get-azureadserviceprincipal?view=azureadps-2.0
Get-AzureRmADServicePrincipal
Get-AzureRmADServicePrincipal -SearchString "slphxdev"
#----------------------------------------------------------------------------------

#----------------------------------------------------------------------------------
# You might also use the new AZ module in place of the old RM module but not in the
# same Powershell sesssion!
# https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/how-to-view-managed-identity-service-principal-powershell
Connect-AzureAD
Get-AzADServicePrincipal -DisplayName "slphxdev"
#----------------------------------------------------------------------------------

#----------------------------------------------------------------------------------
# Adding a system-assigned identity
# https://docs.microsoft.com/en-us/azure/app-service/overview-managed-identity
# I have created the following Service Manage Identity on the DEV Microsoft Account
Resource group: ...
Location : West Europe
Subscription : ...
Subscription ID: ...
Type : User assigned managed identity
Client ID:...
Object ID:...
#----------------------------------------------------------------------------------
# I then associated this Service Identity to the AppService slphxdev
# To do so navigate to the AppService and choose the tab Idrnty then
# 1-System Assigned => to create a System Assigned MSI
# 2-User Assigned to associated a MSI that you have previously created as above  
#----------------------------------------------------------------------------------


