$ChocoInstallPath = "$env:SystemDrive\ProgramData\chocolatey\bin"
$env:Path += ";$ChocoInstallPath"

if (!(Test-Path $ChocoInstallPath)) {
  # Install Chocolatey
  Invoke-Expression ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
}
