
# Learn more
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html

# Set the AWS region
$region = "us-east-1"

# This policy allows the AWS Systems Manager service (ssm.amazonaws.com) to assume the role we'll create.
$assumeRolePolicy = @"
{
    "Version": "2012-10-17",
    "Statement": {
        "Effect": "Allow",
        "Principal": {
            "Service": "ssm.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    }
}
"@

# Create the role and apply the assume role policy json
$role = New-IAMRole -RoleName "DemoSSMRole" -AssumeRolePolicyDocument $assumeRolePolicy -Region $region

# Register the managed AmazonEC2RoleforSSM policy to the role.
Register-IAMRolePolicy -RoleName $role.RoleName -PolicyArn 'arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM' -Region $region

# Create an instance profile that can be attached to an Amazon EC2 instance
$instanceProfile = New-IAMInstanceProfile -InstanceProfileName "DemoSSMInstanceProfile" -Region $region

# Finally, add the role to the instance profile
Add-IAMRoleToInstanceProfile -InstanceProfileName $instanceProfile.InstanceProfileName -RoleName $role.RoleName -Region $region

<#

# To remove the role and instance profile:

# Unregister the IAM Role Policy
Unregister-IAMRolePolicy -PolicyArn 'arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM' -RoleName "DemoSSMRole" -Region $region

# Get and remove the Role
Get-IAMRole -RoleName "DemoSSMRole" -Region $region | Remove-IAMRole -Region $region

# Get and remove the instance profile
Get-IAMInstanceProfile -InstanceProfileName "DallasDemoInstanceProfile" -Region $region | Remove-IAMInstanceProfile -Region $region

#>
