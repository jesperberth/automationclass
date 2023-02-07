---
title: Shell module
weight: 20
---

## Task 2 Run shell module

[Ansible Docs - shell module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/shell_module.html)

Create a new file in Vscode 02_stat.yml

__Type:__

```ansible
---
- name: Use Ansible Shell
  hosts: linuxservers
  become: true

  tasks:
    - name: Check if aws-cli is installed
      ansible.builtin.stat:
        path: /usr/local/aws-cli
      register: awsinstallfile

    - name: Install aws-cli
      ansible.builtin.shell: |
        ~/aws/install
      when: not awsinstallfile.stat.exists

```

Save, Commit and push

![Alt text](images/001_ansible_stat2_playbook.png?raw=true "ansible stat playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 02_stat.yml --ask-become-pass

```

![Alt text](images/002_ansible_stat2_playbook_run.png?raw=true "ansible stat playbook run")

On the ansible server run the playbook one more time

__Type:__

```bash

ansible-playbook 02_stat.yml --ask-become-pass

```

![Alt text](images/003_ansible_stat2_playbook_run.png?raw=true "ansible stat playbook run second")
