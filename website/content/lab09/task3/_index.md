---
title: Create Project inventory and Credential
weight: 30
---

## Task 3 Create Project inventory and Credential

In the left pane, click Projects

Click Add to create a new project

Type

__Name:__ Project

__Organization:__ Default

__SCM Type:__ Git

__SCM URL:__ paste your github repo url

__Update Revision on Launch:__ Checked

Leave the rest, click __Save__

![Alt text](images/02_ansible_tower_create_project.png?raw=true "Create a project")

In the left pane, click Inventory

Click Add to create a new inventory, select Add Inventory

Type

__Name:__ Inventory

__Organization:__ Default

Leave the rest, click __Save__

![Alt text](images/03_ansible_tower_create_inventory.png?raw=true "Create an inventory")

In the left pane, click credentials

Click on Add to create a new Credential

Type

__Name:__ Azure Credential

__Organization:__ Default

Click on the "Credential Type and select

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
