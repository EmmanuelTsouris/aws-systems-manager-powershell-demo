
Set-DefaultAWSRegion -Region us-east-1

# Kick off the automation documents which will create the images

# First, we'll create a hashtable representing the parameters from the Automation document.
# In this case we'll set the ImageName instead of taking the parameter default defined in the document.
$devImageParams = @{'ImageName' = "Windows_Server-2016-Developer"}

# Kick off the automation and pass the parameter we defined above.
$developerImageExecId = Start-SSMAutomationExecution -DocumentName "Demo-CreateDeveloperImage" -Parameter $devImageParams

# Parameter for our second image, giving it a different name.
$sqlImageParams = @{'ImageName' = "Windows_Server-2016-SQLDeveloper"}
$sqlDevImageExecId = Start-SSMAutomationExecution -DocumentName "Demo-CreateSqlDevImage" -Parameter $sqlImageParams

# Get Automation Execution Status
Get-SSMAutomationExecution -AutomationExecutionId $developerImageExecId
Get-SSMAutomationExecution -AutomationExecutionId $sqlDevImageExecId

# Get the CloudWatch Log Group Name from Parameter Store
$cwlGroupName = (Get-SSMParameter -Name "/Test/AutomationDemo/CloudWatchLogGroup").Value

# Get the CloudWatch Log Streams, and just select the newest one.
$cwlStreams = Get-CWLLogStreams -LogGroupName $cwlGroupName | Sort-Object CreationTime -Descending | Select-Object -First 1

# Show the events
($cwlStreams | Get-CWLLogEvent -LogGroupName $cwlGroupName).Events
