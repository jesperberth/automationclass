# Prepare

## Login to Azure Portal

Login to Azure

In your browser go to [http://portal.azure.com](http://portal.azure.com)

__Note:__ Run the browser in Incognito/Private mode to avoid issues with cashed credentials

![Alt text](pics/01_azure_login.png?raw=true "Azure login")

In the top bar, click the "cloudshell" icon marked with red

![Alt text](pics/05_start_cloud_shell.png?raw=true "Cloud Shell")

Select Bash

![Alt text](pics/05_start_cloud_shell_bash.png?raw=true "Cloud Shell Bash")

Select "Show advanced settings"

![Alt text](pics/06_start_cloud_shell_advanced.png?raw=true "Cloud Shell bash")

Set Cloud Shell region to __"North Europe"__

Resource group: Select Use existing and set it to your Resource group __userX-ansible__

Storage account: Select Use existing your storage account will be selected, as you only have one

File Share: Select existing __userXansible__

![Alt text](pics/07_start_cloud_shell_advanced_set.png?raw=true "Cloud Shell advanced")

Cloud shell is now ready

![Alt text](pics/09_start_cloud_shell_ready.png?raw=true "Cloud Shell storage")

In Azure Cloud Shell(Bash)

```bash

cd

virtualenv ansible

source ansible/bin/activate

pip install ansible

ansible-galaxy collection install azure.azcollection

pip install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt

```

__Note:__

Username cannot be __root/administrator/admin/user/guest/owner/adm__

__Use your initials as username__ eg. jesbe

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

cd automation_class

git pull

cd automationclass_setup

cd azure

ansible-galaxy install -r requirements.yml

ansible-playbook 00_azure_class_setup.yml
```

![Alt text](pics/10_git_pull.png?raw=true "Git Pull - ansible-playbook")

The playbook will create all resources needed for the Automation class - Lab 01 -> Lab 05

![Alt text](pics/11_lab_ready.png?raw=true "Labs are ready")

## SSH Clients

We will use ssh to connect to the ansible server

### Windows

Windows 10 has openSSH preinstalled, just open a CMD or Powershell consol and type ssh user@hostname

As an option you can install Windows Terminal, which will add tabs and many other options

[Download Windows Terminal](https://github.com/microsoft/terminal)

![Alt text](pics/12_winterminal.png?raw=true "Windows Terminal SSH")

Putty is a well known ssh client for most platforms

[Download Putty](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

Go back to the lab guide

[Lab Guide](README.md)
