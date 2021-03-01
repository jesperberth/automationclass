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

__Name:__ userx_project

__Organization:__ Training

__SCM Type:__ Git

__SCM URL:__ paste your github repo url

__Update Revision on Launch:__ Checked

Leave the rest, click __Save__

![Alt text](pics/02_ansible_tower_create_project.png?raw=true "Create a project")

In the left pane, click Inventory

Click on the Green Plus sign to create a new inventory

Type

__Name:__ userx_inventory

__Organization:__ Training

Leave the rest, click __Save__

![Alt text](pics/03_ansible_tower_create_inventory.png?raw=true "Create an inventory")

In the left pane, click credentials

Click on the Green Plus sign to create a new Credential

Type

__Name:__ userx_credential

__Organization:__ Training

Click on the "Credential Type

![Alt text](pics/04_ansible_tower_create_credential.png?raw=true "select credential type")

And select

Microsoft Azure Resource Manager

From the Azure Lab - Lab 04 find the credentials you used

__Hint:__ On server ansible cat ~/.azure/credentials

Type

__Subscribtion:__ xxxxx-xxxxx-xxxxx-xxxxx-xxxxx

__Client ID:__ xxxxx-xxxxx-xxxxx-xxxxx-xxxxx

__Client Secret:__ xxxxx-xxxxx-xxxxx-xxxxx-xxxxx

__Tenant ID:__ xxxxx-xxxxx-xxxxx-xxxxx-xxxxx

Leave the rest as default and click __Save__

![Alt text](pics/05_ansible_tower_create_credential_filled.png?raw=true "Create credential")

## Task 3: Create Azure RM Template

In VSCode

Create a copy of 01_azure.yml -> 01_azure_tower.yml

Change the variable user: - We already have a Resource Group called Webserver_userx so you need to change it

to __webuserx eg. "webuser1"__

Save and Commit

![Alt text](pics/06_ansible_tower_playbook.png?raw=true "Tower playbook")

In Tower go to project and refresh your project, this will do a "git pull"

![Alt text](pics/07_ansible_tower_refresh.png?raw=true "Refresh project")

In the left pane, click Templates

Click on the Green Plus sign to create a new Template select the __Job template__ type

Type

__Name:__ userx_resourcegroup

__Job Type:__ Run

__Inventory:__ Select your own inventory

__Project:__ Select your own project

__Playbook:__ 01_azure_tower.yml

__Credentials:__ Select credential type "Microsoft Azure Resource Manager" and your own credentials

Leave the rest as default and click __Save__

![Alt text](pics/08_ansible_tower_template.png?raw=true "Create template")

Click on the "Launch" button and wait a minute to see the result

![Alt text](pics/09_ansible_tower_template_run.png?raw=true "Run template")

## Task 4: Create Azure Webserver template

In VSCode

Create a copy of 02_azure.yml -> 02_azure_tower.yml

Change the variable user: - We already have a Resource Group called Webserver_userx so you need to change it

to __webuserx eg. "webuser1"__

Remove the following lines from the playbook:

First line is under the vars section

```bash
ssh_public_key: "{{lookup('file', '~/.ssh/id_rsa.pub') }}"
```

and __Remove__ the two last lines in the playbook

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

__Name:__ userx_webserver

__Job Type:__ Run

__Inventory:__ Select your own inventory

__Project:__ Select your own project

__Playbook:__ 02_azure_tower.yml

__Credentials:__ Select credential type "Microsoft Azure Resource Manager" and your own credentials

__In the Extra Vars:__ add the ssh_public_key make sure you have " before and after the key

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

## Task 5: Create Azure Dynamic Inventory

Change the Inventory to a dynamic azure inventory

Eventhoug Ansible Tower has an Dynamic Inventory, we will use the on created earlier as it will give us the tags

In the left pane click on Inventory

Select your own inventory userx_inventory

Click on the Source button on the top

Click on the Green + to create a new source

__Name:__ Azure_userx

__Source:__ Sourced from a Project

__Credential:__ userx_credential

__Project:__ userx_project

__Inventory File:__ webserver.azure_rm.yml

__Overwrite:__ Checked

__Updata on Launch:__ Checked

Leave the rest as default

Click __Save__

![Alt text](pics/14_azure_inventory.png?raw=true "azure inventory")

Scroll down and click on the Sync button to the right, the gray cloud to the left should turn green

![Alt text](pics/15_azure_inventory_sync.png?raw=true "azure inventory sync")

