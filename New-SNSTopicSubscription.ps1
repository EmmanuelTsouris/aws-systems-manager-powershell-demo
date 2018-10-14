
Set-DefaultAWSRegion -Region us-east-1

$snsTopic = New-SNSTopic -Name "Demo-ImageTopic"

Connect-SNSNotification -TopicArn $snsTopic -Protocol 'email' -Endpoint 'someone@somewhere.com'
Connect-SNSNotification -TopicArn $snsTopic -Protocol 'sms' -Endpoint '12065551234'

Publish-SNSMessage -TopicArn $snsTopic -Message 'This is a test!'

<#
    Remove-SNSTopic -TopicArn "arn:aws:sns:us-east-1:542917165768:Demo-ImageTopic" -Force
#>
