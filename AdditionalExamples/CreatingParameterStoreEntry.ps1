
Set-DefaultAWSRegion -Region us-east-1

# Writing a parameter
Write-SSMParameter -Name "/Path/To/MyParameterStoreItem" -Value "MyValue1" -Description "Test" -Type String

# Getting a value from Parameter Store
Get-SSMParameter -Name "/Path/To/MyParameterStoreItem"

<#

# If you need to overwrite the parameters, include -Overwrite $true
Write-SSMParameter -Name "/Path/To/MyParameterStoreItem" -Value "MyValue2" -Description "A test parameter" -Type String -Overwrite $true

# Remove the parameter
Remove-SSMParameter -Name "/Path/To/MyParameterStoreItem" -Force

# Remove all parameters matching a given path
Get-SSMParametersByPath -Path "/Path/To/MyParameterStoreItem" | Remove-SSMParameter -Force

#>
