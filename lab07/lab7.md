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

Change the variable user:

to username-tower eg. "user1-tower"

![Alt text](pics/06_ansible_tower_playbook.png?raw=true "Create credential")

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

Leave the reset as default and click __Save__

![Alt text](pics/08_ansible_tower_template.png?raw=true "Create template")

Lab done

[Ansible Exercise](../lab08/lab8.md)
