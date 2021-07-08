################### Variables #########################################

$resourceGroup = "lesson1"
$location = "westeurope"
$backupvault = "lesson2"
$backuppolicy = "lesson2policy"
$vmresource = "lesson1"
$shareName = "lesson2share"


################### Create a Recovery Services vault ###################

New-AzRecoveryServicesVault `
  -Name $backupvault `
  -ResourceGroupName $resourceGroup `
  -Location $location

  
################### Configure a backup of VM ###########################

$vault = Get-AzRecoveryServicesVault -Name $backupvault
Set-AzRecoveryServicesBackupProperty `
  -Vault $vault `
  -BackupStorageRedundancy GeoRedundant

Get-AzRecoveryServicesVault `
  -Name $backupvaul `
  -ResourceGroupName $resourceGroup | Set-AzRecoveryServicesVaultContext

$targetVault = Get-AzRecoveryServicesVault -ResourceGroupName $resourceGroup -Name $backupvaul

$schPol = Get-AzRecoveryServicesBackupSchedulePolicyObject -WorkloadType "AzureVM"
$GmtTime = Get-Date -Date "2021-07-08 00:00:00Z"
$GmtTime = $GmtTime.ToUniversalTime()
$schpol.ScheduleRunTimes[0] = $GmtTime

$retPol = Get-AzRecoveryServicesBackupRetentionPolicyObject -WorkloadType "AzureVM"
New-AzRecoveryServicesBackupProtectionPolicy `
  -Name $backuppolicy `
  -WorkloadType "AzureVM" `
  -RetentionPolicy $retPol `
  -SchedulePolicy $schPol `
  -VaultId $targetVault.ID

$pol = Get-AzRecoveryServicesBackupProtectionPolicy -Name $backuppolicy -VaultId $targetVault.ID
Enable-AzRecoveryServicesBackupProtection `
  -Policy $pol `
  -Name $vmresource `
  -ResourceGroupName $resourceGroup `
  -VaultId $targetVault.ID


################### Create Azure File Share #############################

$storageAcct = Get-AzStorageAccount -ResourceGroupName "lesson1" -Name "brazhaevcourse"
New-AzRmStorageShare `
    -StorageAccount $storageAcct `
    -Name $shareName `
    -EnabledProtocol SMB `
    -QuotaGiB 2 | Out-Null

