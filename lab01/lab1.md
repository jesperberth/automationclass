# Lab 1: Install Ansible

In this session we will install ansible on server ansible, and connect to linux - server1 and windows - server3

## Prepare

We need to start servers, ansible, server1 and server3

In Azure Cloud Shell(Bash)

``` bash
cd clouddrive
cd automationclass
cd setup_class
cd azure_class_playbooks

ansible-playbook 01_azure_lab1_start.yml

```

## Task 1: Install Ansible

Log on to server "ansible" using ssh

__Type:__

Note: Sudo Password is equal to your user account password

```bash
sudo dnf install -y python3-pip
```

![Alt text](pics/001_install_pip3.png?raw=true "Install Python3 PIP3")

__Type:__

```bash
sudo pip3 install --upgrade pip
```

![Alt text](pics/002_install_pip3_upgrade.png?raw=true "Upgrade PIP")

__Type:__

```bash
pip3 install ansible --user
```

![Alt text](pics/003_install_ansible.png?raw=true "Install Ansible")

## Task 2: Run ansible command

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

change jesbe with your username

The ansible command:

ansible __hosts__ -m __module__ -a __module arguments__

__hosts__ can be localhost or a group from the hostfile or all

__module__ any ansible module, here file

__module arguments__ arguments for module if needed, here path=/home/jesbe/testfile.txt and state=touch

![Alt text](pics/006_install_ansible_localhost_file.png?raw=true "Ansible localhost ping")

## Task 3: Connect Linux host

Log on to server "ansible" using ssh

__Type:__

```bash
sudo mkdir /etc/ansible

sudo vi /etc/ansible/hosts
```

![Alt text](pics/007_mkdir_ansible.png?raw=true "mkdir ansible")

In vi __type:__

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

![Alt text](pics/008_edit_hostfile.png?raw=true "Edit ansible hostfile")

Lets ping our remote host server1

__Type:__

```bash
ansible linuxservers -m ping
```

when it asks "Are you sure you want to continue connecting (yes/no)?" type yes


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

hit enter on key-path
hit enter for empty passphrase
hit enter again
```

![Alt text](pics/011_ssh_keygen.png?raw=true "SSH Connect")

We need to copy the public key to server1

__Note:__

Change jesbe to your username

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

ansible linuxservers -m ping
```

![Alt text](pics/014_ping_pong.png?raw=true "SSH Copy ID")

Lets test a few ansible commands

__Type:__

```bash
ansible linuxservers -m file -a "path=/home/jesbe/testfile.txt state=touch"

ssh server1

ls

is the file testfile.txt there?

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

## Task 4: Connect Windows Host

Connect to server3 using RDP

We need to enable Windows Remote Management on the server

Start a powershell console with elevated rights (Run As Administrator) and run the following commands

__Type:__

```powershell
$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

powershell.exe -ExecutionPolicy ByPass -File $file
```

![Alt text](pics/018_enable_winrm.png?raw=true "enable winRm")

Lets add the windows server to our ansible hosts file

Log on to server "ansible" using ssh

We need to install pywinrm before being able to connect to windows servers from ansible

__Type:__

```bash
pip3 install pywinrm --user
```

![Alt text](pics/019_install_pywinrm.png?raw=true "enable winRm")

Yes the password is in clear text, we will look into this later

__Type:__

```bash
sudo vi /etc/ansible/hosts

i (for input)

[windowsservers]
server3

[windowsservers:vars]
ansible_user=jesbe
ansible_password=SomeThingSimple8
ansible_port=5986
ansible_connection=winrm
ansible_winrm_server_cert_validation=ignore
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

Next Lab

[Ansible Playbooks](../lab02/lab2.md)
