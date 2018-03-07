& curl.exe -O https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi
& curl.exe -O https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise.msi
& curl.exe -O http://downloads.puppetlabs.com/windows/puppet5/puppet-agent-5.3.3-x86.msi
& curl.exe -O http://downloads.puppetlabs.com/windows/puppet5/puppet-agent-5.3.3-x64.msi
& curl.exe -O https://d13itkw33a7sus.cloudfront.net/dist/1P/win4/1Password-4.6.0.598.exe
& curl.exe -O https://d13itkw33a7sus.cloudfront.net/dist/1P/win4/1Password-4.6.1.617.exe

& curl.exe -L -O http://www.7-zip.org/a/7z1801-x64.exe
& curl.exe -L -O http://www.7-zip.org/a/7z1801-x64.msi
# get from main machine https://www.charlesproxy.com/download/
# get from main machine http://www.7-zip.org/download.html

choco download baretail chocolatey chocolatey-agent chocolatey.extension chocolateygui chocolatey.server   dotnet4.5.2 dotnet4.6.1 git launchy notepadplusplus visualstudiocode virtualbox --force --internalize  --internalize-all-urls --append-use-original-location --output-directory=..\..\packages
