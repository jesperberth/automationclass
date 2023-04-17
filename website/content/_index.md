---
title: "Automationclass with Ansible"
---

## Automate Linux, Windows and Cloud

### Prerequsits

#### Environment

Envoronment deployed in Microsoft Azure

6 Virtual Machines

1 Student PC Running Windows 11 Pro

* student - 10.1.0.9

5 servers

3 - Running Red Hat Enterprise Linux 9
Accessible with ssh and http/https

* ansible - 10.1.0.4
* server1 - 10.1.0.5
* server2 - 10.1.0.6

2 - Running Windows Server 2022 with GUI
Accessible with winRM and RDP

* server3 - 10.1.0.7
* server4 - 10.1.0.8

#### Software on student PC

* Windows Terminal
* Windows Subsystem for Linux (WSL2)
* VSCode [Download vscode](https://code.visualstudio.com/download)
* Git [Download Git](https://git-scm.com/downloads)
* Optional: Powershell Core 7 [Download Powershell Core](https://github.com/PowerShell/PowerShell)

## Labs

### Lab 1: Install Lab

Deploy Lab and Install Workstation

### Lab 2: Install Ansible

Install Ansible and Connect to a Linux and Windows Server

### Lab 3: Ansible Playbooks

Create Ansible Playbooks

### Lab 4: Ansible Vault

Use ansible vault to secure secrets

### Lab 5: Work with Playbooks

Use Variables, prompts, facts and handlers in Playbooks

### Lab 6: Work with Playbooks 2

Use stat and shell modules in playbooks

### Lab 7: Roles

Use and create roles with Ansible

### Lab 8: Ansible Windows

Use Ansible to manage Windows Servers

### Lab 9: Ansible Cloud

Use Ansible in the Cloud (Microsoft Azure)

### Lab 10: Ansible AWX Tower

Use AWX/Ansible Tower to create a workflow
