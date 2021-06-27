      
    param(
        # want to support multiple computers
         [parameter(mandatory=$True)]
         [validateset('AMBATIKALYAN-1','client')]
         [string[]]$computername
         )

Import-Module D:\Personal\Certificates\Scripts\mytools.psm1
Get-CompInfo -computername $computername
