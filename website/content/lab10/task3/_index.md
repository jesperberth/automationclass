---
title: Create Project inventory and Credential
weight: 30
---

## Task 3 Create Project inventory and Credential

In the left pane, click __Projects__

Click __Add__ to create a new project

Type

__Name:__ Project

__Organization:__ Default

__SCM Type:__ Git

__SCM URL:__ paste your github repo url

__Update Revision on Launch:__ Checked

Leave the rest, click __Save__

![Alt text](images/02_ansible_tower_create_project.png?raw=true "Create a project")

In the left pane, click __Inventory__

Click __Add__ to create a new inventory, select __Add Inventory__

Type

__Name:__ Inventory

__Organization:__ Default

Leave the rest, click __Save__

![Alt text](images/03_ansible_tower_create_inventory.png?raw=true "Create an inventory")

In the left pane, click __credentials__

Click on __Add__ to create a new Credential

Type

__Name:__ Azure Credential

__Organization:__ Default

Click on the __Credential Type__ and select

Microsoft Azure Resource Manager

From the Azure Lab - Lab 04 find the credentials you used

__Hint:__ On server ansible cat ~/.azure/credentials

Type

__Subscribtion:__ xxxxx-xxxxx-xxxxx-xxxxx-xxxxx

__Client ID:__ xxxxx-xxxxx-xxxxx-xxxxx-xxxxx

__Client Secret:__ xxxxx-xxxxx-xxxxx-xxxxx-xxxxx

__Tenant ID:__ xxxxx-xxxxx-xxxxx-xxxxx-xxxxx

Leave the rest as default and click __Save__

![Alt text](images/05_ansible_tower_create_credential_filled.png?raw=true "Create credential")

Lets test that our Azure credentials works

In VSCode

Create a new file 00_azure_tower.yml add the following

```ansible
---
- name: Azure Create RG
  hosts: localhost
  connection: local

  tasks:
  - name: Get facts for all resource groups
    azure_rm_resourcegroup_info:

```

Save and Commit

![Alt text](images/06_ansible_tower_playbook.png?raw=true "Tower playbook")

In Tower go to project and __refresh__ your project, this will do a "git pull"

The Revision will change matching the git revision

![Alt text](images/07_ansible_tower_refresh.png?raw=true "Refresh project")

In the left pane, click __Templates__

Click on __Add__ to create a new Template select the __Add Job template__ type

Type

__Name:__ AzureTest

__Job Type:__ Run

__Inventory:__ Inventory

__Project:__ Project

__Playbook:__ 00_azure_tower.yml

__Credentials:__ Select credential type "Microsoft Azure Resource Manager" and Azure Credentials

Leave the rest as default and click __Save__

![Alt text](images/08_ansible_tower_template.png?raw=true "Create template")

Click on the __Launch__ button

![Alt text](images/09_ansible_tower_template_run.png?raw=true "Run template")

Wait for the play to run, if Successful it will list all Resource Groups in Azure

![Alt text](images/10_ansible_tower_template_run_finish.png?raw=true "Run template")
