# Lab 1: Install Ansible

In this session we will install ansible on server __ansible__, and connect to linux - __server1__ and windows - __server3__

We will use server __ansible__ to run the first part of the training

## Table of Contents

- [Prepare](#prepare)
- [Task 1 Deploy Lab](#task-1-deploy-lab)
- [Task 2 Install Ansible](#task-2-install-ansible)
- [Task 3 Run ansible command](#task-3-run-ansible-command)
- [Task 4 Connect Linux host](#task-4-connect-linux-host)
- [Task 5 Connect Windows Host](#task-5-connect-windows-host)
- [Task 6 Ansible Collections](#task-6-ansible-collections)

## Task 1 Deploy Lab

Login to Azure

In your browser go to [http://portal.azure.com](http://portal.azure.com)

__Note:__ Run the browser in Incognito/Private mode to avoid issues with cashed credentials

![Alt text](images/01_azure_login.png?raw=true "Azure login")

In the top bar, click the "cloudshell" icon marked with red

![Alt text](images/05_start_cloud_shell.png?raw=true "Cloud Shell")

Select Bash

![Alt text](images/05_start_cloud_shell_bash.png?raw=true "Cloud Shell Bash")

Select "Show advanced settings"

![Alt text](images/06_start_cloud_shell_advanced.png?raw=true "Cloud Shell bash")

Set Cloud Shell region to __"North Europe"__

Resource group: Select Use existing and set it to your Resource group __userX-ansible__

Storage account: Select Use existing your storage account will be selected, as you only have one

File Share: Select existing __userXansible__

![Alt text](images/07_start_cloud_shell_advanced_set.png?raw=true "Cloud Shell advanced")

Cloud shell is now ready

![Alt text](images/09_start_cloud_shell_ready.png?raw=true "Cloud Shell storage")

In Azure Cloud Shell(Bash)

We will download the deployment script and execute it

```bash

curl -o deploy_lab.sh https://raw.githubusercontent.com/jesperberth/automationclass_setup/main/azure/deploy_lab.sh

chmod +x deploy_lab.sh

./deploy_lab.sh

```

![Alt text](images/10_run_deploy_lab.png?raw=true "Run deploy_lab.sh")

__Note:__

Username cannot be __root/administrator/admin/user/guest/owner/adm__

__Use your initials as username__ eg. jesbe

Password must be complex

Be between 12 and 123 characters

- Have lower characters
- Have upper characters
- Have a digit
- Have a special character (Regex match [\W_])

__Note:__

Password will be visible on the screen

The playbook will create all resources needed for the Automation class - Lab 01 -> Lab 05

![Alt text](images/11_enter_user_password.png?raw=true "Enter Username and password")

![Alt text](images/11_lab_ready.png?raw=true "Labs are ready")

Lab is now deployed

Close the Cloudshell

## Prepare

We will need the servers, __ansible, server1__ and __server3__ to be up and running - by default they are started after creation

## Task 2 Install Ansible

Log on to your workstation __student__ using rdp

On the Azure portal click Virtual Machines

![Alt text](images/000_azure_portal.png?raw=true "Azure Portal")

Select your Resource Group, it's named __ansible-initials__

![Alt text](images/000_azure_portal_resourcegroup.png?raw=true "Azure Portal")

Click on the student vm

![Alt text](images/000_azure_portal_vm.png?raw=true "Azure Portal VMs")

Get the ansible servers external ip, click on the "Copy to ClipBoard"

![Alt text](images/000_azure_portal_vm_ip.png?raw=true "Azure Portal VM ip")

Start a Remote Desktop Client (On windows run __mstsc__) paste the public IP and connect

![Alt text](images/000_azure_portal_vm_mstsc.png?raw=true "mstsc")

Click "More choises" type your username/initials and password click __Ok__

![Alt text](images/000_azure_portal_vm_mstsc_login.png?raw=true "mstsc login")

Select the "Don't ask me again for connections to this computer and click __Yes__

![Alt text](images/000_azure_portal_vm_mstsc_login_yes.png?raw=true "mstsc login")

On the stundent vm click __Accept__

![Alt text](images/000_student_accept.png?raw=true "Student accept")

Start Windows Terminal

In the startmenu __Type__ "terminal" and click on __Windows Terminal__

![Alt text](images/000_student_start_winterm.png?raw=true "Student start winterminal")

In the Windows Terminal write ssh __username@ansible__ hit enter

__Type:__

```bash

yes - to accept the fingerprint

```

![Alt text](images/000_azure_ssh.png?raw=true "ssh")

__Type:__

> **Note**
> Sudo Password is equal to your user account password

Ansible is a Python based program, we will install python in a Python Virtuelenv, in which we can isolate the python version and modules from the system python.

To meet ansible 2.12 requirements we need to upgrade Python to version 3.9

```bash

sudo dnf install -y @python39

```

![Alt text](images/000_install_python.png?raw=true "install python")

And we need to set the alternative for python3 command to python3.9

```bash

sudo alternatives --set python3 /usr/bin/python3.9

python3 --version

```

![Alt text](images/000_default_python.png?raw=true "default python")

Lets create a Python virtualenv for our ansible installation

__Type:__

```bash

python3 -m venv ansible

```

![Alt text](images/003_create_virtualenv.png?raw=true "create virtualenv Ansible")

To activate our virtualenv ansible run the following

which python - is just to check that were using the correct python

__Type:__

```bash

source ansible/bin/activate

which python

python --version

```

> **Note**
> That when you are in a virtualenv, the name of the environment will be in the beginning of you command prompt like (ansible)

If you need to exit the virtualenv, you type "deactivate"

![Alt text](images/003_activate_virtualenv.png?raw=true "active virtualenv Ansible")

__Type:__

```bash

pip3 install --upgrade pip

```

![Alt text](images/002_install_pip3_upgrade.png?raw=true "Upgrade PIP")

__Type:__

```bash
pip install ansible
```

![Alt text](images/003_install_ansible.png?raw=true "Install Ansible")

## Task 3 Run ansible command

Log on to server "ansible" using ssh

__Type:__

```bash
ansible --version
```

![Alt text](images/004_install_ansible_version.png?raw=true "Ansible --version")

__Type:__

```bash
ansible --help
```

Will give you other options for ansible command

[Ansible Ping Module](https://docs.ansible.com/ansible/latest/modules/ping_module.html)

```bash
ansible localhost -m ping
```

Will run ansible against localhost with module ping

![Alt text](images/005_install_ansible_localhost_ping.png?raw=true "Ansible localhost ping")

[Ansible File Module](https://docs.ansible.com/ansible/latest/modules/list_of_files_modules.html)

__Type:__

```bash
ansible localhost -m file -a "path=/home/jesbe/testfile.txt state=touch"
```

change __jesbe__ with your username

The ansible command:

ansible __hosts__ -m __module__ -a __module arguments__

__hosts__ can be localhost or a group from the inventory file or all

__module__ any ansible module, here file

__module arguments__ arguments for module if needed, here path=/home/jesbe/testfile.txt and state=touch

![Alt text](images/006_install_ansible_localhost_file.png?raw=true "Ansible localhost ping")

## Task 4 Connect Linux host

Log on to server "ansible" using ssh

Lets create a configuration file for ansible in your root dir

We will use it to control our ansible environment

[Ansible Configuration file](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#ansible-configuration-settings-locations)

__Type:__

```bash
cd

pwd

vi .ansible.cfg
```

![Alt text](images/007_ansible_cfg.png?raw=true "ansible config")

> **Note**
> Change __jesbe__ in the path with your username

In vi __type:__

```bash
i (hit i to toggle input)
```

```bash
[defaults]
inventory = /home/jesbe/ansible-hosts
```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](images/008_ansible_cfg_set_inventory.png?raw=true "set ansible inventory")

Create the Ansible Hosts file

__Type:__

```bash
vi ansible-hosts
```

In vi __Type:__

```bash
i (hit i to toggle input)
```

```bash
[linuxservers]
server1
```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](images/009_edit_hostfile.png?raw=true "Edit ansible hostfile")

Lets ping our remote host server1

__Type:__

```bash
ansible linuxservers -m ping
```

If it asks "Are you sure you want to continue connecting (yes/no)?" type yes

![Alt text](images/009_connect_error.png?raw=true "Connect Error")

Connection will fail, as ansible expects passwordless ssh connections to be established before running

Test ssh to server 1

__Type:__

```bash
ssh server1
```

![Alt text](images/010_ssh_connect.png?raw=true "SSH Connect")

__Type:__

```bash
exit
```

We need to generate a ssh-key pair for passwordless connection

__Type:__

```bash
ssh-keygen
```

```bash
hit enter on key-path
hit enter for empty passphrase
hit enter again
```

![Alt text](images/011_ssh_keygen.png?raw=true "SSH Connect")

We need to copy the public key to server1

> **Note**
> Change __jesbe__ to your username

__Type:__

```bash
ssh-copy-id jesbe@server1
```

![Alt text](images/012_ssh_copy.png?raw=true "SSH Copy ID")

__Type:__

```bash
ssh server1
```

You should now be able to ssh to server1 without beeing prompted for a password

![Alt text](images/013_ssh_passwordless.png?raw=true "SSH Copy ID")

__Type:__

```bash
exit
```

Ping linuxservers

__Type:__

```bash
ansible linuxservers -m ping
```

![Alt text](images/014_ping_pong.png?raw=true "SSH Copy ID")

Lets test a few ansible commands

> **Note**
> Change jesbe to your username

__Type:__

```bash
ansible linuxservers -m file -a "path=/home/jesbe/testfile.txt state=touch"

ssh server1

ls
```

is the file testfile.txt there?

```bash

exit
```

![Alt text](images/015_file_test.png?raw=true "ansible file")

[Ansible Systemd module](https://docs.ansible.com/ansible/latest/modules/systemd_module.html)

__Type:__

```bash
ansible linuxservers -m systemd -a "name=cockpit.socket state=started enabled=yes"
```

![Alt text](images/016_systemd_error.png?raw=true "ansible systemd error")

This will fail as the user dosn't have the right permissions

Add -b (become will default use sudo to root) and --ask-become-pass is the escalation password

__Type:__

```bash
ansible linuxservers -m systemd -a "name=cockpit.socket state=started enabled=yes" -b --ask-become-pass
```

![Alt text](images/017_systemd_works.png?raw=true "ansible systemd works")

## Task 5 Connect Windows Host

Windows Servers can be connected in different ways, we will use ansible_messageencryption, but Certificate encryption is available, but requires more work

Log on to server "ansible" using ssh

We need to install pywinrm before being able to connect to windows servers from ansible

__Type:__

```bash
pip install pywinrm
```

![Alt text](images/019_install_pywinrm.png?raw=true "enable winRm")

Lets add the windows server to our ansible hosts file

Yes the password is in clear text, you can encrypt the password with ansible-vault

> **Note**
> Change __ansible_user__ and __ansible_password__ to your username and password

Add after the first group, linuxservers

__Type:__

```bash
vi ansible-hosts

i (for input)

[windowsservers]
server3

[windowsservers:vars]
ansible_user=jesbe
ansible_password=SomeThingSimple8
ansible_port=5985
ansible_connection=winrm
ansible_winrm_transport=ntlm
ansible_winrm_message_encryption=always
```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](images/020_winrm_hostsfile.png?raw=true "hosts file winRm")

Lets test connection to the Windows server

__Type:__

```bash
ansible windowsservers -m win_ping
```

![Alt text](images/021_ansible_win_ping.png?raw=true "win_ping")

## Task 6 Ansible Collections

In ansible 2.10 and forward, most modules will be delivered from collections via [Ansible Galaxy](https://galaxy.ansible.com)

[Ansible Galaxy Docs](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html)

We need to create the roles and collections folder in .ansible

__Type:__

```bash
cd

mkdir .ansible/roles

mkdir .ansible/collections
```

![Alt text](images/022_ansible_roles_dir.png?raw=true "create roles dir")

List existing collections (should be none)

__Type:__

```bash

ansible-galaxy collection list

```

![Alt text](images/023_ansible_collection_list.png?raw=true "list collections")

Lets install the ansible Windows Collection, we need it in the next lab

ansible.windows is already installed from the standard ansible package, but a new version is available

__Type:__

```bash

ansible-galaxy collection install ansible.windows

```

![Alt text](images/024_ansible_collection_install.png?raw=true "install collection")

You can list all installed modules with ansible-doc -l and filter out from collection ansible-doc -l ansible.windows for modules in the collection we just installed

__Hint:__

 You can use "q" to quit the viewing

__Type:__

```bash

ansible-doc -l

ansible-doc -l ansible.windows

```

![Alt text](images/025_ansible-doc.png?raw=true "ansible-doc -l")

You can get the documentation for a single module with ansible-doc *modulename*

__Type:__

```bash

ansible-doc ansible.windows.win_feature

```

![Alt text](images/026_ansible-doc-winfeature.png?raw=true "ansible-doc -l")

## Optional Set Nano as default editor

Some ansible commands as ansible-vault will use a the default editor vi

You can change the default editor to nano or other preferred editors to do so follow the guide below

```bash

nano ~/.bashrc

```

Add the line at the end of the configuration file

```bash

export EDITOR=nano

```

Next Lab

[Ansible Playbooks](../lab02/lab2.md)
