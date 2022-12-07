Get-Content ips-list.txt | ForEach-Object {
    $obj = "" | Select-Object IPAddress,Hostname
    try { 
        $obj.Hostname = ([system.net.dns]::GetHostByAddress($_)).hostname
    } catch { 
        $obj.Hostname = 'Unknown Host'
    } 
    $obj.IPAddress = $_
    $obj
} | Export-Csv -Path hostnames.csv -NoType

Write-output "Finished at $(Get-Date)"
[Console]::ReadKey()

