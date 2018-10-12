
Set-DefaultAWSRegion -Region us-east-1

$latestWindowsServer2016 = Get-SSMParameter -Name /aws/service/ami-windows-latest/Windows_Server-2016-English-Full-Base

$allLatestWindows = Get-SSMParametersByPath -Path "/aws/service/ami-windows-latest"
