# Automationclass with Ansible

## Automate Linux, Windows, VMware, Network and Cloud

### Prerequsits

#### Environment

5 servers - made available in Azure - (use setup_class/azure_class_playbooks/00_azure_class_setup.yml to deploy)

3 - Running Red Hat Enterprise Linux 8
Accessible with ssh and http/https

* ansible - 10.1.0.4
* server1 - 10.1.0.6
* server2 - 10.1.0.7

2 - Running Windows Server 2019 with GUI
Accessible with winRM and RDP

* server3 - 10.1.0.8
* server4 - 10.1.0.9

#### Software on your client

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
cd setup_class
cd azure_class_playbooks

ansible-playbook 01_azure_class_setup.yml
```

### Lab 1: [Install Ansible](lab01/lab1.md)

Install Ansible and Connect to a Linux and Windows Server

### Lab 2: [Ansible Playbooks](lab02/lab2.md)

Create Ansible Playbooks

### Lab 3: [Work with Playbooks](lab03/lab3.md)

Use Variables, prompts, facts and handlers in Playbooks

### Lab 4: [Cloud Playbooks](lab04/lab4.md)

Use Ansible in the Cloud (Microsoft Azure)

### Lab 5: [Network Playbooks](lab05/lab5.md)

Use Ansible to manage your network infrastructure (Fortinet)

### Lab 6: [Vmware Playbooks](lab06/lab6.md)

Use Ansible to manage Vmware VSphere
