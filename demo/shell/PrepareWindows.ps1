$licenseFile = 'c:\vagrant\resources\licenses\chocolatey.license.xml'
$licenseDirectory = 'c:\ProgramData\chocolatey\license'

if ((Test-Path $licenseFile) -and !(Test-Path $licenseDirectory)) {
  Write-Host "Copying license file"
  $null = New-Item -Path "$licenseDirectory" -ItemType Directory -Force
  Copy-Item $licenseFile $licenseDirectory -Force
}

if (!(Test-Path ('c:\vagrant\packages'))) { New-Item 'c:\vagrant\packages' -ItemType 'Directory' }

if (!(Test-Path ('c:\packages'))) { New-Item 'c:\packages' -ItemType 'Directory' }
