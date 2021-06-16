$logAnalyticsName = $args[0]
$logAnalyticsRG = $args[1]
$logAnalyticsResource = Get-AzOperationalInsightsWorkspace -Name $logAnalyticsName -ResourceGroupName $logAnalyticsRG
$kvList = Get-AzKeyVault

foreach ($kvItem in $kvList){
    $diagSettingName = $kvItem.vaultName+"-diag-01"
    Set-AzDiagnosticSetting -Name $diagSettingName -ResourceId $kvItem.ResourceId -Enabled $true -WorkspaceId $logAnalyticsResource.ResourceId -Category AuditEvent
    $Output = "Diagnostic Setting has been enabled for "+$kvItem.vaultName+" Key Vault"
    $Output
}