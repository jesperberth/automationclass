---
title: Ansible Collections
weight: 50
---

## Task 5 Ansible Collections

In ansible 2.10 and forward, most modules will be delivered from collections via [Ansible Galaxy](https://galaxy.ansible.com)

[Ansible Galaxy Docs](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html)

We need to create the roles and collections folder in .ansible

__Type:__

```bash
cd

mkdir .ansible/roles

mkdir .ansible/collections
```

![Alt text](images/022_ansible_roles_dir.png?raw=true "create roles dir")

List existing collections (should be none)

__Type:__

```bash

ansible-galaxy collection list

```

![Alt text](images/023_ansible_collection_list.png?raw=true "list collections")

Lets install the ansible Windows Collection, we need it in the next lab

ansible.windows is already installed from the standard ansible package, but a new version is available

__Type:__

```bash

ansible-galaxy collection install ansible.windows

```

![Alt text](images/024_ansible_collection_install.png?raw=true "install collection")

You can list all installed modules with ansible-doc -l and filter out from collection ansible-doc -l ansible.windows for modules in the collection we just installed

__Hint:__

 You can use "q" to quit the viewing

__Type:__

```bash

ansible-doc -l

ansible-doc -l ansible.windows

```

![Alt text](images/025_ansible-doc.png?raw=true "ansible-doc -l")

You can get the documentation for a single module with ansible-doc *modulename*

__Type:__

```bash

ansible-doc ansible.windows.win_feature

```

![Alt text](images/026_ansible-doc-winfeature.png?raw=true "ansible-doc -l")

## Optional Set Nano as default editor

Some ansible commands as ansible-vault will use a the default editor vi

You can change the default editor to nano or other preferred editors to do so follow the guide below

```bash

nano ~/.bashrc

```

Add the line at the end of the configuration file

```bash

export EDITOR=nano

```
