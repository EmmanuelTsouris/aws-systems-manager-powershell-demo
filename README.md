# AWS Systems Manager PowerShell Demo
A project demonstrating AWS Systems Manager Parameter Store, RunCommand, and Automation Documents using the AWSPowerShell SDK.

This demo will create the following resources in your AWS Account:

Two AWS Systems Manager RunCommand Documents:
- Install-VisualStudioCode: Downloads and silently installs Visual Studio Code.
- Install-SQLManagementStudio: Downloads and silently installs SQL Management Studio (SSMS) 17.9.

Two AWS Systems Manager Automation Documents:
- Demo-CreateDeveloperImage: Creates a new Windows Server 2016 Image with Visual Studio Code installed.
- Demo-CreateSqlDevImage: Creates a new Windows Server 2016 Image with Visual Studio Code and Microsoft SQL Management Studio installed.

## Getting Started

### Configure Parameters
To get started, take a look at the json in Set-ParameterStoreValues.ps1, this will create the necessary Parameter Store values. Edit the defaults with your own IAM Instance Profile, Security Group Id, Subnet Id, preferred Instance Type, etc. The default base image is set to be the latest Windows Server 2016 image from AWS.
```
Set-ParameterStoreValues.ps1
```

### Create a new SNS Topic for Monitoring
The SNS topic is an optional step and isn't required to use the RunCommand or Automation documents. This allows you to monitor progress via email or sns.
First, create the topic:
```
$snsTopic = New-SNSTopic -Name "Demo-SystemsManagerTopic"
```
Now subscribe email or sms to the topic you just created:
```
Connect-SNSNotification -TopicArn $snsTopic -Protocol 'email' -Endpoint 'someone@somewhere.com'
Connect-SNSNotification -TopicArn $snsTopic -Protocol 'sms' -Endpoint '12065551234'
```

Test the SNS Topic:
```
Publish-SNSMessage -TopicArn $snsTopic -Message 'This is a test!'
```

### Setup Automation Execution Status Monitoring via a CloudWatch Event Rule
```
Write-AutomationStatusMonitoring.ps1 -SNSTopic $snsTopic
```

### Setup Automation Step Status Monitoring via a CloudWatch Event Rule
```
Write-AutomationStepMonitoring.ps1 -SNSTopic $snsTopic
```

### Create the RunCommand Documents
Creates RunCommand documents from .\RunCommandDocuments\Install-VisualStudioCode.json and .\RunCommandDocuments\Install-SQLManagementStudio.json
```
New-RunCommandDocuments.ps1
```

### Create the Automation Documents
Creates Automation documents from .\AutomationDocuments\Demo-CreateDeveloperImage.json and .\AutomationDocuments\Demo-CreateSqlDevImage.json
```
New-AutomationDocuments.ps1
```

### Kick off the Automation and build some Images!
```
Start-AutomationDocuments.ps1
```

## Learn More with these Resources

### Setting up the AWS Tools for PowerShell
https://docs.aws.amazon.com/powershell/latest/userguide/pstools-getting-set-up-windows.html 

### AWS Systems Manager Console
https://aws.amazon.com/systems-manager/

### AWS Systems Manager Documents on GitHub
https://github.com/awslabs/aws-systems-manager/tree/master/Documents/

