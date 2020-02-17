# Prepare

## Login to Azure Portal

You have recieved an email from Microsoft "You're invited to the Team Redhat organization"

Click on the "Get Started" button

![Alt text](pics/01_invite_mail.png?raw=true "Invitation")

On the Microsoft login screen select "Personal Account" and login with your email and password

![Alt text](pics/02_microsoft_login.png?raw=true "Login")

Accept the invitation from "Team RedHat"

![Alt text](pics/03_microsoft_accept.png?raw=true "Accept")

Take a note of your Resource Group, save it in notepad, we will need it later

In the right Pane, Click on Resource groups, your RG will be the one resampling your email

![Alt text](pics/04_resource_group.png?raw=true "Resource Group")

In the top blue bar, click the "powershell" icon marked with red

![Alt text](pics/05_start_cloud_shell.png?raw=true "Cloud Shell")

Select "Show advanced settings"

![Alt text](pics/06_start_cloud_shell_advanced.png?raw=true "Cloud Shell bash")

Set Cloud Shell region to "North Europe"

Resource group: Select Use existing and set it to your Resource group

Storage account: Select Use existing your storage account will be selected, as you only have one

File Share: Create new, give it same name as your storage account

![Alt text](pics/07_start_cloud_shell_advanced_set.png?raw=true "Cloud Shell advanced")

Select "Bash"

![Alt text](pics/08_start_cloud_shell_bash.png?raw=true "Cloud Shell storage")

Cloud shell is now ready

![Alt text](pics/09_start_cloud_shell_ready.png?raw=true "Cloud Shell storage")

In Azure Cloud Shell(Bash)

Note:

You need to type the name of your allocated Azure Resource Group

Type a uniq name for your dns string ()

Username cannot be root/administrator/admin

Password must meet complexity requirements, 3 of 4 types and minumum 12 characters

``` bash
cd clouddrive

git clone https://github.com/jesperberth/automationclass_setup/

cd automationclass_setup

cd azure_class_playbooks

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
