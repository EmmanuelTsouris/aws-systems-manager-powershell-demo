
[string[]]$runCommand = Get-Content C:\src\EC2WindowsNVIDIAGRIDInstall\Set-GridLicenseRegistryKey.ps1 -Encoding Ascii | ? {$_.trim() -ne "" } | % { [System.Text.RegularExpressions.Regex]::Escape(($_)) }

$precondition = @{}
$precondition['StringEquals'] = @("platformType", "Windows")

$inputs = @{}
$inputs['timeoutSeconds'] = 300
$inputs['runCommand'] = $runCommand

$step = @{}
$step['name'] = "SetNVIDIAGRIDRegistry"
$step['action'] = "aws:runPowerShellScript"
$step['precondition'] = $precondition
$step['inputs'] = $inputs

$mainSteps = @($step)

$commandDoc = @{}
$commandDoc['schemaVersion'] = "2.2"
$commandDoc['description'] = "Set-NVIDIAGRIDRegistry"
$commandDoc['parameters'] = @()
$commandDoc['mainSteps'] = @(@{})
$commandDoc.mainSteps = $mainSteps

($commandDoc | ConvertTo-Json -Depth 50) -replace "\u0027" '\\''' | Out-File .\RunCommandDocuments\GeneratedDocument.json
