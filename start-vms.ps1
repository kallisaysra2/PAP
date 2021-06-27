
Function start-vms{

param (
    [Parameter(Mandatory=$false)] 
    [String]  $AzureCredentialAssetName = 'AzureCredential',
        
    [Parameter(Mandatory=$false)]
    [String] $AzureSubscriptionIdAssetName = 'AzureSubscriptionId',

    [Parameter(Mandatory=$false)] 
    [String] $RG = 'Free-DEV-X'
)

# Returns strings with status messages
[OutputType([String])]

# Connect to Azure and select the subscription to work against
$Cred = Get-AzAutomationCredential -ResourceGroupName $RG -AutomationAccountName Demo-Runbook -ErrorAction Stop

$null = Add-AzAccount $Cred -ErrorAction Stop -ErrorVariable err
if($err) {
	throw $err
}

$SubId = Get-AzAutomationVariable -ResourceGroupName Free-DEV-X -AutomationAccountName Demo-Runbook -ErrorAction Stop

# If there is a specific resource group, then get all VMs in the resource group,
# otherwise get all VMs in the subscription.
if ($ResourceGroupName) 
{ 
	$VMs = Get-AzVM -ResourceGroupName $ResourceGroupName
}
else 
{ 
	$VMs = Get-AzVM
}

# Start each of the VMs
foreach ($VM in $VMs)
{
	$StartRtn = $VM | Start-AzVM -ErrorAction Continue

	if ($StartRtn.Status -ne 'Succeeded')
	{
		# The VM failed to start, so send notice
        Write-Output ($VM.Name + " failed to start")
        Write-Error ($VM.Name + " failed to start. Error was:") -ErrorAction Continue
		Write-Error (ConvertTo-Json $StartRtn.Error) -ErrorAction Continue
	}
	else
	{
		# The VM stopped, so send notice
		Write-Output ($VM.Name + " has been started")
	}
}
}