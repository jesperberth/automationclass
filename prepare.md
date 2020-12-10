# Prepare

## Login to Azure Portal

Login to Azure

In your browser go to [http://portal.azure.com](http://portal.azure.com)

__Note:__ Run the browser in Incognito/Private mode to avoid issues with cashed credentials

![Alt text](pics/01_azure_login.png?raw=true "Azure login")

In the top blue bar, click the "powershell" icon marked with red

![Alt text](pics/05_start_cloud_shell.png?raw=true "Cloud Shell")

Select Bash

![Alt text](pics/05_start_cloud_shell_bash.png?raw=true "Cloud Shell Bash")

Select "Show advanced settings"

![Alt text](pics/06_start_cloud_shell_advanced.png?raw=true "Cloud Shell bash")

Set Cloud Shell region to __"North Europe"__

Resource group: Select Use existing and set it to your Resource group __userx-ansible__

Storage account: Select Use existing your storage account will be selected, as you only have one

File Share: Create new, give it same name as your storage account

![Alt text](pics/07_start_cloud_shell_advanced_set.png?raw=true "Cloud Shell advanced")

Cloud shell is now ready

![Alt text](pics/09_start_cloud_shell_ready.png?raw=true "Cloud Shell storage")

In Azure Cloud Shell(Bash)

__Note:__

You need to type the name of your allocated Azure Resource Group

Username cannot be __root/administrator/admin/user/guest/owner/adm__

__Use your initials as username__

Password must be complex

Be between 12 and 123 characters

* Have lower characters
* Have upper characters
* Have a digit
* Have a special character (Regex match [\W_])

__Note:__

Password will be visible on the screen

``` bash
cd clouddrive

git clone https://github.com/jesperberth/automationclass_setup/

cd automationclass_setup

cd azure

ansible-galaxy install -r requirements.yml

ansible-playbook 00_azure_class_setup.yml
```

![Alt text](pics/10_git_pull.png?raw=true "Git Pull - ansible-playbook")

The playbook will create all resources needed for the Automation class - Lab 01 -> Lab 04

![Alt text](pics/11_lab_ready.png?raw=true "Labs are ready")

## SSH Clients

Putty is a well known ssh client for most platforms

[Download Putty](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

Windows 10 has openSSH preinstalled, just open a CMD or Powershell consol and type ssh user@hostname

Recomended for Windows

Download Microsoft Powershell Core 6

[Download Powershell Core](https://github.com/PowerShell/PowerShell/releases/tag/v6.2.3)

Go back to the lab guide

[Lab Guide](README.md)
