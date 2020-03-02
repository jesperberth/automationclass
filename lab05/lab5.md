# Lab 5: Network

In this session we will configure a Fortigate firewall with a new vlan interface, an address objects and three firewall policies.

The network is to be used in Lab 6 Vmware playbook

## Task 1: Install Ansible on ansibleserver.ansible.local

Logon to ansibleserver.ansible.local with ssh

```bash

userx@ansibleserver.ansible.local

```

Use your "userx" account and password

We need to install ansible and python modules for fortios

Lets create a Python virtualenv for our ansible installation

__Type:__

```bash
virtualenv ansible
```

![Alt text](pics/001_setup_virtenv.png?raw=true "setup virtualenv")

To activate our virtualenv ansible run the following

which python - is just to check that were using the correct python

__Type:__

```bash
source ansible/bin/activate

which python
```

![Alt text](pics/002_activate_virtenv.png?raw=true "activate virtualenv")

Lets install the python modules for ansible and fortios

__Type:__

``` bash
pip install ansibl
pip install fortiosapi
```

![Alt text](pics/003_install_pip_azure.png?raw=true "install ansible")

## Task 2: Create a VLAN on the fortigate firewall

[Ansible module fortios_system_interface](https://docs.ansible.com/ansible/latest/modules/fortios_system_interface_module.html#fortios-system-interface-module)

We need a new vlan for our new webserver (Lab 6)

In VSCode

create a new playbook file 01_forti_vlan.yml and add below

__Note:__

You need to change the "username" and  "vlan id"

```ansible
---
- hosts: localhost
  vars:
   host: "10.172.10.1"
   username: "userx"
   vlanid: "xxx"
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
        name: "vlan_{{ vlanid }}"
        allowaccess: "ping"
        mode: "static"
        ip: "10.172.{{ vlanid }}.1/24"
        type: "vlan"
        vlanid: "{{ vlanid }}"
        role: "lan"
        interface: "switch"
        status: "up"
        vdom: "root"
```

![Alt text](pics/002_forti_vlan_playbook.png?raw=true "vlan playbook")

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

![Alt text](pics/003_forti_vlan_playbook_run.png?raw=true "vlan playbook run")

## Task 3: Create address objects on the fortigate firewall

[Ansible module fortios_firewall_address](https://docs.ansible.com/ansible/latest/modules/fortios_firewall_address_module.html#fortios-firewall-address-module)

We need a new to create an address object to use for the firewall policy, task 3

In VSCode

create a new playbook file 02_forti_address.yml and add below

__Note:__

You need to change the "username" and "vlanid"

```ansible
---
- hosts: localhost
  vars:
   host: "10.172.10.1"
   username: "userx"
   vlanid: "xxx"
   vdom: "root"
   ssl_verify: "False"
  vars_prompt:
  - name: password
    prompt: "Type the password of your fortigate admin account"
    private: no
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
        name: "vlan_{{ vlanid }} address"
        subnet: "10.172.{{ vlanid }}.0/24"
        associated_interface: "vlan_{{ vlanid }}"
```

![Alt text](pics/004_forti_address_playbook.png?raw=true "address playbook")

Save and commit to Git

Log on to server "ansibleserver.ansible.local" using ssh

Use git to get the new network playbook

__Type:__

```bash

git pull

cd ansibleclass

ansible-playbook 02_forti_address.yml

```

![Alt text](pics/005_forti_fw_address_playbook_run.png?raw=true "address playbook run")

## Task 4: Create firewall policies on the fortigate firewall

[Ansible module fortios_firewall_policy](https://docs.ansible.com/ansible/latest/modules/fortios_firewall_policy_module.html#fortios-firewall-policy-module)

We will create 3 firewall policies

- switch to vlan_10x - service HTTP, SSH
- vlan_10x to switch - service ALL
- vlan_10x to Wan - service HTTP, HTTPS, SSH, DNS, ICMP_ALL

In VSCode

create a new playbook file 03_forti_firewall_policy.yml and add below

__Note:__

You need to change the "username" and "vlanid"

```ansible
---
- hosts: localhost
  vars:
   host: "10.172.10.1"
   username: "userx"
   vlanid: "xxx"
   vdom: "root"
   ssl_verify: "False"
  vars_prompt:
   - name: password
     prompt: "Type the password of your fortigate admin account"
     private: no
  tasks:
  - name: Configure firewall interface switch -> vlan_10x
    fortios_firewall_policy:
      host:  "{{ host }}"
      username: "{{ username }}"
      password: "{{ password }}"
      vdom:  "{{ vdom }}"
      https: "False"
      state: "present"
      firewall_policy:
        action: "accept"
        name: "switch to vlan_{{ vlanid }}"
        srcintf:
         -
           name: "switch"
        dstintf:
         -
           name: "vlan_{{ vlanid }}"
        srcaddr:
         -
           name: "switch address"
        dstaddr:
         -
           name: "vlan_{{ vlanid }} address"
        schedule: "always"
        service:
         -
           name: "HTTP"
         -
           name: "SSH"
        fsso: "disable"
        status: enable
        policyid: "{{ vlanid }}1"
  - name: Configure firewall interface vlan_10x -> switch
    fortios_firewall_policy:
      host:  "{{ host }}"
      username: "{{ username }}"
      password: "{{ password }}"
      vdom:  "{{ vdom }}"
      https: "False"
      state: "present"
      firewall_policy:
        action: "accept"
        name: "vlan_{{ vlanid }} to switch"
        srcintf:
         -
           name: "vlan_{{ vlanid }}"
        dstintf:
         -
           name: "switch"
        srcaddr:
         -
           name: "vlan_{{ vlanid }} address"
        dstaddr:
         -
           name: "switch address"
        schedule: "always"
        service:
         -
           name: "ALL"
        fsso: "disable"
        status: enable
        policyid: "{{ vlanid }}2"
  - name: Configure firewall interface vlan_10x -> wan1
    fortios_firewall_policy:
      host:  "{{ host }}"
      username: "{{ username }}"
      password: "{{ password }}"
      vdom:  "{{ vdom }}"
      https: "False"
      state: "present"
      firewall_policy:
        action: "accept"
        name: "vlan_{{ vlanid }} to wan1"
        srcintf:
         -
           name: "vlan_{{ vlanid }}"
        dstintf:
         -
           name: "wan1"
        srcaddr:
         -
           name: "vlan_{{ vlanid }} address"
        dstaddr:
         -
           name: "all"
        schedule: "always"
        service:
         -
           name: "HTTP"
         -
           name: "HTTPS"
         -
           name: "DNS"
         -
           name: "SSH"
         -
           name: "ALL_ICMP"
        fsso: "disable"
        status: enable
        policyid: "{{ vlanid }}3"
        nat: "enable"
```

![Alt text](pics/006_forti_fw_policy_playbook.png?raw=true "firewall policy playbook")

Save and commit to Git

Log on to server "ansibleserver.ansible.local" using ssh

Use git to get the new network playbook

__Type:__

```bash

git pull

cd ansibleclass

ansible-playbook 03_forti_firewall_policy.yml

```

![Alt text](pics/006_forti_fw_policy_playbook_run.png?raw=true "firewall policy playbook run")

[Vmware Playbooks](../lab06/lab6.md)
