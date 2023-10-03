---
title: Delete Resource Group Webserver
weight: 70
---

## Task 7 Delete Resource Group Webserver

We need to delete the webserver_{{user}} Resource group from Azure before we can start on the next lab

In

![vscode](/images/student-vscode.png)

Create a new file __03_azure.yml__

Add the following text to the file, change the name of the variable __user__ to your initials use the same as you use to login to ansible server

```ansible
---
- name: Remove Webserver
  hosts: localhost
  connection: local
  vars:
    user: write your username here

  tasks:
    - name: Delete resource group
      azure_rm_resourcegroup:
        name: "webserver_{{ user }}"
        location: northeurope
        state: absent
        force_delete_nonempty: true

```

![Alt text](images/025_delete_rg.png?raw=true "delete rg")

Save and commit to Git

On

![ansible](/images/ansible.png)

Pull the new playbook and run it

__Type:__

```bash

cd ansibleclass

git pull

ansible-playbook 03_azure.yml

```

![Alt text](images/026_delete_rg_run.png?raw=true "delete rg run")
