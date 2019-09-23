# Lab 3: Work with Playbooks

Use Variables, prompts, facts, conditions and handlers in Playbooks

## Prepare

We need to start servers, ansible, server1, server2 and server3

In Azure Cloud Shell(Bash)

``` bash
cd clouddrive
cd automationclass
cd setup_class
cd azure_class_playbooks

ansible-playbook 03_azure_lab3_start.yml
```

## Task 1: Using variables in a playbook

[ansible docs](https://docs.ansible.com/ansible/2.5/user_guide/playbooks_variables.html)

[ansible tímezone](https://docs.ansible.com/ansible/latest/modules/timezone_module.html)

In the file explorer part of VSCode rigth click on the pane below the "ANSIBLECLASS"

Name it "02_linux.yml"

![Alt text](pics/001_timezone.png?raw=true "playbook in VSCode")

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
      name: {{ timezone }}
```

Save the file

Notice that Git detects the changed file, do a commit add a comment "Variables" and Sync to Git

On server ansible do a git pull and run the playbook

__Type:__

```ansible
cd ansibleclass

git pull

ansible-playbook 02_linux.yml --ask-become-pass

```

![Alt text](pics/002_run_timezone.png?raw=true "run playbook")

Now lets make a variable with a prompt

In the file explorer part of VSCode rigth click on the pane below the "ANSIBLECLASS"

Name it "03_linux.yml"

![Alt text](pics/003_vars_prompt.png?raw=true "playbook in VSCode")

Write the following in the text pane

__Type:__

```ansible
---
- hosts: linuxservers
  become: yes

  vars_prompt:
    - name: timezone
      prompt: "Type the Timezone"
      private: no

  tasks:
  - name: Set timezone
    timezone:
      name: {{ timezone }}
```

Save the file

Notice that Git detects the changed file, do a commit add a comment "Prompt" and Sync to Git

On server ansible do a git pull and run the playbook

__Type:__

```ansible
cd ansibleclass

git pull

ansible-playbook 03_linux.yml --ask-become-pass

Type: Etc/UTC with - lower and upper case

```

![Alt text](pics/004_vars_prompt_run.png?raw=true "run playbook prompt")

## Task 2: Facts

Ansible facts

On server ansible run ansible linuxservers -m setup

__Type:__

```ansible
ansible linuxservers -m setup
```

![Alt text](pics/005_ansible_facts.png?raw=true "facts")

Using a filter will help a bit

__Type:__

```ansible
ansible linuxservers -m setup -a "filter=*.ipv4"
```

![Alt text](pics/006_ansible_facts_filter.png?raw=true "facts")

## Task 3: Facts and Conditions

We will add a Condition and only run the task if it matches

when: ansible_system == "Linux" or "Win32NT"

In the file explorer part of VSCode rigth click on the pane below the "ANSIBLECLASS"

Name it "04_linux_win.yml"

Write the following in the text pane

__Type:__

```ansible
---
- hosts: all

  tasks:
  - name: Ping
    ping:
    when: ansible_system == "Linux"
    ignore_errors: True

  - name: Winping
    win_ping:
    when: ansible_system == "Win32NT"
    ignore_errors: True
```

Save the file

Notice that Git detects the changed file, do a commit add a comment "Variables" and Sync to Git

![Alt text](pics/007_ansible_fact_playbook.png?raw=true "playbook in VSCode")

On server ansible do a git pull and run the playbook

__Type:__

```ansible
cd ansibleclass

git pull

ansible-playbook 04_linux_win.yml

```

![Alt text](pics/008_ansible_play.png?raw=true "playbook run")

## Task 4: Handlers

We will create a short playbook to test a handler

First task will do an dnf update on both server1 and server2 and notify the reboot handler

In VSCode create a new file 05_linux.yml

__Type:__

```ansible
---
- hosts: linuxservers
  become: yes
  
  tasks:
  - name: dnf update
    dnf:
      name: "*"
      state: latest
    notify:
      - reboot server

  handlers:
  - name: reboot server
    reboot:
```

![Alt text](pics/009_ansible_handlers.png?raw=true "handlers playbook")

Save the file

Do a commit, add a comment "handlers" and Sync to Git

On server ansible do a git pull and run the playbook

__Type:__

```ansible
cd ansibleclass

git pull

ansible-playbook 05_linux.yml --ask-become-pass

```

![Alt text](pics/010_ansible_play_handlers.png?raw=true "handlers playbook run")

It will run for a while, there is a lot of packages to update...

Do a second run of the playbook, it should stay green on "dnf update" and not do a reboot...

![Alt text](pics/011_ansible_play_handlers_2.png?raw=true "handlers playbook run 2")

Next Lab

[Cloud Playbooks](../lab04/lab4.md)
