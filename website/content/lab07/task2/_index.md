---
title: Create a role - part 1
weight: 20
---

## Task 2 Create a role - part 1

Now we will create our own Role, webserver installing and configuring httpd and php

The role will be placed in the same git repository as we are using for the playbooks, but could have been placed in a seperate repo and committed to Ansible-Galaxy

We will use ansible-galaxy command to initialize a role template

Its important that you do a git pull before we are adding anything in the folders

On

![ansible](/images/ansible.png)

__Type:__

```bash

cd  ansibleclass

git pull

mkdir roles

cd roles

ansible-galaxy init webserver

ls -al

```

![Alt text](images/007_ansible_galaxy_init.png?raw=true "ansible galaxy init")

Now lets add, commit and push this to our git repo so we can work with the role in VSCode

On

![ansible](/images/ansible.png)

__Type:__

```bash

cd

cd ansibleclass

git add .

git commit -m "Adding roles"

git push origin main

```

![Alt text](images/008_ansible_git_push.png?raw=true "ansible git push")

In

![vscode](/images/student-vscode.png)

Do a push/pull to get the changes, you should see the roles \ webserver with all the default content

![Alt text](images/009_vscode_push_pull.png?raw=true "vscode push pull")
