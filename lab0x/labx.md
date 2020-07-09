# Lab 1: Ansible Galaxy and Roles

In this session we will install ansible on server ansible, and connect to linux - server1 and windows - server3

We will use server ansible to run the first part of the training

Ansible is a Python based program, we will install python in a Python Virtuelenv, in which we can isolate the python version and modules from the system python.  

## Prepare

We will need the servers, ansible, server1 and server3 to be up and running - by default they are started after creation

## Task 1: Install Ansible

Log on to server "ansible" using ssh

__Type:__

Note: Sudo Password is equal to your user account password

```bash
sudo dnf install -y python3-pip virtualenv
```

![Alt text](pics/001_install_pip3.png?raw=true "Install Python3 PIP3 and Virtualenv")