## Task 6: Create Webserver credential

We need the __private__ ssh key from server ansible

Log on to server "ansible" using ssh

and retrive your public key

__Type:__

```bash

cd

cat ~/.ssh/id_rsa

```

Mark the key and copy it to the clipboard, you will need it when we create the next Job Template

![Alt text](pics/16_ssh_key.png?raw=true "cat private key")

Create a new credential matching the webservers public key

Click on Credentials in the left pane

Click on the green + to create a new credential

__Name:__ userx_webserver

__Organization:__ Training

Credential Type: Machine

__Username:__ __webuserx__ <---- Change to your username

__SSH Private Key:__ --- the key you copied ---

Leave the rest as default and click __Save__

![Alt text](pics/17_create_ssh_cred.png?raw=true "create cred")

## Task 7: Create Webserver Template

In VSCode

Create a copy of 01_webserver_azure.yml -> 01_webserver_azure_tower.yml

Change the hosts: to match your webuserx

- hosts: tag_solution_webserver_webuserx

Remove both vars:

websiteheader: "Ansible Playbook"
websiteauthor: "Some Name"

![Alt text](pics/18_webserver_playbook.png?raw=true "playbook")

Save and commit

Go to your project and sync

In the left pane, click Templates

Click on the Green Plus sign to create a new Template select the __Job template__ type

Type

__Name:__ userx_webserver_install

__Job Type:__ Run

__Inventory:__ Select your own inventory

__Project:__ Select your own project

__Playbook:__ 01_webserver_azure_tower.yml

__Credentials:__ Select credential type "Machine" and your own credentials

Leave the rest as default and click __Save__

![Alt text](pics/19_webserver_template_create.png?raw=true "Create template")

## Task 8: Create Workflow template

In the left pane, click Templates

Click on the Green Plus sign to create a new Template select the __Workflow template__ type

__Name:__ Userx

__Organization:__ Training

__Inventory:__ Select your own inventory

Leave the rest as default and click __Save__

![Alt text](pics/20_workflow_create.png?raw=true "Create workflow template")

The window changes to the workflow Visualizer

Click on Start

__Select:__ Template

__Select:__ userx_resourcegroup

Press the __Select__ Button

![Alt text](pics/21_work_step1.png?raw=true "Create workflow template step 1")

Click on the green + on the new userx_resourcegroup

__Select:__ Template

__Select:__ userx_webserver

Press the __Select__ Button

![Alt text](pics/23_work_step3.png?raw=true "Create workflow template step 3")

Click on the green + on the new userx_webserver

__Select:__ Inventory Sync

__Select:__ Azure_userx

Press the __Select__ Button

![Alt text](pics/24_work_step4.png?raw=true "Create workflow template step 3")

Click on the green + on the new Azure_userx

__Select:__ Template

__Select:__ userx_webserver_install

Press the __Select__ Button

Press the __Save__ Button

![Alt text](pics/25_work_step5.png?raw=true "Create workflow template step 4")

Click Survey to add the two vars we deleted in the playbook  websiteheader: and websiteauthor:

__Prompt:__ Web Site Name

__Answer variable name:__ websiteheader

__Answer Type:__ Text

Press the __Add__ Button

![Alt text](pics/25_survey_1.png?raw=true "Create survey 1")

__Prompt:__ Web Site author

__Answer variable name:__ websiteauthor

__Answer Type:__ Text

Press the __Add__ Button

Press the __Save__ Button

![Alt text](pics/26_survey_2.png?raw=true "Create survey 2")

Click __Save__

## Task 9: Run Workflow template

In the left pane click Templates, click on the Rocket to Launch

![Alt text](pics/27_run_workflow.png?raw=true "Launch workflow")

Fill out the survey

![Alt text](pics/28_run_workflow_survey.png?raw=true "Launch workflow survey")

Click Launch on the result page

![Alt text](pics/29_run_workflow_survey_result.png?raw=true "Launch workflow survey result")

Wait for the workflow to finish

![Alt text](pics/30_workflow_result.png?raw=true "Launch workflow result")

Go check the new website, get the ip from the "Details" in userx_webserver Template

![Alt text](pics/30_workflow_result_details.png?raw=true "Launch workflow result Details")

Get the ip

![Alt text](pics/31_workflow_result_details_ip.png?raw=true "Get IP")

Open your webbrowser

```bash
http://<your ip>
```

Lab done

[Ansible Exercise](../lab09/lab9.md)
