# Automationclass with Ansible

## Automate Linux, Windows, VMware, Network and Cloud

### Prerequsits

#### Environment

5 servers - made available in Azure

3 - Running Red Hat Enterprise Linux 8
Accessible with ssh and http/https

* ansible - 10.1.0.4
* server1 - 10.1.0.5
* server2 - 10.1.0.6

2 - Running Windows Server 2019 with GUI
Accessible with winRM and RDP

* server3 - 10.1.0.7
* server4 - 10.1.0.8

#### Software on your client

* VSCode (or other IDE) [Download vscode](https://code.visualstudio.com/download)
* Git [Download Git](https://git-scm.com/downloads)
* ssh client
* RDP client
* Webbrowser

[Prepare Labs](prepare.md)

## Labs

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

### Lab 7: [Ansible Automation](lab07/lab7.md)

Use Ansible to manage Vmware VSphere

### Lab 8: [Ansible Exercise](lab08/lab8.md)

Use Ansible to manage Vmware VSphere
