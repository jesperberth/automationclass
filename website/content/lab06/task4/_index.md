---
title: Lookup
weight: 40
---

## Task 4 Lookup

[Ansible Docs - Plugin Lookup](https://docs.ansible.com/ansible/latest/plugins/lookup.html)

Create a new text file __file.txt__

Add this line

```text
dev-environment
```

Create a new file 01_lookup.yml

```ansible
---
- name: Lookup
  hosts: linuxservers

  vars:
     environmentvar: "{{ lookup('file', 'file.txt') }}"

  tasks:
    - name: Debug Write File Content
      ansible.builtin.debug:
        msg: "{{ environmentvar }}"

```

Save, Commit and push

![Alt text](images/001_ansible_lookup.png?raw=true "ansible delegate playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_lookup.yml

```

![Alt text](images/002_ansible_lookup_playbook_run.png?raw=true "ansible delegate playbook run")
