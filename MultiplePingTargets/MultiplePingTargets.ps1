$info = Get-Content ping-targets.txt | foreach {
    If(Test-Connection -ComputerName $_ -Count 1 -Quiet){
        $status = Write-output "Active"
    }else{
        $status = Write-output "Inactive"
    }
    
    [pscustomobject][ordered]@{
        HostnameIP  = $_
        Status  = $status
    }

    Write-Host "$_ is $status"
}

$info | export-csv ping-results.csv -NoTypeInformation

Write-output "Finished at $(Get-Date)"
[Console]::ReadKey()

