# Workshop on Chocolatey

## Agenda

* Welcome / Introductions
* Introduction to Chocolatey
* Introduction to Chocolatey for Business
* Exercises 0 - 6 (Setup and Package Creation)
* Review
* Rest of Exercises

## Exercises

### Exercise 0: Setup

It's preferred that you perform all of this exercise from a Vagrant image, but you can follow along with a physical Windows box.

 1. Ensure you have a recent version of [Vagrant](https://downloads.vagrantup.com). It is suggested you have at least 1.8.x for linked clones which makes Windows VMs come up lightning quick. Windows machine - `choco install vagrant -y` (then `refreshenv`).
 1. Pre-download the vagrant box we will be using - `vagrant init ferventcoder/win2012r2-x64-nocm` (this is a 4GB box, about 8GB unpacked).
 1. While that is downloading, ensure you have VirtualBox 5 or 5.1 installed. Windows install is `choco install virtualbox -y`
 1. All the rest of these commands will be done inside the Vagrant box (or box you are using for this).
 1. Place the license you received by email in demo/resources/licenses. Or copy the `chocolatey.license.xml` to `C:\ProgramData\Chocolatey\license` (you will need to create the license folder).
 1. Run `vagrant up` (or `vagrant provision` if already running).
 1. Install the licensed edition of Chocolatey - C4B (Chocolatey for Business):
   * Type `choco install chocolatey.extension -y`
   * If you get curious, check out `choco source list`.
 1. Run the following commands:
   ~~~sh
   choco config set virusScannerType VirusTotal
   choco config set cacheLocation c:\programdata\choco-cache
   choco feature enable -n virusCheck
   choco feature enable -n allowPreviewFeatures
   choco feature enable -n internalizeAppendUseOriginalLocation
   choco feature enable -n reduceInstalledPackageSpaceUsage
   ~~~
 1. Install the latest GUI - `choco install chocolateygui --source https://www.myget.org/F/chocolateygui/ --pre -y --ignore-dependencies` - this may error.
 1. Install Launchy - `choco install launchy -y`
 1. Upgrade Notepad++ - `choco upgrade notepadplusplus -y`
 1. Install baretail - `choco install baretail -y`
 1. Install or upgrade `choco upgrade git -y`
 1. Add the PowerShell profile - type `Set-Content -Path $profile -Encoding UTF8 -Value ""`
 1. Open the profile file and add the following content:

    ~~~powershell
    $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
    if (Test-Path($ChocolateyProfile)) {
      Import-Module "$ChocolateyProfile"
    }
    ~~~
 1. Create a folder for packages - `mkdir packages`
 1. Navigate to the packages folder. All commands from here will be in that packages folder.

### Exercise 1: Install Visual Studio Code
1. Call `choco install visualstudiocode -y`
1. Note the message "Environment Vars have changed".
1. Type `code`. Notice that it errors.
1. Type `refreshenv`.
1. Type `code`. Note that it opens Visual Studio Code.

### Exercise 2: Create a package the old fashioned way
1. Download Google Chrome from https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi and https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise.msi.
1. From a command line, call `choco new googlechrome`
1. Work through the packaging setup to get a functioning unattended deployment.
1. Run `choco pack`
1. Install the package using Chocolatey - `choco install googlechrome -y -s .`

### Exercise 3: Create a package with Package Builder UI
Let's start by packaging up and installing Puppet
 1. Run PowerShell as an administrator
 1. Type `packagebuilder` and hit enter.
 1. Go to http://downloads.puppetlabs.com/windows/puppet5/ (URL: http://downloads.puppetlabs.com/windows/puppet5/puppet-agent-5.0.1-x86.msi - SHA256: 1D1D45FBF8134A70EA3A39F42CA070BD6600B2FA9506B186EBABA20D770858B1 / Url64: http://downloads.puppetlabs.com/windows/puppet5/puppet-agent-5.0.1-x64.msi - SHA256: 992FD379F60C6D57E9E819CFE7EAD423D1C8B547A6994113ECB96A8C0EE6227D)
 1. In the interface that comes up, let's put in the Url and 64-bit Url.
 1. Also pass the SHA for verifying the file is what we hope.
 1. Click the box next to "Don't embed (don't include software binaries in package)?"
 1. Click on Nuspec Information tab.
 1. In id, insert "puppet-agent".
 1. Click Generate
 1. Note that it creates a full package.
 1. Open up the packaging files in code.
 1. Open the nuspec file.
    * Note how auto-detection filled out some of the fields here
    * Optionally we can remove some of the commented sections to tidy this file up and provide more information.
 1. In the chocolateyInstall.ps1, note that it captured all MSI properties and prepared a fully ready to go installation.
    * Also note how it created nice packaging.
    * Optionally we can remove some of the comments and areas we don't need to tidy this up.
 1. Right click on nuspec and select "Compile Chocolatey Package..." / type `choco pack` from that directory.
 1. Copy the resulting file up a directory
 1. Call `choco install puppet-agent -s . -y` (this tells Chocolatey to install from the local source location ".", which is current directory in both PowerShell.exe and Cmd.exe)

### Exercise 4: Create a package with Package Builder (Right Click)

1. Download 1Password from this link - https://d13itkw33a7sus.cloudfront.net/dist/1P/win4/1Password-4.6.0.598.exe (ensure you unblock the file).
1. Right click on the file and choose "Create Chocolatey Package w/out GUI" - **NOTE**: This may error if UAC is on - if so, choose `Create Chocolatey Package...` instead and just click Generate when it comes up.
1. Inspect the output.
1. Let's install this package - `choco install 1password -s . -y --dir c:\programs\1password` (from the working directory where the nupkg is located).
1. Download Charles Proxy (both 32 and 64 bit) - https://www.charlesproxy.com/download/
1. Right click on the 32 bit download and choose "Create Chocolatey Package..."
1. Add the 64bit one into the field.
1. Click generate.
1. Inspect the output.
1. Install this package with `choco install charles -s . -y` (from the working directory where the nupkg is located)
1. Download 7zip - http://www.7-zip.org/download.html (just the 64bit version)
1. Right click and choose "Create Chocolatey Package..."
1. Click Generate.
1. Inspect the output. Note that it doesn't necessarily figure out the silent arguments.
1. Add the proper silent arguments in the install script.
1. Right click on the 7zip nuspec and select "Compile Chocolatey Package..."

### Exercise 5: Create a package with Package Builder CLI
1. Let's create that GoogleChrome package is again.
1. Run `choco new --file googlechromestandaloneenterprise.msi --file64 googlechromestandaloneenterprise64.msi --build-package --outputdirectory $pwd`
1. Inspect the output.

### Exercise 6: Create all the packages
1. Type `packagebuilder`.
1. Change output directory to add "programs" to the path (just to keep things separate). `C:\packages\programs` if you are in the packages folder.
1. Click on the Programs and Features tab.
1. Click `Generate` in that tab.
1. Note the output.
1. Look at package folders that didn't generate a nupkg.

 OR

1. `choco new --from-programs-and-features --build-package --outputdirectory programs`
1. Note the output.
1. Look at package folders that didn't generate a nupkg.

### Exercise 7: Set up a local Chocolatey.Server
1. Ensure IIS and Asp.NET are installed
    * `choco install IIS-WebServer -y --source windowsfeatures`
    * `choco install IIS-ASPNET45 -y --source windowsfeatures`
1. `choco install chocolatey.server -y`
1. Follow instructions at https://chocolatey.org/docs/how-to-set-up-chocolatey-server
1. Go to http://localhost, verify the setup, look at the password.
1. Add this repository to your default sources. Call it `internal_chocolatey` - try `choco source -?` to learn how. Ensure `http://localhost/chocolatey` is the source location you use.

### Exercise 8: Push a package to a Chocolatey Server
1. Run `choco search -s http://localhost/chocolatey`
1. In the folder where we've generated packages, let's find 1Password nupkg.
1. Run `choco push -s http://localhost -k chocolateyrocks` (note the push is different than the query url).
1. Run `choco search -s http://localhost/chocolatey`. Run `choco search -s internal_chocolatey` and note the output should be the same.
1. Note that the package is available.

### Exercise 9: Upgrade a package
1. Download an updated 1Password from this link - https://d13itkw33a7sus.cloudfront.net/dist/1P/win4/1Password-4.6.1.617.exe
1. Use any method for creating packages to generate the packaging for this upgrade. **NOTE**: When you do this, you may need to rename the existing 1Password package folder first.
1. Instead of using Package Builder, you can instead download the file into the tools directory of the current package, edit the nuspec version, delete the previous installer exe, and update the chocolateyInstall.ps1 to point to the new installer and then compile the package.
1. Push this updated package to the Chocolatey server.

### Exercise 10: Install package from Internal Repository
1. Run `choco search 1password -s internal_chocolatey` (or whatever name you passed)
1. Run `choco search 1password -s internal_chocolatey --all-versions`. Note the output.
1. Run `choco search 1password --detailed`. Note the output.
1. Run `choco upgrade 1password -s internal_chocolatey -y`

### Exercise 11: Reporting
1. Run `choco list -lo --include-programs`
1. Note the output.
1. Run `choco outdated`
1. Note the output.

### Exercise 12: Package Synchronizer - Automatic Sync
1. Run `choco list -lo --include-programs`.
1. Go to `C:\ProgramData\Chocolatey\lib`. Note the 1password package.
1. Rename the `C:\ProgramData\Chocolatey\license` folder to `licensed`. This will unlicense Chocolatey.
1. Go to Programs and Features.
1. Manually uninstall 1Password.
1. Run `choco list -lo --include-programs`. Note if 1password package is still there.
1. Rename the `C:\ProgramData\Chocolatey\licensed` folder to `license`. This will license Chocolatey.
1. Run `choco list -lo --include-programs`. Note if 1password package is still there.
1. Look for a lib-synced folder in `C:\ProgramData\Chocolatey`.
1. Note the contents.

### Exercise 13: Package Synchronizer - Choco Sync
1. Go to `C:\ProgramData\chocolatey\.chocolatey` and delete the 7zip folder if it exists. Otherwise delete the 1password folder (these folders will have a version after them).
1. Run `choco list -lo --include-programs`.
1. Note any applications not being managed as Chocolatey packages.
1. Run `choco sync` - **NOTE**: If this errors, make sure you've turned on allowPreviewFeatures from exercise 0 to allow this feature to work.
1. Note how it relinks 7zip or 1password to an existing installed package. This is recreating a lost link.
1. Note that it is syncing with new packages for the rest of the items.
1. Go to the temp directory to see the packaging it created.
1. Run `choco list -lo --include-programs`.
1. Note any applications not being managed as Chocolatey packages.

### Exercise 14: Internalize AdobeReader package
1. Run `choco feature list`. Determine if `internalizeAppendUseOriginalLocation` is on. Turn it on otherwise.
1. Call `choco download adobereader --internalize`.
1. While it is downloading, head into the download folder it created.
1. Open the chocolateyInstall.ps1 in Notepad++ or Code.
1. Note the url variable.
1. When it finishes downloading and creating the package, note how that changes.
1. Note that there is a files folder that contains the binaries.
1. Note how it has appended `-UseOriginalLocation` to the end of `Install-ChocolateyPackage`.

### Exercise 15: Internalize Notepad++ package
1. Run `choco feature list`. Determine if `internalizeAppendUseOriginalLocation` is on. Turn it on otherwise.
1. Call `choco download notepadplusplus --internalize --resources-location http://somewhere/internal` (literally).
1. While it is downloading, head into the download folder it created.
1. Open the `tools\chocolateyInstall.ps1` in Notepad++ or Code.
1. Note the url variable.
1. When it finishes downloading and creating the package, note how that changes.
1. Note how it appended `UseOriginalLocation` in this case.

### Exercise 16: Download Chocolatey and Licensed packages
To have a completely offline install for packaging, you need to remove

1. Run `choco source list` to see your sources.
1. Run `choco source disable -n chocolatey`
1. Run `choco download chocolatey -s https://chocolatey.org/api/v2/`
1. Run `choco download chocolatey.server -s https://chocolatey.org/api/v2/`
1. Run `choco download chocolatey.extension --ignore-dependencies --source https://licensedpackages.chocolatey.org/api/v2/`
1. Run `choco download chocolatey-agent --ignore-dependencies --source https://licensedpackages.chocolatey.org/api/v2/`
1. Run `choco source disable -n chocolatey.licensed` - **NOTE**: When you have a licensed version of Chocolatey, you are unable to remove this source. It can be disabled though. Also, once this is disabled, you would need your license id as the password you would pass to the licensed source in the previous steps.
1. Push all of these packages to your internal server.
1. You are now using Chocolatey with internal only packages.

### Exercise 17: Create an extension package
We are going to create a package that checks for prerequisites prior to the install, such as ensuring at least 1 GB of free space.

1. Run `choco new prerequisites.extension`
1. Delete the `prerequisites.extension\tools` directory.
1. Create an `extensions` directory.
1. Create a file called `prerequisites.psm1` in the extensions directory.
1. Add this to the contents:

    ~~~powershell
    # Export functions that start with capital letter, others are private
    # Include file names that start with capital letters, ignore others
    $ScriptRoot = Split-Path $MyInvocation.MyCommand.Definition

    $pre = ls Function:\*
    ls "$ScriptRoot\*.ps1" | ? { $_.Name -cmatch '^[A-Z]+' } | % { . $_  }
    $post = ls Function:\*
    $funcs = compare $pre $post | select -Expand InputObject | select -Expand Name
    $funcs | ? { $_ -cmatch '^[A-Z]+'} | % { Export-ModuleMember -Function $_ }
    ~~~
1. Create a file `Ensure-ThreeGBs.ps1` and add the following contents:

    ~~~powershell
    <#
      .SYNOPSIS
      Ensures that there is at least 3 GB of space left on a machine or it will not allow installation

      .OUTPUTS
      [String]
    #>
    function Ensure-ThreeGBs {
      Write-Debug "Running Get-AvailableDiskSpace to determine if there is enough space for installation."

      $disk = Get-PSDrive C | Select-Object Used,Free
      Write-Host "There is $($disk.Free) available"

      $ThreeGBs = 3221225472
      if ($disk.Free -lt $ThreeGBs) {
        throw "There is less than 3GB of free space left."
      }

      return $disk.Free
    }
    ~~~
1. Update the nuspec appropriately. Ensure the version is at least `0.0.1`.
1. In the nuspec, change `<file src="tools\**" target="tools" />` to `<file src="extensions\**" target="extensions" />`.
1. Run `choco pack` against the directory with `prerequisites.extension.nuspec`.
1. Copy the nupkg file up to the packages directory.
1. Now head into the 1Password package from exercise and open `tools\chocolateyInstall.ps1`.
1. On line 1, add the following: `Ensure-ThreeGBs`. Save and close.
1. Open up `1password.nuspec` and add a dependency on the prerequisites.extension package (right before `</metadata>`):

    ~~~xml
    <dependencies>
      <dependency id="prerequisites.extension" version="0.0.1" />
    </dependencies>
    ~~~
1. Compile the 1password package back up and put it in the folder next to the `prerequisites.extension` nupkg.
1. Run `choco install 1password -s . -y`. **NOTE**: We uninstalled this with auto sync in an earlier exercise.
1. Note in the install how it automatically loads up the prerequisites functions and makes them available without any more work on the part of the installation scripts.

### Exercise 18: Create a package template for MSIs
1. Run `choco new msi.template`.
1. Delete the `msi.template\tools` directory.
1. Create `templates\msi.nuspec.template` and add the following contents:

    ~~~powershell
    <?xml version="1.0" encoding="utf-8"?>
    <package xmlns="http://schemas.microsoft.com/packaging/2015/06/nuspec.xsd">
      <metadata>
        <id>[[PackageNameLower]]</id>
        <title>[[PackageName]] (Install)</title>
        <version>[[PackageVersion]]</version>
        <authors>Original authors</authors>
        <owners>[[MaintainerName]]</owners>
        <description>__REPLACE__MarkDown_Okay [[AutomaticPackageNotesNuspec]]
        </description>
        <tags>[[PackageNameLower]] admin</tags>
        <!--<dependencies>
          <dependency id="" version="__VERSION__" />
          <dependency id="" />
        </dependencies>-->
      </metadata>
      <files>
        <file src="tools\**" target="tools" />
      </files>
    </package>
    ~~~
1. Create `templates\tools\chocolateyInstall.ps1` and add the following contents:

    ~~~powershell
    $ErrorActionPreference = 'Stop';
    $packageName= '[[PackageName]]'
    $toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
    $fileLocation = Join-Path $toolsDir 'NAME_OF_EMBEDDED_INSTALLER_FILE'

    $packageArgs = @{
      packageName   = $packageName
      unzipLocation = $toolsDir
      fileType      = 'msi'
      file         = $fileLocation
      softwareName  = '[[PackageName]]*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
      silentArgs    = "/qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
      validExitCodes= @(0, 3010, 1641)
    }

    Install-ChocolateyInstallPackage @packageArgs
    ~~~
1. Open `msi.template.nuspec` and edit it appropriately. Set the version to `1.0.0`.
1. In the nuspec, change `<file src="tools\**" target="tools" />` to `<file src="templates\**" target="templates" />`.
1. Call `choco pack`.
1. Now we can push this up to our package server.
1. Let's install this template - `choco install msi.template -s internal_chocolatey`.

### Exercise 19: Create a package from a template
1. Run `choco new bob -t msi`.
1. Head into the bob folder.
1. Note how it does replacements of all of the `[[variables]]`

### Exercise 20: Update a packaging template / use custom properties
1. Let's add a new variable.
1. Open `msi.template\templates\tools\chocolateyInstall.ps1`
1. Add the following at the top: `# [[CustomVariable]]`
1. Save and close that file.
1. Open `msi.template.nuspec` and increase the version to `1.0.1` .
1. Close that, package it up and push it up to the server again.
1. Run `choco upgrade msi.template -s internal_chocolatey`.
1. Now run `choco new tim -t msi CustomVariable="Yes"`
1. Note the output in the tim folder that is created.

### Exercise 21: Use package parameters
1. Run `choco new packagewithparameters`
1. Remove everything but the nuspec and `tools\chocolateyInstall.ps1`.
1. In the nuspec, take a dependency on `chocolatey-core.extension` version `[1,3)` (which means at least v1, but anything less than v3).
1. In the `chocolateyInstall.ps1`, delete everything and just add the following:

    ~~~powershell
    $pp = Get-PackageParameters

    if (!$pp['LICENSE']) { $pp['LICENSE'] = 'License123' }
    #if (!$pp['LICENSE']) { $pp['LICENSE'] = Read-Host "Please provide LICENSE" }

    Write-Warning "LICENSE = '$($pp['LICENSE'])'"
    ~~~
1. Package up the package and push it to your internal server.
1. Ensure the chocolatey-core.extension package is up on the internal server as well.
1. Run `choco install packagewithparameters -s internal_chocolatey --params "'/LICENSE:Yes'"` and note the output.

### Exercise 22: Use AutoHotKey for craptastic installers
