# Lab 3: Work with Playbooks

Use Variables, prompts, facts, conditions and handlers in Playbooks

## Prepare

We will need the servers, ansible, server1, server2 and server3 to be up and running - by default they are started after creation

## Task 1: Using variables in a playbook

[ansible docs](https://docs.ansible.com/ansible/2.5/user_guide/playbooks_variables.html)

[ansible timezone](https://docs.ansible.com/ansible/latest/modules/timezone_module.html)

In the file explorer part of VSCode rigth click on the pane below the "ANSIBLECLASS"

Name it "02_linux.yml"

Write the following in the text pane

__Type:__

```ansible
---
- hosts: linuxservers
  become: yes

  vars:
    timezone: "Europe/Copenhagen"

  tasks:
  - name: Set timezone
    timezone:
      name: "{{ timezone }}"
```

Save the file

Notice that Git detects the changed file, do a commit add a comment "Variables" and Sync to Git

![Alt text](pics/001_timezone.png?raw=true "playbook in VSCode")

On server ansible do a git pull and run the playbook

__Type:__

```ansible
cd ansibleclass

git pull

ansible-playbook 02_linux.yml --ask-become-pass

```

![Alt text](pics/002_run_timezone.png?raw=true "run playbook")


Next Lab

[Cloud Playbooks](../lab04/lab4.md)
