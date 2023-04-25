
$scriptPath = (Split-Path -parent $PSCommandPath)
$commandDocLocation = Join-Path $scriptPath "RunCommandDocuments"
$automationDocLocation = Join-Path $scriptPath "AutomationDocuments"

Set-DefaultAWSRegion -Region us-east-1

#########################################################################
# RunCommand Document to NVIDIA GRID Driver

$documentName = "Install-NVIDIAGRIDDriver"

$filePath = Join-Path $commandDocLocation "$documentName.json"

# Load the content from the json file
$documentJson = Get-Content $filePath | Out-String

Get-SSMDocument -Name $documentName | Remove-SSMDocument -Force

# Create a new document, specifying Command as the DocumentType and passing the content
New-SSMDocument -DocumentType Command -Name $documentName -Content $documentJson




$documentName = "Set-NVIDIAGRIDRegistry"

$filePath = Join-Path $commandDocLocation "$documentName.json"

# Load the content from the json file
$documentJson = Get-Content $filePath | Out-String

Get-SSMDocument -Name $documentName | Remove-SSMDocument -Force

# Create a new document, specifying Command as the DocumentType and passing the content
New-SSMDocument -DocumentType Command -Name $documentName -Content $documentJson




$documentName = "Create-NVIDIAGRIDImage"
$filePath = Join-Path $automationDocLocation "$documentName.json"

# Load the content from the json file
$documentJson = Get-Content $filePath | Out-String

Get-SSMDocument -Name $documentName | Remove-SSMDocument -Force

# Create a new document, specifying Automation as the DocumentType and passing the content
New-SSMDocument -DocumentType Automation -Name $documentName -Content $documentJson
