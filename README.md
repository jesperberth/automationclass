# Automationclass with Ansible

## Automate Linux, Windows and Cloud

### Prerequsits

__Environment__

6 servers - made available in Azure - (use azure_class_playbooks/01_azure_class_setup.yml to deploy in Azure)

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

__Software on your client__

* VSCode (or other IDE) [Download vscode](https://code.visualstudio.com/download)
* Git [Download Git](https://git-scm.com/downloads)
* ssh client
* RDP client
* Webbrowser

## Lessons

### Prepare

In Azure Cloud Shell(Bash)

Note:

You need to type the name of your allocated Azure Resource Group

Type a uniq name for your dns string

Username cannot be root/administrator

Password must meet complexity requirements, 3 of 4 types and minumum 12 characters

``` bash
git clone https://github.com/jesperberth/automationclass/
cd clouddrive
cd automationclass
cd azure_class_playbooks

ansible-playbook 01_azure_class_setup.yml
```

### Lesson 1: [Install Ansible](lesson1.md)

Install Ansible and Connect to a Linux and Windows Server

### Lesson 2: Playbooks

Create Ansible Playbooks for Linux and Windows
