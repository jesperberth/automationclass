# Automationclass with Ansible
## Automate Linux, Windows and Cloud

### Prerequsits
__Environment__

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

__Software on your client__
* VSCode (or other IDE) [Download vscode](https://code.visualstudio.com/download)
* Git [Download Git](https://git-scm.com/downloads)
* ssh client
* RDP client
* Webbrowser

# Lessons

## Lesson 1: [Install Ansible](lesson1.md)
Install Ansible and Connect to a Linux and Windows Server
