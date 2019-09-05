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

[ansible tímezone](https://docs.ansible.com/ansible/latest/modules/timezone_module.html)

In the file explorer part of VSCode rigth click on the pane below the "ANSIBLECLASS"

Name it "02_linux.yml"

![Alt text](pics/001_timezone.png?raw=true "playbook in VSCode")

Write the following in the text pane

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

```ansible
ansible linuxservers -m setup
```

![Alt text](pics/005_ansible_facts.png?raw=true "facts")

Using a filter will help a bit

```ansible
ansible linuxservers -m setup -a "filter=*.ipv4"
```

![Alt text](pics/006_ansible_facts_filter.png?raw=true "facts")
