#Created a function and integrated the code in the process block and given specific properties and created New object
Function Get-CompInfo{
       [cmdletBinding()]
       param(
        # want to support multiple computers
         [parameter(mandatory=$true)]
         [validateset('AMBATIKALYAN-1','client')]
         [string[]]$computername,
         
        #switch to turn on error logging 
         [switch]$ErrorLog,
         [string]$logfile = 'c:\errorlog.txt' 
     )
      Begin{
          If($errorLog){
                      Write-Verbose 'Error logging turned on'
                      }else{
                      Write-Verbose 'Error log turned off' 
                      }
                      Foreach($Computer in $Computername){
                         Write-Verbose "Computer: $Computer"
                     }
        }
        process{
             foreach($Computer in $Computername){
               $os =Get-WmiObject -Computername $computer -Class win32_operatingsystem
               $Disk=Get-WmiObject -ComputerName $computer -Class win32_LogicalDisk -Filter "DeviceID='c:'"
               
               $prop =[ordered]@{
                     'ComputerName' =$Computer;
                     'OS Name' = $os.caption;
                     'os Build'= $os.buidnumber;
                     'FreeSpace'= $Disk.freespace / 1gb -as [int]
                    }
                 
                $obj=New-Object -TypeName PSobject -Property $prop 
                Write-Output $prop
                    
               }
        }
        end{}
        }
      

Function Get-myservice {Get-Service -ComputerName AMBATIKALYAN-1





}