
# Sample Code to Install-SSMS
# This is the code we'll use in the run command document to install SQL Server Management Studio

# This will prevent the Invoke-WebRequest from failing on some version of Windows Server
# https://stackoverflow.com/questions/25143946/powershell-3-0-invoke-webrequest-https-fails-on-all-requests/25163476#25163476
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# This id the download url for the 64bit System Setup,
# you can find the download link on the vscode website.
$downloadUrl = 'https://go.microsoft.com/fwlink/?linkid=2014306'

# Name and path for the downloaded file
$installerFile = 'SSMS-Setup-ENU.exe'
$installerDownloadPath = (Join-Path $env:TEMP $installerFile)

# Silent Install and Skip Reboot
$installerArguments = '/install /quiet /passive /norestart'

Write-Host "Downloading $downloadUrl to $installerFile."
Invoke-Webrequest $downloadUrl -UseBasicParsing -OutFile $installerDownloadPath

Write-Host "Installing $installerDownloadPath."
Start-Process $installerDownloadPath -ArgumentList $installerArguments -Wait

Write-Host "Cleanup the downloaded file."
Remove-Item $installerDownloadPath -Force
