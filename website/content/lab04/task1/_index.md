---
title: Ansible-vault
weight: 10
---

## Task 1 Ansible-vault

[Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html)

In this lab we will work with ansible-vault to encrypt sensitive data as passwords

First we need to remove the password for the windows servers in the ansible-hosts file

On

![ansible](/images/ansible.png)

```bash
cd

vi ansible-hosts

```

In vi go to the line ansible_password=SomeThingSimple8

__type:__

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

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](images/031_remove_password.png?raw=true "remove password")

Next lets create an encryptet var file for ansible

__Type:__

```bash
cd

ansible-vault create secret.yml

```

You will be promptet for a password and to confirm the password

![Alt text](images/032_create_vault.png?raw=true "create vault")

ansible-vault will open your default editor - in our case its vi

In vi __type:__

```bash
i (for input)

---

windows_password: SomeThingSimple8   <------ Type your Windows password here

```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](images/033_create_vault_save.png?raw=true "edit vault")

Try to cat the file

__Type:__

```bash

cat secret.yml

```

![Alt text](images/034_cat_vault.png?raw=true "cat vault")

To change the content of an encryptet file use ansible-vault edit filename

You will need to type your password again ..

__Type:__

```bash

ansible-vault edit secret.yml

```

![Alt text](images/034_edit_vault.png?raw=true "edit vault")

Lets create a playbook to use the encryptet var file

In VSCode

Create a new file 01_vault.yml

__Type:__

```ansible
---
- name: Ansible Vault
  hosts: windowsservers
  vars_files:
    - ~/secret.yml
  vars:
    ansible_password: "{{ windows_password }}"
  tasks:
    - name: Install IIS (Web-Server only)
      ansible.windows.win_feature:
        name: Web-Server
        state: present

```

Save the file

Notice that Git detects the changed file, do a commit add a comment "Vault" and Sync to Git

![Alt text](images/035_vault_playbook.png?raw=true "vault playbook")

On

![ansible](/images/ansible.png)

Do a git pull and run the playbook

```bash

cd ansibleclass

git pull

ansible-playbook 01_vault.yml --ask-vault-pass

```

![Alt text](images/036_vault_playbook_run.png?raw=true "vault playbook run")
