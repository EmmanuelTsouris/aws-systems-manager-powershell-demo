
Set-DefaultAWSRegion -Region us-east-1

##############################################################
# Automation Document to build a Developer Windows Image

# Load the content from the json file
$developerImageJson = Get-Content .\AutomationDocuments\Demo-CreateDeveloperImage.json -Raw

# Create a new document, specifying Automation as the DocumentType and passing the content
New-SSMDocument -Name "Demo-CreateDeveloperImage" -Content $developerImageJson -DocumentType Automation

<#
    # If the document exists, use the update cmdlet
    Update-SSMDocument -Content $developerImageJson -Name "Demo-CreateDeveloperImage" -DocumentVersion '$LATEST'

    # To remove the document
    Remove-SSMDocument -Name "Demo-CreateDeveloperImage" -Force
#>

##############################################################
# Automation Document to build a SQL DBA Windows Image

# Load the content from the json file
$sqlImageJson = Get-Content .\AutomationDocuments\Demo-CreateSqlDevImage.json -Raw

# Create a new document, specifying Automation as the DocumentType and passing the content
New-SSMDocument -Name "Demo-CreateSqlDevImage" -Content $sqlImageJson -DocumentType Automation

<#
    # If the document exists, use the update cmdlet
    Update-SSMDocument -Content $sqlImageJson -Name "Demo-CreateSqlDevImage" -DocumentVersion '$LATEST'

    # To remove the document
    Remove-SSMDocument -Name "Demo-CreateSqlDevImage" -Force
#>
