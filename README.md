# Automationclass with Ansible
## Automate Linux, Windows and Cloud

### Prerequsits
Environment

6 servers - made available in Azure - (use 01_class_setup.yml to deploy in Azure)

4 - Running Red Hat Enterprise Linux 8
Accessible with ssh and http/https
* ansible - 10.1.0.4
* tower   - 10.1.0.5
* server1 - 10.1.0.6
* server2 - 10.1.0.7

2 - Running Windows Server 2019 with GUI
Accessible with winRM and RDP
* server3 - 10.1.0.8
* server4 - 10.1.0.9

Software on your client
* VSCode (or other IDE)
* Git
* ssh client
* RDP client
* Webbrowser

# Tasks

## Task 1: Install Ansible

Log on to server "ansible" using ssh 

Type:

Note: Sudo Password is equal to your user account password

sudo dnf install -y python3-pip

![Alt text](pics/001_install_pip3.png?raw=true "Install Python3 PIP3")

sudo pip3 install --upgrade pip

![Alt text](pics/002_install_pip3_upgrade.png?raw=true "Upgrade PIP")

pip3 install ansible --user

![Alt text](pics/003_install_ansible.png?raw=true "Install Ansible")

## Task 2: Run ansible command

Log on to server "ansible" using ssh 

Type:

ansible --version

![Alt text](pics/004_install_ansible_version.png?raw=true "Ansible --version")

ansible --help
Will give you other options for ansible command

ansible localhost -m ping

Will run ansible against localhost with module ping

![Alt text](pics/005_install_ansible_localhost_ping.png?raw=true "Ansible localhost ping")

ansible localhost -m file -a "path=/home/jesbe/testfile.txt state=touch"

change jesbe with your username

ansible <hosts> -m <module> -a <module arguments>

<hosts> can be localhost, a specified host (10.1.0.4/ansible), a group from the hostfile or all

<module> any ansible module, here file

<module arguments> arguments for module if needed, here path=/home/jesbe/testfile.txt and state=touch

![Alt text](pics/006_install_ansible_localhost_file.png?raw=true "Ansible localhost ping")

## Task 3: Ansible hosts file

Log on to server "ansible" using ssh 

Type:

sudo mkdir /etc/ansible

sudo vi /etc/ansible/hosts

![Alt text](pics/007_mkdir_ansible.png?raw=true "mkdir ansible")

In vi type:

i (for input)

[linuxservers]
server1

Hit Esc-key

Type:

:wq (: for a command w for write and q for quit vi)

![Alt text](pics/008_edit_hostfile.png?raw=true "Edit ansible hostfile")

Lets ping our remote host server1 

ansible linuxservers -m ping

when it asks "Are you sure you want to continue connecting (yes/no)?" type yes

![Alt text](pics/009_connect_error.png?raw=true "Connect Error")

Connection will fail, as ansible expects passwordless ssh connections to be established before running

Test ssh to server 1

ssh server1

![Alt text](pics/010_ssh_connect.png?raw=true "SSH Connect")

type:

exit

