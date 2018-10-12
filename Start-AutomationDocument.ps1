
Set-DefaultAWSRegion -Region us-east-1

# Kick off the automation documents which will create the images

$developerImageExecId = Start-SSMAutomationExecution -DocumentName "Demo-CreateDeveloperImage"
$sqlDevImageExecId = Start-SSMAutomationExecution -DocumentName "Demo-CreateSqlDevImage"

# Get Automation Execution Status
Get-SSMAutomationExecution -AutomationExecutionId $developerImageExecId
Get-SSMAutomationExecution -AutomationExecutionId $sqlDevImageExecId


# Get the CloudWatch Log Group Name from Parameter Store
$cwlGroupName = (Get-SSMParameter -Name "/Test/AutomationDemo/CloudWatchLogGroup").Value

# Get the CloudWatch Log Streams, and just select the newest one.
$cwlStreams = Get-CWLLogStreams -LogGroupName $cwlGroupName | Sort-Object CreationTime -Descending | Select-Object -First 1

# Show the events
($cwlStreams | Get-CWLLogEvent -LogGroupName $cwlGroupName).Events
