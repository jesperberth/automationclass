---
title: Create Azure RM Template
weight: 40
---

## Task 4 Create Azure RM Template

In VSCode

Create a copy of 01_azure.yml -> 01_azure_tower.yml

Change the variable user: - it should be your initials as we copied your working playbook from previous lab

to __your initials eg. "jesbe"__

Save and Commit

![Alt text](images/06_ansible_tower_playbook.png?raw=true "Tower playbook")

In Tower go to project and __refresh__ your project, this will do a "git pull"

The Revision will change matching the git revision

![Alt text](images/07_ansible_tower_refresh.png?raw=true "Refresh project")

In the left pane, click __Templates__

Click on __Add__ to create a new Template select the __Add Job template__ type

Type

__Name:__ Resourcegroup

__Job Type:__ Run

__Inventory:__ Inventory

__Project:__ Project

__Playbook:__ 01_azure_tower.yml

__Credentials:__ Select credential type "Microsoft Azure Resource Manager" and Azure Credentials

Leave the rest as default and click __Save__

![Alt text](images/08_ansible_tower_template.png?raw=true "Create template")

Click on the "Launch" button and wait a minute to see the result

![Alt text](images/09_ansible_tower_template_run.png?raw=true "Run template")
