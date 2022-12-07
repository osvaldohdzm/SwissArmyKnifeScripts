Write-Host "`nCreating tmp dir...`n" -NoNewline -ForegroundColor green

$tmp_path = "tmp"
If(!(test-path -PathType container $tmp_path))
{
      New-Item -ItemType Directory -Path $tmp_path
}

$output_path = "output"
If(!(test-path -PathType container $output_path))
{
      New-Item -ItemType Directory -Path $output_path
}

Write-Host "`nSplitting list...`n" -NoNewline -ForegroundColor green

$filename = "nmap-cnint-list-tiny.txt"
$nmap_path = "C:\Program Files (x86)\Nmap\"
$env:Path += ';C:\Program Files (x86)\Nmap\'

$i = 0; Get-Content $filename -ReadCount 20 | % { $i++; $_ | Out-File tmp/scan_$i.txt }


Write-Host "`nExcuting parallel scans...`n" -NoNewline -ForegroundColor green

Workflow TestParallel {	
	
	$lists = Get-Childitem "tmp" -recurse | where { $_.extension -eq ".txt" } | % {
		Write-Output $_.FullName
	}

	Foreach -parallel($list in $lists) {
$Command = "{`$env:Path += `';C:\Program Files (x86)\Nmap\`' ; foreach(`$line in Get-Content -Encoding UTF8 `"$list`"){ nmap -vvv --open -Pn -sS -sV -p- --stats-every 10s --script-timeout 1500ms --host-timeout 120m -T5 -oX outputs\`$(`$line).xml `$line } ; Read-Host}"
Start-Process powershell -ArgumentList "-noexit","-Command & $Command" 
	}
}

TestParallel


[Console]::ReadKey()

