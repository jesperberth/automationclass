# Lab 1: Install Ansible

In this session we will install ansible on server __ansible__, and connect to linux - __server1__ and windows - __server3__

We will use server __ansible__ to run the first part of the training

## Table of Contents

- [Prepare](#prepare)
- [Task 1 Install Ansible](#task-1-install-ansible)
- [Task 2 Run ansible command](#task-2-run-ansible-command)
- [Task 3 Connect Linux host](#task-3-connect-linux-host)
- [Task 4 Connect Windows Host](#task-4-connect-windows-host)
- [Task 5 Ansible Collections](#task-5-ansible-collections)

## Prepare

We will need the servers, __ansible, server1__ and __server3__ to be up and running - by default they are started after creation

## Task 1 Install Ansible

Log on to server __ansible__ using ssh

On the Azure portal click Virtual Machines

![Alt text](pics/000_azure_portal.png?raw=true "Azure Portal")

Select your Resource Group, it's named __ansible-initials__

![Alt text](pics/000_azure_portal_resourcegroup.png?raw=true "Azure Portal")

Click on the ansible server

![Alt text](pics/000_azure_portal_vm.png?raw=true "Azure Portal VMs")

Get the ansible servers external ip, click on the "Copy to ClipBoard"

![Alt text](pics/000_azure_portal_vm_ip.png?raw=true "Azure Portal VM ip")

In the Windows Terminal, Powershell or CMD write ssh __username@ansible-vm-ip__ hit enter

![Alt text](pics/000_azure_ssh.png?raw=true "ssh")

__Type:__

Note: Sudo Password is equal to your user account password

Ansible is a Python based program, we will install python in a Python Virtuelenv, in which we can isolate the python version and modules from the system python.

To meet ansible 2.12 requirements we need to upgrade Python to version 3.9

```bash

sudo dnf install -y @python39

```

![Alt text](pics/000_install_python.png?raw=true "install python")

And we need to set the alternative for python3 command to python3.9

```bash

sudo alternatives --set python3 /usr/bin/python3.9

python3 --version

```

![Alt text](pics/000_default_python.png?raw=true "default python")

Lets create a Python virtualenv for our ansible installation

__Type:__

```bash

python3 -m venv ansible

```

![Alt text](pics/003_create_virtualenv.png?raw=true "create virtualenv Ansible")

To activate our virtualenv ansible run the following

which python - is just to check that were using the correct python

__Type:__

```bash

source ansible/bin/activate

which python

python --version

```

Note: That when you are in a virtualenv, the name of the environment will be in the beginning of you command prompt like (ansible)

If you need to exit the virtualenv, you type "deactivate"

![Alt text](pics/003_activate_virtualenv.png?raw=true "active virtualenv Ansible")

__Type:__

```bash

pip3 install --upgrade pip

```

![Alt text](pics/002_install_pip3_upgrade.png?raw=true "Upgrade PIP")

__Type:__

```bash
pip install ansible
```

![Alt text](pics/003_install_ansible.png?raw=true "Install Ansible")

## Task 2 Run ansible command

Log on to server "ansible" using ssh

__Type:__

```bash
ansible --version
```

![Alt text](pics/004_install_ansible_version.png?raw=true "Ansible --version")

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

![Alt text](pics/005_install_ansible_localhost_ping.png?raw=true "Ansible localhost ping")

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

![Alt text](pics/006_install_ansible_localhost_file.png?raw=true "Ansible localhost ping")

## Task 3 Connect Linux host

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

![Alt text](pics/007_ansible_cfg.png?raw=true "ansible config")

__Note:__

Change __jesbe__ in the path with your username

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

![Alt text](pics/008_ansible_cfg_set_inventory.png?raw=true "set ansible inventory")

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

![Alt text](pics/009_edit_hostfile.png?raw=true "Edit ansible hostfile")

Lets ping our remote host server1

__Type:__

```bash
ansible linuxservers -m ping
```

If it asks "Are you sure you want to continue connecting (yes/no)?" type yes

![Alt text](pics/009_connect_error.png?raw=true "Connect Error")

Connection will fail, as ansible expects passwordless ssh connections to be established before running

Test ssh to server 1

__Type:__

```bash
ssh server1
```

![Alt text](pics/010_ssh_connect.png?raw=true "SSH Connect")

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

![Alt text](pics/011_ssh_keygen.png?raw=true "SSH Connect")

We need to copy the public key to server1

__Note:__

Change __jesbe__ to your username

__Type:__

```bash
ssh-copy-id jesbe@server1
```

![Alt text](pics/012_ssh_copy.png?raw=true "SSH Copy ID")

__Type:__

```bash
ssh server1
```

You should now be able to ssh to server1 without beeing prompted for a password

![Alt text](pics/013_ssh_passwordless.png?raw=true "SSH Copy ID")

__Type:__

```bash
exit
```

Ping linuxservers

__Type:__

```bash
ansible linuxservers -m ping
```

![Alt text](pics/014_ping_pong.png?raw=true "SSH Copy ID")

Lets test a few ansible commands

__Note:__

Change jesbe to your username

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

![Alt text](pics/015_file_test.png?raw=true "ansible file")

[Ansible Systemd module](https://docs.ansible.com/ansible/latest/modules/systemd_module.html)

__Type:__

```bash
ansible linuxservers -m systemd -a "name=cockpit.socket state=started enabled=yes"
```

![Alt text](pics/016_systemd_error.png?raw=true "ansible systemd error")

This will fail as the user dosn't have the right permissions

Add -b (become will default use sudo to root) and --ask-become-pass is the escalation password

__Type:__

```bash
ansible linuxservers -m systemd -a "name=cockpit.socket state=started enabled=yes" -b --ask-become-pass
```

![Alt text](pics/017_systemd_works.png?raw=true "ansible systemd works")

## Task 4 Connect Windows Host

Windows Servers can be connected in different ways, we will use ansible_messageencryption, but Certificate encryption is available, but requires more work

Log on to server "ansible" using ssh

We need to install pywinrm before being able to connect to windows servers from ansible

__Type:__

```bash
pip install pywinrm
```

![Alt text](pics/019_install_pywinrm.png?raw=true "enable winRm")

Lets add the windows server to our ansible hosts file

Yes the password is in clear text, you can encrypt the password with ansible-vault

__Note:__

Change __ansible_user__ and __ansible_password__ to your username and password

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

![Alt text](pics/020_winrm_hostsfile.png?raw=true "hosts file winRm")

Lets test connection to the Windows server

__Type:__

```bash
ansible windowsservers -m win_ping
```

![Alt text](pics/021_ansible_win_ping.png?raw=true "win_ping")

## Task 5 Ansible Collections

In ansible 2.10 and forward, most modules will be delivered from collections via [Ansible Galaxy](https://galaxy.ansible.com)

[Ansible Galaxy Docs](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html)

We need to create the roles and collections folder in .ansible

__Type:__

```bash
cd

mkdir .ansible/roles

mkdir .ansible/collections
```

![Alt text](pics/022_ansible_roles_dir.png?raw=true "create roles dir")

List existing collections (should be none)

__Type:__

```bash

ansible-galaxy collection list

```

![Alt text](pics/023_ansible_collection_list.png?raw=true "list collections")

Lets install the ansible Windows Collection, we need it in the next lab

ansible.windows is already installed from the standard ansible package, but a new version is available

__Type:__

```bash

ansible-galaxy collection install ansible.windows

```

![Alt text](pics/024_ansible_collection_install.png?raw=true "install collection")

You can list all installed modules with ansible-doc -l and filter out from collection ansible-doc -l ansible.windows for modules in the collection we just installed

__Hint:__

 You can use "q" to quit the viewing

__Type:__

```bash

ansible-doc -l

ansible-doc -l ansible.windows

```

![Alt text](pics/025_ansible-doc.png?raw=true "ansible-doc -l")

You can get the documentation for a single module with ansible-doc *modulename*

__Type:__

```bash

ansible-doc ansible.windows.win_feature

```

![Alt text](pics/026_ansible-doc-winfeature.png?raw=true "ansible-doc -l")

Next Lab

[Ansible Playbooks](../lab02/lab2.md)
