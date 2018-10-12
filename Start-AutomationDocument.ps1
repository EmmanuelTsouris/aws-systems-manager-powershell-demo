
Set-DefaultAWSRegion -Region us-east-1

Start-SSMAutomationExecution -DocumentName "Build-DeveloperImage"
