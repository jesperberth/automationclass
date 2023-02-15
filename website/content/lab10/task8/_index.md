---
title: Create Webserver Template
weight: 80
---

## Task 8 Create Webserver Template

In VSCode

Create a copy of 01_webserver_azure.yml -> 01_webserver_azure_tower.yml

Change the hosts: to match your initials

- hosts: __tag_solution_webserver_jesbe__

Remove both vars:

websiteheader: __Ansible Playbook__

websiteauthor: __Some Name__

![Alt text](images/18_webserver_playbook.png?raw=true "playbook")

Save and commit

Go to your project and sync

In the left pane, click __Templates__

Click on __Add__ to create a new Template select the __Add Job template__ type

Type

__Name:__ Webserver_install

__Job Type:__ Run

__Inventory:__ Select Inventory

__Project:__ Select Project

__Playbook:__ 01_webserver_azure_tower.yml

__Credentials:__ Select credential type "Machine" and Webserver

Leave the rest as default and click __Save__

![Alt text](images/19_webserver_template_create.png?raw=true "Create template")
