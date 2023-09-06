---
title: Create the first playbook
weight: 10
---

## Task 1 Create the first playbook

In

![vscode](/images/student-vscode.png)

In the file explorer part of VSCode rigth click on the pane below the "ANSIBLECLASS"

![Alt text](images/015_code_newfile.png?raw=true "new file in VSCode")

Name it "01_linux.yml"

Write the following in the text pane

```ansible
---
- hosts: linuxservers
  become: yes

  tasks:
  - name: Create file
    file:
      path: /root/testfile.txt
      state: touch

```

Save the file (Ctrl + S)

Ansible Linting will load and mark Problems

__Note:__ First time saving the playbook, ansible lint will take a few minutes to run as it has to download the container image from the repository

![Alt text](images/016_ansible_lint.png?raw=true "Ansible lint in VSCode")

Click on __Problems__ tab

There are four problems that we need to fix

The Playbook will run as is, but following the rules might prevent errors in the future

![Alt text](images/016_lint_errors.png?raw=true "lint errors")

From the top:

* Truthy value should be one of false, true - yes and no works but the correct way is a true

* USE FQCN for builtin module actions, we should always refer to the FQCN - ansible.builtin.file is correct

* All plays should be named - __- name: First Playbook__

* File permissions is unset or incorrect

Take a look at the documentation for the file module

[Ansible File Module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/file_module.html)

Add the mode: in the file task

The playbook should look like this

```ansible
---
- name: First Playbook
  hosts: linuxservers
  become: true

  tasks:
  - name: Create file
    ansible.builtin.file:
      path: /root/testfile.txt
      state: touch
      mode: '0755'

```

![Alt text](images/016_code_playbook_fixed.png?raw=true "playbook in VSCode fixed")

Now commit and sync our changes to GitHub

Click the Source control button in the left panel.

![Alt text](images/016_code_playbook.png?raw=true "playbook in VSCode")

Write a comment __First Playbook__ and click "Ctrl + Enter" to commit the changes or click the Blue __Commit__ button

Click __Yes__ to stage all your changes

![Alt text](images/018_code_git_sync.png?raw=true "git sync in VSCode")

Sync the changes with GitHub, you can use the blue __Sync Changes__ button or click on the Sync button in the blue bar at the bottom, 0 up, 1 down it will start the sync process

Click __Ok__ in the dialog push/pull to origin/main

![Alt text](images/018_code_git_sync_button.png?raw=true "git sync in VSCode")

The first time you will be prompted for github credentials

![Alt text](images/019_code_git_sync_login.png?raw=true "git login in VSCode")

On

![github](/images/github.png)

Open the Git Hub repository, the 01_linux.yml is now added, note the comment next to the filename

![Alt text](images/020_github_new.png?raw=true "github new file")

On

![ansible](/images/ansible.png)

Run the playbook

__Type:__

```bash
cd ansibleclass

ls

ansible-playbook 01_linux.yml

```

![Alt text](images/023_run_playbook.png?raw=true "Run playbook")
