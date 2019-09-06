# Class Setup 

## ansiblehost.ansible.local

Role: DNS, ansible for setting up classroom, Firewall, Vmware environment

Local VM, or laptop

Fedora 30
Minimal install
root user
additional user: xxx

ip: 10.172.10.2/24
Gateway: 10.172.10.1
DNS 1.1.1.1

```bash
pip3 install ansible --user
pip3 install pyvmomi --user
pip3 install pyforti --user

```



# VMware Class Setup

## Hardware

VMware Host
Name: esxi.ansible.local
IP: 10.172.10.10/24
ESXi 6.7U3



Ansible
Name ansibleserver.ansible.local
IP: 10.172.10.11/24
Fedora 30

Storage
Name: storage.ansible.local
IP: 10.172.10.12
Fedora 30

### Setup

On ansiblehost.ansible.local log on as user

```bash

sudo dnf update -y

sudo dnf install python3-pip git -y

pip3 install pip==9.0.3 --user

pip3 install ansible --user
pip3 install pyvmomi --user
pip3 install pyfortiapi --user

git clone https://github.com/jesperberth/automationclass.git

cd automationclass/setup_class

ansible-playbook 01_vmware_class_setup.yml --ask-become-pass
ansible-playbook 02_vmware_class_setup.yml
ansible-playbook 03_vmware_class_setup.yml
ansible-playbook 04_vmware_class_setup.yml --ask-become-pass
```
