<#
    .Description
    Creates an SNS Topic and CloudWatch Rule to Monitor Automation Step Status.

    The rule is triggered off a Systems Manager Step Change, which will send a JSON
    message to the SNS topic and the input transformer will convert it into a basic
    message.
#>

param (
    $SNSTopic
)

# This is the event pattern which specifies which events the rule triggers off of
$eventPattern = '{"source":["aws.ssm"],"detail-type":["EC2 Automation Step Status-change Notification"]}'

# Create the CloudWatch Event Rule
Write-CWERule -Name 'Demo-AutomationStepMonitorRule' -Description 'A Demo Event when a step status changes' -State ENABLED -EventPattern $eventPattern

# The Input Paths Map which contains the properties to pull from the JSON message
$inputPathsMap = New-Object 'System.Collections.Generic.Dictionary[[System.String],[System.String]]'
$inputPathsMap.Add("status", "$.detail.status")
$inputPathsMap.Add("stepname", "$.detail.stepname")

# The Input Transformer will transform the JSON properties from the Input Paths Map into a formatted message.
$inputTransformer = New-Object Amazon.CloudWatchEvents.Model.InputTransformer
$inputTransformer.InputPathsMap = $inputPathsMap
$inputTransformer.InputTemplate = '"Step <stepname> has a status of <status>."'

# Create the Target Object
$target = New-Object Amazon.CloudWatchEvents.Model.Target 
$target.Arn = $snsTopic
$target.InputTransformer = $inputTransformer
$target.Id = "Id1234567890"

# Write the target to the rule
Write-CWETarget -Rule 'Demo-AutomationStepMonitorRule' -Target $target
