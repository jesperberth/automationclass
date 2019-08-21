# VMware Class Setup

## Hardware

VMware Host
Name: esxi.demo.local
IP: 10.172.10.10/24
ESXi 6.5

Ansible
Name ansible2.demo.local
IP: 10.172.10.11/24
Fedora 30

Storage
Name: storage.demo.local
IP: 10.172.10.12
Fedora 30

### Setup

On ansible2.demo.local log on as user

```bash
pip3 install ansible --user
pip3 install pyvmomi --user
pip3 install pyforti --user

ansible-playbook 01_vmware_class_setup.yml --ask-become-pass
ansible-playbook 02_vmware_class_setup.yml
ansible-playbook 03_vmware_class_setup.yml
ansible-playbook 04_vmware_class_setup.yml --ask-become-pass
```
