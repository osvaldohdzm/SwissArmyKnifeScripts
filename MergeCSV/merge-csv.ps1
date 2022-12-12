Get-ChildItem *.csv -PipelineVariable File |
  ForEach-Object { Import-Csv $_ | Select *,@{l='FileName';e={$File.Name}}} |
  Export-Csv output\output.csv -NoTypeInformation