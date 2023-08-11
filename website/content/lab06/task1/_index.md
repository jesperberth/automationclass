---
title: Stat Module
weight: 10
---

## Task 1 Stat Module

[Ansible Docs - stat module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/stat_module.html)

Create a new file in Vscode 01_stat.yml

__Type:__

```ansible
---
- name: Use Ansible Stat
  hosts: linuxservers
  become: true

  tasks:
    - name: Check if aws-cli is downloaded
      ansible.builtin.stat:
        path: ~/awscliv2.zip
      register: awsfile

    - name: Debug awsfile
      ansible.builtin.debug:
        msg: "{{ awsfile }}"

    - name: Download aws-cli
      ansible.builtin.get_url:
        url: https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
        dest: ~/awscliv2.zip
        mode: '0700'
      when: not awsfile.stat.exists

    - name: Unzip aws-cli
      ansible.builtin.unarchive:
        src: ~/awscliv2.zip
        dest: ~/
        remote_src: true

```

Save, Commit and push

![Alt text](images/001_ansible_stat_playbook.png?raw=true "ansible stat playbook")

On

![ansible](/images/ansible.png)

Pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_stat.yml --ask-become-pass

```

![Alt text](images/002_ansible_stat_playbook_run.png?raw=true "ansible stat playbook run")

Try to run the play again

The download task will have status __skipping__ and the unzip task will have status __ok__

```bash

ansible-playbook 01_stat.yml --ask-become-pass

```

![Alt text](images/003_ansible_stat_playbook_second_run.png?raw=true "ansible stat playbook run")
