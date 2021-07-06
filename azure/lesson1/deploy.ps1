$vaultName = "lesson1"
$resourceGroup = "lesson1"
$location = "westeurope"
$secretName = "MySecret"

New-AzResourceGroup `
  -Name $resourceGroup `
  -Location $location

New-AzKeyVault `
  -VaultName $vaultName `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -EnabledForTemplateDeployment

$secretValue = ConvertTo-SecureString -String 'test' -AsPlainText -Force

Set-AzKeyVaultSecret `
  -VaultName $vaultName `
  -Name $secretName `
  -SecretValue $secretValue