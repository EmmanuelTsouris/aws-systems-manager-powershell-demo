# aws-systems-manager-powershell-demo
A project demonstrating AWS Systems Manager features using the AWSPowerShell SDK.

This demo will create the following resources in your AWS Account:

Two AWS Systems Manager RunCommand Documents:
- Install-VisualStudioCode: Downloads and silently installs Visual Studio Code.
- Install-SQLManagementStudio: Downloads and silently installs SQL Management Studio.

Two AWS Systems Manager Automation Documents:
- Demo-CreateDeveloperImage: Creates a new Windows Server 2016 Image with Visual Studio Code installed.
- Demo-CreateSqlDevImage: Creates a new Windows Server 2016 Image with Visual Studio Code and Microsoft SQL Management Studio installed.

## Getting Started
To get started, take a look at the json in Set-ParameterStoreValues.ps1, this will create the necessary Parameter Store values. Edit the defaults with your own IAM Instance Profile, Security Group Id, Subnet Id, preferred Instance Type, etc. The default base image is set to be the latest Windows Server 2016 image from AWS.
```
Set-ParameterStoreValues.ps1
```

## Learn More with these Resources

### AWS Systems Manager Console
https://aws.amazon.com/systems-manager/

### AWS Systems Manager Documents on GitHub
https://github.com/awslabs/aws-systems-manager/tree/master/Documents/

