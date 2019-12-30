<#-----------------------------------------------------------------------------
Subject: Copy a database within the same server
Author : Davide Spano
Refs : https://docs.microsoft.com/en-us/azure/sql-database/sql-database-copy
       https://docs.microsoft.com/en-us/powershell/module/az.sql/new-azsqldatabasecopy?view=azps-2.0.0
       https://www.powershellgallery.com/packages/Az/1.3.0
-----------------------------------------------------------------------------#>

Login-AzureRmAccount
Set-AzureRmContext -SubscriptionId "df17c9fe-de76-4143-bbae-77b75fa0705b"
<#-----------------------------------------------------------------------------

#Get-Help New-AzureRmSqlDatabaseCopy
#Get-Help New-AzureRmSqlDatabaseCopy -Detailed
#Get-Help New-AzureRmSqlDatabaseCopy -Examples

-----------------------------------------------------------------------------#>

$ts = Get-Date -format "yyyyMMdd-mm-ss-fff"
$rgname = "SomeResourceGroup"
$servername = "SomeServerName"
$elasticPool = "SomeSqlServerPool"

#------------------------------------------
#$dbname = "SL_WIT_PROD_COPY"
#$targetdbname = "SL_PHXDEV_DEV"
#$dbname = "SL_WIT_PROD_bck_20190523-16-08-281"
#$targetdbname = "SL_WIT_PROD_bck_$ts"
#------------------------------------------


# check what you've got
# Get-AzureRmSqlDatabase -ResourceGroupName $rgname -ServerName $servername | Select-Object -Property DatabaseName, ResourceId | Format-Table

New-AzureRmSqlDatabaseCopy -ResourceGroupName $rgname `
    -ServerName $servername `
    -DatabaseName $dbname `
    -CopyResourceGroupName $rgname `
    -CopyServerName $servername `
    -CopyDatabaseName $targetdbname `
    -ElasticPoolName $elasticPool


Remove-AzureRmSqlDatabase -ResourceGroupName $rgname `
-DatabaseName 'SL_PHX_PROD_COPY' `
-ServerName $servername


