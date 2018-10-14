
# Learn more
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html

# Set the AWS region
Set-DefaultAWSRegion -Region us-east-1

# This policy allows the AWS Systems Manager service (ssm.amazonaws.com) to assume the role we'll create.
$assumeRolePolicy = @"
{
    "Version": "2012-10-17",
    "Statement": {
        "Effect": "Allow",
        "Principal": {
            "Service": [
                "ec2.amazonaws.com",
                "ssm.amazonaws.com"
            ]
        },
        "Action": "sts:AssumeRole"
    }
}
"@

# Create the role and apply the assume role policy json
$role = New-IAMRole -RoleName "DemoSSMRole" -AssumeRolePolicyDocument $assumeRolePolicy

# Add the AmazonEC2RoleforSSM managed policy.
Register-IAMRolePolicy -RoleName $role.RoleName -PolicyArn 'arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM'

# Add the CloudWatch Managed Policy.
Register-IAMRolePolicy -RoleName $role.RoleName -PolicyArn 'arn:aws:iam::aws:policy/CloudWatchFullAccess'

# Create an instance profile that can be attached to an Amazon EC2 instance
$instanceProfile = New-IAMInstanceProfile -InstanceProfileName "DemoSSMInstanceProfile"

# Finally, add the role to the instance profile
Add-IAMRoleToInstanceProfile -InstanceProfileName $instanceProfile.InstanceProfileName -RoleName $role.RoleName

<#

# View what we've created

Get-IAMRole -RoleName "DemoSSMRole"
Get-IAMAttachedRolePolicies -RoleName "DemoSSMRole"
Get-IAMInstanceProfile -InstanceProfileName "DemoSSMInstanceProfile"

#>

<#

# Remove the policies, role, and instance profile:

# 1. Unregister the IAM Role Policy
Unregister-IAMRolePolicy -PolicyArn 'arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM' -RoleName "DemoSSMRole"
Unregister-IAMRolePolicy -PolicyArn 'arn:aws:iam::aws:policy/CloudWatchFullAccess' -RoleName "DemoSSMRole"

# 2. Remove the role from the instance profile
Remove-IAMRoleFromInstanceProfile -RoleName "DemoSSMRole" -InstanceProfileName "DemoSSMInstanceProfile" -Force

# 3. Remove the Role
Remove-IAMRole -RoleName "DemoSSMRole" -Force

# 4. Remove the instance profile
Remove-IAMInstanceProfile -InstanceProfileName "DemoSSMInstanceProfile" -Force

#>
