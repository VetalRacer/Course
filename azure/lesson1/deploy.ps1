$vaultName = "lesson1"
$resourceGroup = "lesson1"
$location = "westeurope"
$secretName = "MySecret"
$secretValue = ConvertTo-SecureString -String '$R3SSkDZ' -AsPlainText -Force

New-AzResourceGroup `
  -Name $resourceGroup `
  -Location $location

New-AzKeyVault `
  -VaultName $vaultName `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -EnabledForTemplateDeployment

Set-AzKeyVaultSecret `
  -VaultName $vaultName `
  -Name $secretName `
  -SecretValue $secretValue

New-AzResourceGroupDeployment `
  -ResourceGroupName $resourceGroup `
  -TemplateUri git\Course\azure\lesson1\template.json `
  -TemplateParameterFile parameters.json

New-AzStorageAccount -ResourceGroupName $resourceGroup `
  -Name brazhaevcourse `
  -Location $location `
  -SkuName Standard_RAGRS `
  -Kind StorageV2

