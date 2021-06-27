function get-selectedprocess
{

Get-Process | Export-Csv -Path D:\Personal\Certificates\Scripts\process.csv
Import-Csv -Path D:\Personal\Certificates\Scripts\process.csv | Select-Object Name, SI, Handles, VM, Path | Format-Table
}
get-selectedprocess