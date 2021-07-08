################### Variables #########################################

$vaultName = "lesson1"
$resourceGroup = "lesson1"
$location = "westeurope"
$secretName = "MySecret"
$secretValue = ConvertTo-SecureString -String '$R3SSkDZ' -AsPlainText -Force


################### Deploy a resource group ############################

New-AzResourceGroup `
  -Name $resourceGroup `
  -Location $location


################### Deploy Azure KeyVault ##############################

New-AzKeyVault `
  -VaultName $vaultName `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -EnabledForTemplateDeployment


################### Add secret in Azure KeyVault #######################

Set-AzKeyVaultSecret `
  -VaultName $vaultName `
  -Name $secretName `
  -SecretValue $secretValue


################### Deploy VM ##########################################

New-AzResourceGroupDeployment `
  -ResourceGroupName $resourceGroup `
  -TemplateUri git\Course\azure\lesson1\template.json `
  -TemplateParameterFile parameters.json


################### Deploy azure storage account #######################

New-AzStorageAccount -ResourceGroupName $resourceGroup `
  -Name brazhaevcourse `
  -Location $location `
  -SkuName Standard_RAGRS `
  -Kind StorageV2

