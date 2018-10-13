
Set-DefaultAWSRegion -Region us-east-1

# Use Tags
$targetTags = @{Key = "tag:Role"; Values = @("Developer")}

# Send the Command using the tags
$result = Send-SSMCommand -Target $targetTags -DocumentName 'Install-VisualStudioCode' -Comment 'Testing1'

# Or send the Command using an instance id
$result = Send-SSMCommand -InstanceId "<instance id>" -DocumentName 'Install-VisualStudioCode' -Comment 'Testing2'
