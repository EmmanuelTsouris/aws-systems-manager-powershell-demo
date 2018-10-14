
<#
The following script will creates an SNS Topic and CloudWatch Rule.

The rule is triggered off a Systems Manager Step Change, which essentially will send 
a JSON message to the SNS topic and the input transformer will convert it into a basic
message.
#>

Set-DefaultAWSRegion -Region us-east-1

# Create the SNS Topic for our notifications
$snsTopic = New-SNSTopic -Name "Demo-SystemsManagerTopic"

<#
# To Subscribe use Connect-SNSNotification, here are some examples:
Connect-SNSNotification -TopicArn $snsTopic -Protocol 'email' -Endpoint 'someone@somewhere.com'
Connect-SNSNotification -TopicArn $snsTopic -Protocol 'sms' -Endpoint '12065551234'

# Test the SNS Topic by using Publish-SNSMessage
Publish-SNSMessage -TopicArn $snsTopic -Message 'This is a test!'
#>

# This is the event pattern which specifies which events the rule triggers off of
$eventPattern = '{"source":["aws.ssm"],"detail-type":["EC2 Automation Step Status-change Notification"]}'

# Create the CloudWatch Event Rule
Write-CWERule -Name 'DemoAutomationStepEvent' -Description 'A Demo Event when a step status changes' -State ENABLED -EventPattern $eventPattern

# The Input Paths Map which contains the properties to pull from the JSON message
$inputPathsMap = New-Object 'System.Collections.Generic.Dictionary[[System.String],[System.String]]'
$inputPathsMap.Add("status","$.detail.status")
$inputPathsMap.Add("stepname","$.detail.stepname")

# The Input Transformer will transform the JSON properties from the Input Paths Map into a formatted message.
$inputTransformer = New-Object Amazon.CloudWatchEvents.Model.InputTransformer
$inputTransformer.InputPathsMap = $inputPathsMap
$inputTransformer.InputTemplate  = '"Step <stepname> has a status of <status>."'

# Create the Target Object
$target = New-Object Amazon.CloudWatchEvents.Model.Target 
$target.Arn = $snsTopic
$target.InputTransformer = $inputTransformer
$target.Id = "Id1234567890"

# Write the target to the rule
Write-CWETarget -Rule 'DemoAutomationStepEvent' -Target $target
