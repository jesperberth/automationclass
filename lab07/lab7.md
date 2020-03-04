# Lab 7: Ansible Automation Platform - Ansible Tower

In this session we will use Red Hat Ansible Automation Platform to orchestrate our ansible playbooks

## Prepare

Nothing to prepare, the ansible tower is installed and prepared

## Task 1: Login to Ansible Tower

Open a browser and go to the ansible tower URL its on the whiteboard

Log in with your user and password

![Alt text](pics/01_ansible_tower_login.png?raw=true "Login to ansible tower")

Take a tour around in the UI

## Task 2: Create Project, inventory and Credential

In the left pane, click Projects

Click on the Green Plus sign to create a new project

Type

Name: userx_project

Organization: Training

SCM Type: Git

SCM URL: paste your github repo url

Update Revision on Launch: Checked

Leave the rest, click __Save__

![Alt text](pics/02_ansible_tower_create_project.png?raw=true "Create a project")

In the left pane, click Inventory

Click on the Green Plus sign to create a new inventory

Type

Name: userx_inventory

Organization: Training

Leave the rest, click __Save__

![Alt text](pics/03_ansible_tower_create_inventory.png?raw=true "Create an inventory")

In the left pane, click credentials

Click on the Green Plus sign to create a new Credential

Type

Name: userx_credential

Organization: Training

Click on the "Credential Type

![Alt text](pics/04_ansible_tower_create_credential.png?raw=true "select credential type")

And select

Microsoft Azure Resource Manager

From the Azure Lab - Lab 04 find the credentials you used

__Hint:__ On server ansible cat ~/.azure/credentials

Type

Subscribtion: xxxxx-xxxxx-xxxxx-xxxxx-xxxxx

Client ID: xxxxx-xxxxx-xxxxx-xxxxx-xxxxx

Client Secret: xxxxx-xxxxx-xxxxx-xxxxx-xxxxx

Tenant ID: xxxxx-xxxxx-xxxxx-xxxxx-xxxxx

![Alt text](pics/05_ansible_tower_create_credential_filled.png?raw=true "Create credential")

## Task 3: Create Template

In VSCode

Create a copy of 01_azure.yml -> 01_azure_tower.yml

Change the variable user: - We already have a Resource Group called Webserver_userx so you need to change it

to __webuserx eg. "webuser1"__

![Alt text](pics/06_ansible_tower_playbook.png?raw=true "Tower playbook")

In Tower go to project and refresh your project, this will do a "git pull"

![Alt text](pics/07_ansible_tower_refresh.png?raw=true "Refresh project")

In the left pane, click Templates

Click on the Green Plus sign to create a new Template select the __Job template__ type

Type

Name: userx_resourcegroup

Job Type: Run

Inventory: Select your own inventory

Project: Select your own project

Playbook: 01_azure_tower.yml

Credentials: Select credential type "Microsoft Azure Resource Manager" and your own credentials

Leave the rest as default and click __Save__

![Alt text](pics/08_ansible_tower_template.png?raw=true "Create template")

Click on the "Launch" button and wait a minute to see the result

![Alt text](pics/09_ansible_tower_template_run.png?raw=true "Run template")

## Task 4: Create Webserver template

In VSCode

Create a copy of 02_azure.yml -> 02_azure_tower.yml

Change the variable user: - We already have a Resource Group called Webserver_userx so you need to change it

to __webuserx eg. "webuser1"__

Remove the following lines from the playbook:

First line is under the vars section

```bash
ssh_public_key: "{{lookup('file', '~/.ssh/id_rsa.pub') }}"
```

and the two last lines in the playbook

```bash

  - name: Add webserver to ssh known_hosts
    shell: "ssh-keyscan -t ecdsa {{ webserver_pub_ip.state.ip_address }}  >> /home/{{ user }}/.ssh/known_hosts"
```

Save and Commit

![Alt text](pics/10_ansible_tower_playbook_webserver.png?raw=true "Tower playbook")

In Tower go to project and refresh your project, this will do a "git pull"

![Alt text](pics/07_ansible_tower_refresh.png?raw=true "Refresh project")

We need the public ssh key from server ansible

Log on to server "ansible" using ssh

and retrive your public key

__Type:__

```bash

cd

cat ~/.ssh/id_rsa.pub

```

Mark the key and copy it to the clipboard, you will need it when we create the next Job Template

![Alt text](pics/08_cat_public_key.png?raw=true "cat public key")

Back in the Tower UI

In the left pane, click Templates

Click on the Green Plus sign to create a new Template select the __Job template__ type

Type

Name: userx_webserver

Job Type: Run

Inventory: Select your own inventory

Project: Select your own project

Playbook: 02_azure_tower.yml

Credentials: Select credential type "Microsoft Azure Resource Manager" and your own credentials

In the Extra Vars: add the ssh_public_key make sure you have " before and after the key

```bash
---
ssh_public_key: "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCl/myugJcFI/2XmWcLd5P+tKVtbsGf83G/POHH3vc4p3fyLaGKUqaX8YBOLohJ5XFB9t25Tg8wZleCsbDm0s081jx4tdvudRhdqUMbA+n3oHRB3SHD7BLm7d13VgGlM6SCxnkIgrePFaSWsX+J5kk3rhxpo0LEEiGDgTdUDYz3wNypEBsal+eoFp1WHXArnkbl6FkEhOC8iZSJY2KKsJlv6xFXN1NlM/KWkgFdlB+tWps49Cl44IAMHgcjku+Xx+00trgWX89isK54MHWUXHTTPzOykaagLQXcwZZmZvy/84qdDBcRhehSwg7LxHAMjFEYCSpAE78AWoBNpB3lhR0r jesbe@ansible"

```

Leave the rest as default and click __Save__

![Alt text](pics/11_ansible_tower_webserver_template.png?raw=true "template")

In the left pane click on Templates

Locate your userx_webserver template and click on the Rocket to lauch it

![Alt text](pics/12_launch_template.png?raw=true "launch template")

Wait for template to finish

![Alt text](pics/13_launch_template_run.png?raw=true "launch template")

## Task 5: Create Dynamic Inventory

Change the Inventory to a dynamic azure inventory

In the left pane click on Inventory

Select your own inventory userx_inventory

Click on the Source button on the top

Click on the Green + to create a new source

Name: Azure

Source: Microsoft Azure Resource Manager

Credential: userx_azure

Leave the rest as default

Click Save

![Alt text](pics/14_azure_inventory.png?raw=true "azure inventory")

Scroll down and click on the Sync button to the right, the gray cloud to the left should turn green

![Alt text](pics/15_azure_inventory_sync.png?raw=true "azure inventory sync")


Lab done

[Ansible Exercise](../lab08/lab8.md)
