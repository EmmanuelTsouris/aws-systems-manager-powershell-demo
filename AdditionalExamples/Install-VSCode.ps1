
# Sample Code to Install-VSCode
# This is the code we'll use in the run command document to install Visual Studio Code

# This id the download url for the 64bit System Setup,
# you can find the download link on the vscode website.
$downloadUrl = "https://go.microsoft.com/fwlink/?Linkid=852157"

"https://go.microsoft.com/fwlink/?Linkid=852157"

# Name and path for the downloaded file
$installerFile = "vscode-install.exe"
$installerDownloadPath = (Join-Path $env:TEMP $installerFile)

# Install Options
# Include the context menu, file association, and add to path options (and don't run code after install: 
$installerArguments = "/verysilent /mergetasks='!runcode,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath'"

Write-Host "Downloading $downloadUrl to $installerFile."
Invoke-Webrequest $downloadUrl -UseBasicParsing -OutFile $installerDownloadPath

Write-Host "Installing $installerDownloadPath."
Start-Process $installerDownloadPath -ArgumentList $installerArguments -Wait

Write-Host "Cleanup the downloaded file."
Remove-Item $installerDownloadPath -Force
