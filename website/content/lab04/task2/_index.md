---
title: Yaml Inventory
weight: 20
---

## Task 2 Yaml Inventory

Another option for the inventory is using a yaml file instead of the ini format, the yaml file will give us some other options for the vault

On

![ansible](/images/ansible.png)

Lets create a new ansible-hosts.yml

Copy the following inventory to ansible-hosts.yml

__Note:__

We need to set an option in vi before pasteing the configuration

__Type:__

```bash

cd

vi ansible-hosts.yml

Hit Esc-key

:set paste <Hit Enter>

Hit Esc-key

i (to toggle insert)
```

__Remember__ to change the ansible_user to your initials

```ansible
linuxservers:
  hosts:
    server1:
    server2:
windowsservers:
  hosts:
    server3:
    server4:
  vars:
    ansible_user: jesbe
    ansible_port: 5985
    ansible_connection: winrm
    ansible_winrm_transport: ntlm
    ansible_winrm_message_encryption: always

```

![Alt text](images/037_set_paste.png?raw=true "vi paste")

Note that it now writes -- INSERT (paste) -- in the bottom

You can do a copy/paste of the inventory

![Alt text](images/037_yaml_inventory.png?raw=true "yaml inventory")

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

Lets change ansible.cfg to use the new inventory, you just need to add the .yml to the inventory line

```bash

cd

vi .ansible.cfg

i (for input)

inventory = /home/jesbe/ansible-hosts.yml

```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](images/038_ansible_cfg.png?raw=true "config")

Do a ping test to check if we are using the new inventory

```bash

ansible linuxservers -m ping

```

![Alt text](images/039_ansible_yaml_test.png?raw=true "test yaml inventory")
