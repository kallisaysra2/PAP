
$K=Get-Service -Name XboxNetApiSvc
If($k.status -eq "Stopped")
{
Write-Host "Service is currently stopped"
} 
else
{
Stop-Service -Name $k.Name
write-host "Service has been stopped"
}