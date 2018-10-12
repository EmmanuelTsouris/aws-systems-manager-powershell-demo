
Set-DefaultAWSRegion -Region us-east-1

#########################################################################
# RunCommand Document to Install Visual Studio Code

# Load the content from the json file
$documentJson = Get-Content .\RunCommandDocuments\Install-VisualStudioCode.json | Out-String

# Create a new document, specifying Command as the DocumentType and passing the content
New-SSMDocument -DocumentType Command -Name "Install-VisualStudioCode" -Content $documentJson

<#
    # To Update the document
    $updatedDocument = Update-SSMDocument -Content $documentJson -Name "Install-VisualStudioCode" -DocumentVersion 2

    # To remove the document
    Remove-SSMDocument -Name "Install-VisualStudioCode" -Force
#>

#########################################################################
# RunCommand Document to Install Microsoft SQL Server Management Studio

# Load the content from the json file
$documentJson = Get-Content .\RunCommandDocuments\Install-SQLManagementStudio.json | Out-String

# Create a new document, specifying Command as the DocumentType and passing the content
New-SSMDocument -DocumentType Command -Name "Install-SQLManagementStudio" -Content $documentJson

<#
    # To Update the document
    $updatedDocument = Update-SSMDocument -Content $documentJson -Name "Install-SQLManagementStudio" -DocumentVersion 2

    # To remove the document
    Remove-SSMDocument -Name "Install-SQLManagementStudio" -Force
#>
