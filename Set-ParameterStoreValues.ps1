
Set-DefaultAWSRegion -Region us-east-1

$valuesJson = @"
[
    {
        "Name": "/Test/AutomationDemo/ImageName",
        "Value": "Windows_Server-2016-CustomImage",
        "Description": "The name of our new image.",
        "Type": "String"
    },
    {
        "Name": "/Test/AutomationDemo/ImageDescription",
        "Value": "Windows Server 2016 with applications installed.",
        "Description": "A description of the image we're creating.",
        "Type": "String"
    },
    {
        "Name": "/Test/AutomationDemo/IAMInstanceProfile",
        "Value": "DemoSSMInstanceProfile",
        "Description": "An IAM instance profile to attach. Required for Systems Manager functionality.",
        "Type": "String"
    },
    {
        "Name": "/Test/AutomationDemo/OutputS3BucketName",
        "Value": "demo-output-bucket",
        "Description": "An S3 bucket where Run Command output will be stored.",
        "Type": "String"
    },
    {
        "Name": "/Test/AutomationDemo/InstanceType",
        "Value": "m5.large",
        "Description": "Instance type to use for the Amazon EC2 instance.",
        "Type": "String"
    },
    {
        "Name": "/Test/AutomationDemo/SubnetId",
        "Value": "subnet-12345678",
        "Description": "Subnet to use for the Amazon EC2 instance.",
        "Type": "String"
    },
    {
        "Name": "/Test/AutomationDemo/SecurityGroupIds",
        "Value": "sg-12345678",
        "Description": "Security Groups to assign to the Amazon EC2 instance.",
        "Type": "StringList"
    },
    {
        "Name": "/Test/AutomationDemo/CloudWatchLogGroup",
        "Value": "DemoLogGroup",
        "Description": "The CloudWatch Log Group to send logs to.",
        "Type": "String"
    }
]
"@


# Cleanup & Remove Parameters
$parameterStoreValues = $valuesJson | ConvertFrom-Json

foreach ($param in $parameterStoreValues) {
    # Create the parameter, and overwrite it if it exists. Overwriting incremenets the version number. Old versions are still available.
    Write-Host "Creating $($param.Name)"
    Write-SSMParameter -Name $param.Name  -Value $param.Value -Description $param.Description -Type $param.Type -Overwrite $true
}


<#

# Remove all the parameters for the given path
Get-SSMParametersByPath -Path "/Test/AutomationDemo/" | Remove-SSMParameter -Force

#>
