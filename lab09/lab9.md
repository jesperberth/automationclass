# Lab 9: Ansible AWX

In this session we will use Ansible AWX to orchestrate our ansible playbooks

## Table of Contents

- [Prepare](#prepare)
- [Task 1 Login to Ansible Tower](#task-1-login-to-ansible-tower)
- [Task 2 Create Organization Project inventory and Credential](#task-2-create-organization-project-inventory-and-credential)
- [Task 3 Create Azure RM Template](#task-3-create-azure-rm-template)
- [Task 4 Create Azure Webserver template](#task-4-create-azure-webserver-template)
- [Task 5 Create Azure Dynamic Inventory Source](#task-5-create-azure-dynamic-inventory-source)
- [Task 6 Create Webserver credential](#task-6-create-webserver-credential)
- [Task 7 Create Webserver Template](#task-7-create-webserver-template)
- [Task 8 Create Workflow template](#task-8-create-workflow-template)
- [Task 9 Run Workflow template](#task-9-run-workflow-template)

## Prepare

Nothing to prepare, the ansible tower is installed and prepared

## Task 1 Login to Ansible Tower

Open a browser and go to the ansible tower URL ip will be given by instructor

Log in user and password will be given by instructor

![Alt text](pics/01_ansible_tower_login.png?raw=true "Login to ansible tower")

Take a tour around in the UI

## Task 2 Create Organization Project inventory and Credential

In the left pane, click Organizations

Click Add to create a new Organization

Type

__Name:__ Default

Leave the rest, click __Save__

![Alt text](pics/01_ansible_tower_org.png?raw=true "Create a project")

In the left pane, click Projects

Click Add to create a new project

Type

__Name:__ Project

__Organization:__ Default

__SCM Type:__ Git

__SCM URL:__ paste your github repo url

__Update Revision on Launch:__ Checked

Leave the rest, click __Save__

![Alt text](pics/02_ansible_tower_create_project.png?raw=true "Create a project")

In the left pane, click Inventory

Click Add to create a new inventory, select Add Inventory

Type

__Name:__ Inventory

__Organization:__ Default

Leave the rest, click __Save__

![Alt text](pics/03_ansible_tower_create_inventory.png?raw=true "Create an inventory")

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

![Alt text](pics/05_ansible_tower_create_credential_filled.png?raw=true "Create credential")

## Task 3 Create Azure RM Template

In VSCode

Create a copy of 01_azure.yml -> 01_azure_tower.yml

Change the variable user: - it should be your initials as we copied your working playbook from previous lab

to __your initials eg. "jesbe"__

Save and Commit

![Alt text](pics/06_ansible_tower_playbook.png?raw=true "Tower playbook")

In Tower go to project and refresh your project, this will do a "git pull"

![Alt text](pics/07_ansible_tower_refresh.png?raw=true "Refresh project")

In the left pane, click Templates

Click on Add to create a new Template select the __Add Job template__ type

Type

__Name:__ Resourcegroup

__Job Type:__ Run

__Inventory:__ Inventory

__Project:__ Project

__Playbook:__ 01_azure_tower.yml

__Credentials:__ Select credential type "Microsoft Azure Resource Manager" and Azure Credentials

Leave the rest as default and click __Save__

![Alt text](pics/08_ansible_tower_template.png?raw=true "Create template")

Click on the "Launch" button and wait a minute to see the result

![Alt text](pics/09_ansible_tower_template_run.png?raw=true "Run template")

## Task 4 Create Azure Webserver template

In VSCode

Create a copy of 02_azure.yml -> 02_azure_tower.yml

Change the variable user: - so it matches the variable in the 01_azure_tower.yml

to __your initials eg. "jesbe"__

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

Click on Add to create a new Template select the __Job template__ type

Type

__Name:__ webserver

__Job Type:__ Run

__Inventory:__ Select your own inventory

__Project:__ Select your own project

__Playbook:__ 02_azure_tower.yml

__Credentials:__ Select credential type "Microsoft Azure Resource Manager" and your own credentials

__In the Extra Vars:__ add the ssh_public_key make sure you have " __before__ and __after__ the key

```bash
---
ssh_public_key: "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCl/myugJcFI/2XmWcLd5P+tKVtbsGf83G/POHH3vc4p3fyLaGKUqaX8YBOLohJ5XFB9t25Tg8wZleCsbDm0s081jx4tdvudRhdqUMbA+n3oHRB3SHD7BLm7d13VgGlM6SCxnkIgrePFaSWsX+J5kk3rhxpo0LEEiGDgTdUDYz3wNypEBsal+eoFp1WHXArnkbl6FkEhOC8iZSJY2KKsJlv6xFXN1NlM/KWkgFdlB+tWps49Cl44IAMHgcjku+Xx+00trgWX89isK54MHWUXHTTPzOykaagLQXcwZZmZvy/84qdDBcRhehSwg7LxHAMjFEYCSpAE78AWoBNpB3lhR0r jesbe@ansible"

```

![Alt text](pics/11_ansible_tower_webserver_template_pubkey.png?raw=true "template")

Leave the rest as default and click __Save__

![Alt text](pics/11_ansible_tower_webserver_template.png?raw=true "template")

In the left pane click on Templates

Locate your webserver template and click on the Rocket to lauch it

![Alt text](pics/12_launch_template.png?raw=true "launch template")

Wait for template to finish

![Alt text](pics/13_launch_template_run.png?raw=true "launch template")

## Task 5 Create Azure Dynamic Inventory Source

In the left pane click on Inventory

Select your inventory

Click on the Sources button on the top

Click Add to create a new source

We can control how the plugin will retrieve resources from azure by adding variables to the Source

__Name:__ Azure

__Source:__ Microsoft Azure Resource Manager

__Credential:__ Azure Credentials

__Overwrite:__ Checked

__Overwrite Variables:__ Checked

__Updata on Launch:__ Checked

In the Source variables add this:

```ansible

---
keyed_groups:
- prefix: tag
  key: tags

```

Leave the rest as default

Click __Save__

![Alt text](pics/14_azure_inventory.png?raw=true "azure inventory")

In the bottom of the screen click on the Sync button

![Alt text](pics/15_azure_inventory_sync.png?raw=true "azure inventory sync")

In the left pane click on Jobs

You should see a Inventory - Azure job running, click on it to monitor the run

Go back to inventory

Select your inventory

Click on the Groups button on the top

You should see a few groups based on the tags that are on the vm's in Azure

![Alt text](pics/15_azure_inventory_result.png?raw=true "azure inventory sync result")

## Task 6 Create Webserver credential

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

Click on Add to create a new credential

__Name:__ webserver

__Organization:__ Default

Credential Type: Machine

__Username:__ __jesbe__ <---- Change to your initials

__SSH Private Key:__ --- the key you copied ---

Leave the rest as default and click __Save__

![Alt text](pics/17_create_ssh_cred.png?raw=true "create cred")

## Task 7 Create Webserver Template

In VSCode

Create a copy of 01_webserver_azure.yml -> 01_webserver_azure_tower.yml

Change the hosts: to match your initials

- hosts: tag_solution_webserver_jesbe

Remove both vars:

websiteheader: "Ansible Playbook"

websiteauthor: "Some Name"

![Alt text](pics/18_webserver_playbook.png?raw=true "playbook")

Save and commit

Go to your project and sync

In the left pane, click Templates

Click on Add to create a new Template select the __Add Job template__ type

Type

__Name:__ Webserver_install

__Job Type:__ Run

__Inventory:__ Select Inventory

__Project:__ Select Project

__Playbook:__ 01_webserver_azure_tower.yml

__Credentials:__ Select credential type "Machine" and Webserver

Leave the rest as default and click __Save__

![Alt text](pics/19_webserver_template_create.png?raw=true "Create template")

## Task 8 Create Workflow template

In the left pane, click Templates

Click on Add to create a new Template select the __Add Workflow template__ type

__Name:__ Workflow

__Organization:__ Default

__Inventory:__ Select Inventory

Leave the rest as default and click __Save__

![Alt text](pics/20_workflow_create.png?raw=true "Create workflow template")

The window changes to the workflow Visualizer

Click on Start

Node Type: __Select:__ Job Template

__Select:__ Resourcegroup

Press the __Save__ Button

![Alt text](pics/21_work_step1.png?raw=true "Create workflow template step 1")

You will now see the first task in the workflow

![Alt text](pics/21_work_step1_workflow.png?raw=true "Create workflow template step 1")

Hoover the mouse over the Resourcegroup box and click on the + icon

![Alt text](pics/21_work_step1_workflow_plus.png?raw=true "Create workflow template step 1")

Select on Success

Click Next

Node Type: __Select:__ Job Template

__Select:__ webserver

Press the __Save__ Button

![Alt text](pics/23_work_step3.png?raw=true "Create workflow template step 3")

You will now see the first and second task in the workflow

![Alt text](pics/23_work_step3_workflow.png?raw=true "Create workflow template step 3")

Hoover the mouse over the Webserver box and click on the + icon

![Alt text](pics/23_work_step3_workflow_plus.png?raw=true "Create workflow template step 3 add new")

Select on Success

Node Type: __Select:__ Inventory Source Sync

__Select:__ Azure

Press the __Save__ Button

![Alt text](pics/24_work_step4.png?raw=true "Create workflow template step 4")

You will now see the first and second task + the inventory sync in the workflow

![Alt text](pics/24_work_step4_workflow.png?raw=true "Create workflow template step 4")

Hoover the mouse over the Azure box and click on the + icon

![Alt text](pics/24_work_step3_workflow_plus.png?raw=true "Create workflow template step 3 add new")

Select on Success

Node Type: __Select:__ Job Template

__Select:__ Webserver_install

Press the __Save__ Button

![Alt text](pics/25_work_step5.png?raw=true "Create workflow template step 4")

Click Save in the top right corner

![Alt text](pics/25_work_step5_workflow.png?raw=true "Create workflow template step 4")

In the top bar click Survey to add the two vars we deleted in the playbook  websiteheader: and websiteauthor:

Click Add

![Alt text](pics/26_work_add_survey.png?raw=true "Create workflow survey")

__Question:__ Web Site Name

__Answer variable name:__ websiteheader

__Answer Type:__ Text

Press the __Save__ Button

![Alt text](pics/25_survey_1.png?raw=true "Create survey 1")

Click Add to add the secondone

__Question:__ Web Site author

__Answer variable name:__ websiteauthor

__Answer Type:__ Text

Press the __Save__ Button

![Alt text](pics/26_survey_2.png?raw=true "Create survey 2")

Click __Preview__

![Alt text](pics/27_survey_preview.png?raw=true "Create survey 2")

Toggle switch to On

![Alt text](pics/28_survey_on.png?raw=true "Create survey 2")

## Task 9 Run Workflow template

In the left pane click Templates, click on the Rocket to Launch the Workflow

![Alt text](pics/27_run_workflow.png?raw=true "Launch workflow")

Fill out the survey, click Next

![Alt text](pics/28_run_workflow_survey.png?raw=true "Launch workflow survey")

Click Launch on the result page

![Alt text](pics/29_run_workflow_survey_result.png?raw=true "Launch workflow survey result")

Wait for the workflow to finish

![Alt text](pics/30_workflow_result.png?raw=true "Launch workflow result")

Go check the new website

Click on the website box, click output in the top and get the ip from the "Details" in webserver Template

![Alt text](pics/31_workflow_result_details_ip.png?raw=true "Get IP")

Open your webbrowser

```bash
http://<your ip>
```

![Alt text](pics/32_result_ip.png?raw=true "Get IP")

Lab done
