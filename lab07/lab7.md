# Lab 7: Ansible Automation Platform - Ansible Tower

In this session we will use Red Hat Ansible Automation Platform to orchestrate our ansible playbooks

## Prepare

Nothing to prepare, the ansible tower is installed and prepared

## Task 1: Login to Ansible Tower

Open a browser and go to the ansible tower URL its on the whiteboard

Log in with your user and password

![Alt text](pics/01_ansible_tower_login.png?raw=true "Login to ansible tower")

Take a tour around in the UI

In the left pane, click Projects

Click on the Green Plus sign to create a new project

Type a Name: userx_project

Organization: Training

SCM Type: Git

SCM URL: paste your github repo url

Update Revision on Launch: Checked

Leave the rest, click __Save__

![Alt text](pics/02_ansible_tower_create_project.png?raw=true "Create a project")

Lab done

[Ansible Exercise](../lab08/lab8.md)
