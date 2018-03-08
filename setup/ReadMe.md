# Offline Workshop Setup

1. Download the following and place them in this folder:
 * Vagrant 1.9.x MSI (Windows) / DMG (MacOS)
 * Vagrant 2.x  MSI (Windows) / DMG (MacOS)
 * VirtualBox 5.x Exe (Windows) / DMG (MacOS)
1. On a machine where you have Chocolatey MSP or C4B, open a PowerShell Admin and go to the `demo\resources\installers` directory and run `.\download.ps1` - you will need a commercial edition of Chocolatey installed for it to be successful (MSP/C4B required).
1. Prepare a trial license file if necessary for folks coming to workshop. Give them about 10 days after the workshop to continue playing. Put that in the `demo\resources\licenses\` folder as `chocolatey.license.xml`.
1. All of what you have goes onto a USB key along with the vagrant boxes.
1. USB Drive: Create a directory called `chocolatey-workshop`. Copy everything here into that directory.
1. USB: Pull the setup.bat/setup.ps1 out of the setup directory and to the root directory next to chocolatey-workshop.
1. USB: Create a directory called `vagrant_boxes`.
1. USB: Copy the vagrant boxes (.box files) directly there. You may also want to put MD5 checksums there as well.
