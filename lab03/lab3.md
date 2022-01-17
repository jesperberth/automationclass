# Lab 3: Ansible Vault

In this session we will install and use Visual Studio Code with a few plugins to start working with ansible playbooks and create two playbooks, one for linux and one for windows

## Table of Contents

- [Prepare](#prepare)
- [Task 1 Ansible-vault](#task-1-ansible-vault)
- [Task 2 Ansible Inventory yaml](#task-2-ansible-inventory-yaml)
- [Task 3 Ansible Vault - Yaml inventory](#task-3-ansible-vault---yaml-inventory)

## Prepare

We will need the servers, __ansible__, __server1__ ,__server2__, __server3__ and __server4__ to be up and running - by default they are started after creation

## Task 1 Ansible-vault

[Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html)

In this lab we will work with ansible-vault to encrypt sensitive data as passwords

First we need to remove the password for the windows servers in the ansible-hosts file

```bash
cd

vi ansible-hosts

```

In vi go to the line ansible_password=SomeThingSimple8

**type:**

in vi dd will remove the line

```bash
dd

[windowsservers:vars]
ansible_user=jesbe
ansible_password=SomeThingSimple8   <--------- Make sure the marker is at this line
ansible_port=5985
ansible_connection=winrm
ansible_winrm_transport=ntlm
ansible_winrm_message_encryption=always
```

**Type:**

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](pics/031_remove_password.png?raw=true "remove password")

Next lets create an encryptet var file for ansible

**Type:**

```bash
cd

ansible-vault create secret.yml

```

You will be promptet for a password and to confirm the password

![Alt text](pics/032_create_vault.png?raw=true "create vault")

ansible-vault will open your default editor - in our case its vi

In vi **type:**

```bash
i (for input)

---

windows_password: SomeThingSimple8   <------ Type your Windows password here

```

**Type:**

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](pics/033_create_vault_save.png?raw=true "edit vault")

Try to cat the file

**Type:**

```bash

cat secret.yml

```

![Alt text](pics/034_cat_vault.png?raw=true "cat vault")

To change the content of an encryptet file use ansible-vault edit filename

You will need to type your password again ..

**Type:**

```bash

ansible-vault edit secret.yml

```

![Alt text](pics/034_edit_vault.png?raw=true "edit vault")

Lets create a playbook to use the encryptet var file

In VSCode

Create a new file 01_vault.yml

**Type:**

```ansible
---
- hosts: windowsservers
  collections:
    - ansible.windows
  vars_files:
    - ~/secret.yml
  vars:
    ansible_password: "{{ windows_password }}"
  tasks:
  - name: Install IIS (Web-Server only)
    win_feature:
      name: Web-Server
      state: present
```

Save the file

Notice that Git detects the changed file, do a commit add a comment "Vault" and Sync to Git

![Alt text](pics/035_vault_playbook.png?raw=true "vault playbook")

On server ansible do a git pull and run the playbook

```bash

cd ansibleclass

git pull

ansible-playbook 01_vault.yml --ask-vault-pass

```

![Alt text](pics/036_vault_playbook_run.png?raw=true "vault playbook run")

## Task 2 Ansible Inventory yaml

Another option for the inventory is using a yaml file instead of the ini format, the yaml file will give us some other options for the vault

Lets create a new ansible-hosts.yml

Copy the following inventory to ansible-hosts.yml

**Note:**

We need to set an option in vi before pasteing the configuration

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

**Type:**

```bash

cd

vi ansible-hosts.yml

Hit Esc-key

:set paste <Hit Enter>

Hit Esc-key

i (to toggle insert)
```

![Alt text](pics/037_set_paste.png?raw=true "vi paste")

Note that it now writes -- INSERT (paste) -- in the bottom

You can do a copy/paste of the inventory

![Alt text](pics/037_yaml_inventory.png?raw=true "yaml inventory")

**Type:**

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

**Type:**

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](pics/038_ansible_cfg.png?raw=true "config")

Do a ping test to check if we are using the new inventory

```bash

ansible linuxservers -m ping

```

![Alt text](pics/039_ansible_yaml_test.png?raw=true "test yaml inventory")

## Task 3 Ansible Vault - Yaml inventory

In this task we will encrypt the password for the windows servers and place it in the new yaml inventory file

Encrypt you password

**Type:**

```bash

ansible-vault encrypt_string 'SomeThingSimple8' --name ansible_password

```

![Alt text](pics/040_ansible_vault_string.png?raw=true "Encrypt string")

Copy the string

![Alt text](pics/041_ansible_vault_string_copy.png?raw=true "Encrypt string copy")

Paste the encryptet string into ansible-hosts.yml

When copied you might need to indent the lines with spaces so it placed under the first S in password, se the picture

```bash

cd

vi ansible-hosts.yml

Hit Esc-key

:set paste <Hit Enter>

Hit Esc-key

i (to toggle insert)

```

Save the inventory file

**Type:**

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](pics/042_inventory_encrypt.png?raw=true "inventory encryptet string")

Lets do a test with win_ping

```bash

ansible windowsservers -m win_ping --ask-vault-pass

```

![Alt text](pics/043_win_ping.png?raw=true "win ping")

Lab done

[Work with Playbooks](../lab04/lab4.md)
