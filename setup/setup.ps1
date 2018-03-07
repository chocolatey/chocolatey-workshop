
Function Get-Folder($initialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") > $null

    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.rootfolder = "MyComputer"

    if($foldername.ShowDialog() -eq "OK")
    {
        $folder += $foldername.SelectedPath
    }

    return $folder
}

$title = "Physical or Virtual"
$message = "Are you using your physical machine for the workshop, or you you want to use a Virtual Image?"

$physical = New-Object System.Management.Automation.Host.ChoiceDescription "&Physical", `
    "You are going to use your own machine, and have necessary for the Workshop"

$virtual = New-Object System.Management.Automation.Host.ChoiceDescription "&Virtual", `
    "You want to use a Virtual Machine for the workshop"

$options = [System.Management.Automation.Host.ChoiceDescription[]]($physical, $virtual)

$result = $host.ui.PromptForChoice($title, $message, $options, 0)

switch ($result)
{
    0
    {
        "You are using a Physical Machine..."
    }
    1
    {
        $title = "Vagrant Installed?"
        $message = "Do you have Vagrant installed?"

        $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
            "You already have Vagrant installed, and no further again will be taken."

        $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
            "You don't have Vagrant installed, and an attempt will be made to install it."

        $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

        $result = $host.ui.PromptForChoice($title, $message, $options, 0)

        switch ($result)
        {
            0
            {
                choco install vagrant --source "chocolatey-workshop/setup"
            }
            1
            {
                "You said you have Vagrant installed"
            }
        }

        $title = "Vagrant Provider"
        $message = "Would you like to use a pre-setup Vagrant Image? If so, which provider would you like to use?"

        $virtualbox = New-Object System.Management.Automation.Host.ChoiceDescription "&Virtual Box", `
            "Use the Virtual Box Vagrant Provider."

        $hyperv = New-Object System.Management.Automation.Host.ChoiceDescription "&Hyper-V", `
            "Use the Hyper-V Vagrant Provider."

        $none = New-Object System.Management.Automation.Host.ChoiceDescription "&None", `
            "You have your own virtual machine image that you would like to use."

        $options = [System.Management.Automation.Host.ChoiceDescription[]]($virtualbox, $hyperv, $none)

        $result = $host.ui.PromptForChoice($title, $message, $options, 0)

        switch ($result)
        {
            0
            {
                vagrant box add --provider virtualbox --name ferventcoder/win2012r2-x64-nocm "vagrant_boxes/win2012r2-x64-vbox4216-nocm.box"
            }
            1
            {
                Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
                vagrant box add --provider hyperv --name "vagrant_boxes/win2012r2-x64-hyperv-nocm.box"
            }
            2
            {
                "Nothing to do here :-)"
            }
        }
    }
}

Write-Host "Where do you want to copy workshop files to?"

$targetFolder = Get-Folder
Copy-Item -Path "chocolatey-workshop/*" -Destination $targetFolder.FullName -Recurse -Verbose -ErrorAction $ErrorActionPreference
