################### Variables #########################################

$resourceGroup = "lesson3"
$location = "westeurope"
$gitrepo="https://github.com/VetalRacer/html-docs-hello-world.git"
$webappname="lesson3webapp$(Get-Random)"

#######################################################################

$rg = New-AzResourceGroup `
  -Name $resourceGroup `
  -Location $location

New-AzAppServicePlan `
  -Name $webappname `
  -Location $location `
  -ResourceGroupName $rg.ResourceGroupName `
  -Tier Free

$webapp = New-AzWebApp `
  -ResourceGroupName $rg.ResourceGroupName `
  -Name $webappname `
  -Location $location `
  -AppServicePlan $webappname

$PropertiesObject = @{
    repoUrl = "$gitrepo";
    branch = "master";
    isManualIntegration = "true";
}

Set-AzResource `
  -PropertyObject $PropertiesObject `
  -ResourceGroupName $rg.ResourceGroupName `
  -ResourceType Microsoft.Web/sites/sourcecontrols `
  -ResourceName $webappname/web `
  -ApiVersion 2015-08-01 `
  -Force

$subnet = New-AzVirtualNetworkSubnetConfig `
  -Name lesson3subnet `
  -AddressPrefix 10.0.0.0/24

$vnet = New-AzVirtualNetwork `
  -Name lesson3vnet `
  -ResourceGroupName $rg.ResourceGroupName `
  -Location $location `
  -AddressPrefix 10.0.0.0/16 `
  -Subnet $subnet

$subnet=$vnet.Subnets[0]

$publicip = New-AzPublicIpAddress `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -Name lesson3PublicIPAddress `
  -AllocationMethod Static `
  -Sku Standard

$gipconfig = New-AzApplicationGatewayIPConfiguration `
  -Name lesson3gatewayIP `
  -Subnet $subnet

$pool = New-AzApplicationGatewayBackendAddressPool `
  -Name lesson3appGatewayBackendPool `
  -BackendFqdns $webapp.HostNames

$match = New-AzApplicationGatewayProbeHealthResponseMatch `
  -StatusCode 200-399

$probeconfig = New-AzApplicationGatewayProbeConfig `
  -name webappprobe `
    -Protocol Http -Path / `
    -Interval 30 `
    -Timeout 120 `
    -UnhealthyThreshold 3 `
    -PickHostNameFromBackendHttpSettings `
    -Match $match

$poolSetting = New-AzApplicationGatewayBackendHttpSettings `
  -Name lesson3appGatewayBackendHttpSettings `
  -Port 80 `
  -Protocol Http `
  -CookieBasedAffinity Disabled `
  -RequestTimeout 120 `
  -PickHostNameFromBackendAddress `
  -Probe $probeconfig

$fphttp = New-AzApplicationGatewayFrontendPort `
  -Name lesson3frontendport80 `
  -Port 80

$fipconfig = New-AzApplicationGatewayFrontendIPConfig `
  -Name lesson3fipconfig `
  -PublicIPAddress $publicip

$listenerhttp = New-AzApplicationGatewayHttpListener `
  -Name lesson3listenerhttp `
  -Protocol Http `
  -FrontendIPConfiguration $fipconfig `
  -FrontendPort $fphttp

$rulehttp = New-AzApplicationGatewayRequestRoutingRule `
  -Name lesson3rulehttp `
  -RuleType Basic `
  -BackendHttpSettings $poolSetting `
  -HttpListener $listenerhttp `
  -BackendAddressPool $pool

$sku = New-AzApplicationGatewaySku `
  -Name Standard_v2 `
  -Tier Standard_v2 `
  -Capacity 2

New-AzApplicationGateway `
  -Name lesson3AppGateway `
  -ResourceGroupName $rg.ResourceGroupName `
  -Location $location `
  -BackendAddressPools $pool `
  -BackendHttpSettingsCollection $poolSetting `
  -Probes $probeconfig `
  -FrontendIpConfigurations $fipconfig `
  -GatewayIpConfigurations $gipconfig `
  -FrontendPorts $fphttp `
  -HttpListeners $listenerhttp `
  -RequestRoutingRules $rulehttp `
  -Sku $sku