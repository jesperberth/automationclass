---
title: Modify AWX with playbook
weight: 20
---

## Task 2 Modify AWX with playbook

We can use ansible playbooks to create, change or remove objects in AWX

In Task 1 you took a tour round the AWX interface, by default the installation creates the following objects, we will create a ansible playbook to remove these items

- Demo Inventory
- Demo Project
- Demo Credential
- Demo Job Template

First we need to get a OAUTHTOKEN for AWX

In the AWX console

In the left pane, in the __Access Block__ click __Users__

Select the user "Admin"

![Alt text](images/01_ansible_tower_adminuser.png?raw=true "select admin user")

Click __Tokens__

![Alt text](images/02_ansible_tower_token.png?raw=true "admin token")

Click __Add__

In the Create User Token window

Select __Write__ in the Scope dropdown box click save

![Alt text](images/03_ansible_tower_create_token.png?raw=true "create admin token")

The Token will only be visible one time so copy the token and save it in a notepad we need it in a monment

![Alt text](images/04_ansible_tower_view_token.png?raw=true "view admin token")

On

![ansible](/images/ansible.png)

We need to set three Environment variables

Change the IP to your awx host

Change the OAUTH_TOKEN to the one you just created

Run all three export commands on the ansible server

__Type:__

```bash

export CONTROLLER_HOST=http://68.219.213.172
export CONTROLLER_USERNAME=admin
export CONTROLLER_OAUTH_TOKEN=oKux6ADwqn127BK3Ov4WjfbPjtPG16

```

![Alt text](images/05_ansible_tower_export_token.png?raw=true "export token")

In VSCode create a new playbook 01_awx.yml

Add below to the playbook

```ansible
---
- name: Clean up AWX
  hosts: localhost
  connection: local

  tasks:
    - name: Remove Demo Template
      awx.awx.job_template:
        name: Demo Job Template
        organization: Default
        state: absent

    - name: Remove Demo credential
      awx.awx.credential:
        name: Demo Credential
        credential_type: Machine
        state: absent

    - name: Remove Demo inventory
      awx.awx.inventory:
        name: Demo Inventory
        organization: Default
        state: absent

    - name: Remove Demo project
      awx.awx.project:
        name: Demo Project
        organization: Default
        state: absent

```

![Alt text](images/06_create_awx_playbook.png?raw=true "awx playbook")

Save and commit to Git

On

![ansible](/images/ansible.png)

Pull the new playbook and run it

__Type:__

```bash

cd ansibleclass

git pull

ansible-playbook 01_awx.yml

```

![Alt text](images/07_run_awx_playbook.png?raw=true "awx playbook run")

Now go to the awx portal and take a look around, Demo Template, Credential, Inventory and Project is gone
