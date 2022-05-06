# Automationclass with Ansible

## Automate Linux, Windows and Cloud

### Prerequsits

#### Environment

Envoronment deployed in Microsoft Azure

6 Virtual Machines

1 Student PC Running Windows 11 Pro

* student - 10.1.0.9

5 servers

3 - Running Red Hat Enterprise Linux 8
Accessible with ssh and http/https

* ansible - 10.1.0.4
* server1 - 10.1.0.5
* server2 - 10.1.0.6

2 - Running Windows Server 2019 with GUI
Accessible with winRM and RDP

* server3 - 10.1.0.7
* server4 - 10.1.0.8

#### Software on student PC

* Windows Terminal
* Windows Subsystem for Linux (WSL2)
* VSCode [Download vscode](https://code.visualstudio.com/download)
* Git [Download Git](https://git-scm.com/downloads)
* Optional: Powershell Core 7 [Download Powershell Core](https://github.com/PowerShell/PowerShell)

[Prepare Labs](prepare.md)

## Labs

### Lab 1: [Install Ansible](lab01/lab1.md)

Install Ansible and Connect to a Linux and Windows Server

### Lab 2: [Ansible Playbooks](lab02/lab2.md)

Create Ansible Playbooks

### Lab 3: [Ansible Vault](lab03/lab3.md)

Use ansible vault to secure secrets

### Lab 4: [Work with Playbooks](lab04/lab4.md)

Use Variables, prompts, facts and handlers in Playbooks

### Lab 5: [Ansible linting](lab05/lab5.md)

Use linting in ansible

### Lab 6: [Roles](lab06/lab6.md)

Use and create roles with Ansible

### Lab 7: [Ansible Windows](lab07/lab7.md)

Use Ansible to manage Windows Servers

### Lab 8: [Ansible Cloud](lab08/lab8.md)

Use Ansible in the Cloud (Microsoft Azure)

### Lab 9: [Ansible AWX Tower](lab09/lab9.md)

Use AWX/Ansible Tower to create a workflow
