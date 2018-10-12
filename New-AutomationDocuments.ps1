
Set-DefaultAWSRegion -Region us-east-1

##############################################################
# Automation Document to build a Developer Windows Image

# Load the content from the json file
$developerImageJson = Get-Content .\AutomationDocuments\Build-DeveloperImage.json -Raw

# Create a new document, specifying Automation as the DocumentType and passing the content
New-SSMDocument -Name "Build-DeveloperImage" -Content $developerImageJson -DocumentType Automation

<#
    # If the document exists, use the update cmdlet
    Update-SSMDocument -Content $developerImageJson -Name "Build-DeveloperImage" -DocumentVersion '$LATEST'

    # To remove the document
    Remove-SSMDocument -Name "Build-DeveloperImage" -Force
#>

##############################################################
# Automation Document to build a SQL DBA Windows Image

# Load the content from the json file
$sqlImageJson = Get-Content .\AutomationDocuments\Build-SqlDbaImage.json -Raw

# Create a new document, specifying Automation as the DocumentType and passing the content
New-SSMDocument -Name "Build-SqlDbaImage" -Content $sqlImageJson -DocumentType Automation

<#
    # If the document exists, use the update cmdlet
    Update-SSMDocument -Content $sqlImageJson -Name "Build-SqlDbaImage" -DocumentVersion '$LATEST'

    # To remove the document
    Remove-SSMDocument -Name "Build-SqlDbaImage" -Force
#>
