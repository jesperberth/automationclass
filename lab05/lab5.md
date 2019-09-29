# Lab 05: Network

In this session we configure a Fortigate firewall with address objects, vlan interface and firewall policies.

The network is to be used in Lab 6

## Task 1: Prepare ansibleserver

Logon to ansibleserver.ansible.local with ssh

Use your "userxx" account and password

We need to install ansible and python modules for fortios

<span style="color:red">Until ansible 2.9 is released, we need to use devel version</span>

__Type:__

``` bash
pip3 install git+https://github.com/ansible/ansible.git@devel --user
pip3 install fortiosapi --user

ansible --version
```

![Alt text](pics/001_install_pip_azure.png?raw=true "install ansible devel")

## Task 2: Create a VLAN on the fortigate firewall

We need a new vlan for our new webserver (Lab 6)

__Note:__

You need to change the "username" and "vlan name", "vlan id" and "IP"

```ansible
---
- hosts: localhost
  vars:
   host: "10.172.10.1"
   username: "userx"
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