---
title: Lookup
weight: 40
---

## Task 4 Lookup

[Ansible Docs - Plugin Lookup](https://docs.ansible.com/ansible/latest/plugins/lookup.html)

In

![vscode](/images/student-vscode.png)

Create a new text file __file.txt__

Add this line

```text
dev-environment

```
In

![vscode](/images/student-vscode.png)

Create a new file __01_lookup.yml__

```ansible
---
- name: Lookup
  hosts: linuxservers

  vars:
    file_contents: "{{ lookup('file', 'file.txt') }}"

  tasks:
    - name: Debug Print File Content
      ansible.builtin.debug:
        msg: "{{ file_contents }}"

```

Save, Commit and push

![Alt text](images/001_ansible_lookup.png?raw=true "ansible delegate playbook")

On

![ansible](/images/ansible.png)

Pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_lookup.yml

```

![Alt text](images/002_ansible_lookup_playbook_run.png?raw=true "ansible delegate playbook run")
