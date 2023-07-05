
Import-Module PSWorkflow

Write-Host "`nCreating tmp dir...`n" -NoNewline -ForegroundColor green

$tmp_path = "tmp"
If(!(test-path -PathType container $tmp_path))
{
      New-Item -ItemType Directory -Path $tmp_path
}

$output_path = "outputs"
If(!(test-path -PathType container $output_path))
{
      New-Item -ItemType Directory -Path $output_path
}

Write-Host "`nAdding nmap to temporal path...`n" -NoNewline -ForegroundColor green

$nmap_path = "C:\Program Files (x86)\Nmap\"
$env:Path += ';$nmap_path '

Write-Host "`nSplitting list...`n" -NoNewline -ForegroundColor green

$filename = "nmap-targets-list.txt"

$target_list_num_lines = (Get-Content $filename).Length
$num_terminals =  10
$num_files_scan = [int]($target_list_num_lines / $num_terminals)

$i = 0; Get-Content $filename -ReadCount $num_files_scan | % { $i++; $_ | Out-File tmp/scan_$i.txt }


Write-Host "`nGetting list of current powershell process...`n" -NoNewline -ForegroundColor green

$start_process_id = (get-process powershell).ID
write-host $start_process_id

Write-Host "`nExcuting parallel scans...`n" -NoNewline -ForegroundColor green

Workflow NMAPParallelScans {	
	
	$lists = Get-Childitem "tmp" -recurse | where { $_.extension -eq ".txt" } | % {
		Write-Output $_.FullName
	}

	Foreach -parallel($list in $lists) {
$Command = "{`$env:Path += `';C:\Program Files (x86)\Nmap\`' ; foreach(`$line in Get-Content -Encoding UTF8 `"$list`"){ nmap -Pn -sS -p- -sV -n --min-rate 5432 --open --stats-every 3s --host-timeout 120m  --initial-rtt-timeout 315ms --min-rtt-timeout 280ms --max-rtt-timeout 350ms  --max-retries 1 --max-scan-delay 0 -oA outputs\`$(`$line) `$line } ; exit }"
 
Start-Process powershell -ArgumentList "-noexit","-Command & $Command"  


	} 

}

NMAPParallelScans

$sec = $num_terminals*3
Start-Sleep -Seconds $sec

$running_process_id = (get-process powershell).ID

write-host $running_process_id

$process_ids = Compare-Object -ReferenceObject ($start_process_id) -DifferenceObject ($running_process_id ) -PassThru

Wait-Process -Id $process_ids

Remove-Item $tmp_path -Recurse -Force -Confirm:$false 

write-Host "`nScans completed at $(Get-Date)`n" -NoNewline -ForegroundColor green 



