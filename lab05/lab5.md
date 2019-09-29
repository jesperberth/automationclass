# Lab 5: Network

In this session we will configure a Fortigate firewall with a new vlan interface, an address objects and three firewall policies.

The network is to be used in Lab 6 Vmware playbook

## Task 1: Prepare ansibleserver

Logon to ansibleserver.ansible.local with ssh

Use your "userxx" account and password

We need to install ansible and python modules for fortios

__Until ansible 2.9 is released, we need to use devel version__

__Type:__

``` bash
pip3 install git+https://github.com/ansible/ansible.git@devel --user
pip3 install fortiosapi --user

ansible --version
```

![Alt text](pics/001_install_pip_azure.png?raw=true "install ansible devel")

## Task 2: Create a VLAN on the fortigate firewall

[Ansible module fortios_system_interface](https://docs.ansible.com/ansible/latest/modules/fortios_system_interface_module.html#fortios-system-interface-module)

We need a new vlan for our new webserver (Lab 6)

In VSCode

create a new playbook file 01_forti_vlan.yml and add below

__Note:__

You need to change the "username" and "vlan name", "vlan id" and "IP"

```ansible
---
- hosts: localhost
  vars:
   host: "10.172.10.1"
   username: "userxx"
   vdom: "root"
   ssl_verify: "False"
  vars_prompt:
   - name: password
     prompt: "Type the password of your fortigate admin account"
     private: no
  tasks:
  - name: Configure interface
    fortios_system_interface:
      host:  "{{ host }}"
      username: "{{ username }}"
      password: "{{ password }}"
      vdom:  "{{ vdom }}"
      https: "False"
      state: "present"
      system_interface:
        name: "vlan_10x"
        allowaccess: "ping"
        mode: "static"
        ip: "10.172.10x.1/24"
        type: "vlan"
        vlanid: "10x"
        role: "lan"
        interface: "switch"
        status: "up"
        vdom: "root"
```

![Alt text](pics/012_azure_net_playbook.png?raw=true "vlan playbook")

Save and commit to Git

Log on to server "ansibleserver.ansible.local" using ssh

Use git to get the new network playbook

Change url to your own repository

__Type:__

```bash

git clone https://github.com/jesperberth/ansibleclass.git

cd ansibleclass

ansible-playbook 01_forti_vlan.yml

```

![Alt text](pics/013_azure_net_playbook_run.png?raw=true "vlan playbook run")

## Task 3: Create address objects on the fortigate firewall

[Ansible module fortios_firewall_address](https://docs.ansible.com/ansible/latest/modules/fortios_firewall_address_module.html#fortios-firewall-address-module)

We need a new to create an address object to use for the firewall policy, task 3

In VSCode

create a new playbook file 02_forti_address.yml and add below

__Note:__

You need to change the "username" and "name", "subnet" and "associated_interface"

```ansible
---
- hosts: localhost
  vars:
   host: "10.172.10.1"
   username: "userxx"
   vdom: "root"
   ssl_verify: "False"
  vars_prompt:
  - name: password
    prompt: "Type the password of your fortigate admin account"
    private: no.
  tasks:
  - name: Add User Vlan address object
    fortios_firewall_address:
      host:  "{{ host }}"
      username: "{{ username }}"
      password: "{{ password }}"
      vdom:  "{{ vdom }}"
      https: "False"
      state: "present"
      firewall_address:
        name: "vlan_10x address"
        subnet: "10.172.10x.0/24"
        associated_interface: "vlan_10x"
        type: "Interface Subnet"
```

![Alt text](pics/012_azure_net_playbook.png?raw=true "address playbook")

Save and commit to Git

Log on to server "ansibleserver.ansible.local" using ssh

Use git to get the new network playbook

__Type:__

```bash

git pull

cd ansibleclass

ansible-playbook 02_forti_address.yml

```

![Alt text](pics/013_azure_net_playbook_run.png?raw=true "address playbook run")
