
Set-DefaultAWSRegion -Region us-east-1

# Kick off the automation documents which will create the images

Start-SSMAutomationExecution -DocumentName "Demo-CreateDeveloperImage"

Start-SSMAutomationExecution -DocumentName "Demo-CreateSqlDevImage"
