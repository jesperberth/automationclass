# Lab 3: Work with Playbooks

Use Variables, prompts, facts and handlers in Playbooks

## Prepare

We need to start servers, ansible, server1 and server2

In Azure Cloud Shell(Bash)

``` bash
cd clouddrive
cd automationclass
cd setup_class
cd azure_class_playbooks

ansible-playbook 04_azure_lab3_start.yml
```

## Task 1: Using variables in a playbook

[ansible docs](https://docs.ansible.com/ansible/2.5/user_guide/playbooks_variables.html)

In the file explorer part of VSCode rigth click on the pane below the "ANSIBLECLASS"

![Alt text](pics/015_code_newfile.png?raw=true "new file in VSCode")

Name it "02_linux.yml"

![Alt text](pics/001_timezone.png?raw=true "playbook in VSCode")

Write the following in the text pane

```ansible
---
- hosts: linuxservers
  become: yes

  vars:
    zone: "Europe/Copenhagen"

  tasks:
  - name: Set timezone
    timezone:
      name: {{ timezone }}
```

Save the file

Notice that Git detects the changed file, do a commit add a comment "Variables" and Sync to Git

On server ansible do a git pull and run the playbook

```ansible
cd ansibleclass

git pull

ansible-playbook 02_linux.yml --ask-become-pass

```

![Alt text](pics/002_run_timezone.png?raw=true "run playbook")
