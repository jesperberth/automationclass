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

Vlan 124

## esxi.ansible.local

Role: Vmware ESXi host

Intel NUC
32GB Ram, 500Gb Nvme
Vmware ESXi 6.7U3

Install on local disk

Management network

Vlan 124

VM Network

Vlan 124

ip: 10.172.10.10/24
Gateway: 10.172.10.1
DNS: 10.172.10.2
name: esxi.ansible.local

## vcenter.ansible.local

Role: Vmware vcenter

Vmware vcenter appliance 6.7U3

Vlan 124

ip: 10.172.10.11/24
Gateway: 10.172.10.1
DNS: 10.172.10.2
name: vcenter.ansible.local
Size: Tiny

## storage.ansible.local

Role: NFS storage server for esxi host

Fedora 30

Virtual Machine running on ESXi
2 CPU
4Gb Mem
Disk 1 16Gb
Disk 2 100Gb

Vlan 124

ip: 10.172.10.12/24
Gateway: 10.172.10.1
DNS: 10.172.10.2
name: storage.ansible.local

## VMware Class Setup

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

cd automationclass/setup_class/class_room

ansible-playbook 01_class_setup.yml

TEMP: nmcli connection modify ens192 ipv4.dns "127.0.0.1"

On esxi.ansible.local

```
