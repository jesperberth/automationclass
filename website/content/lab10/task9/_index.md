---
title: Create Workflow template
weight: 90
---

## Task 9 Create Workflow template

In the left pane, click __Templates__

Click on __Add__ to create a new Template select the __Add Workflow template__ type

__Name:__ Workflow

__Organization:__ Default

__Inventory:__ Select Inventory

Leave the rest as default and click __Save__

![Alt text](images/20_workflow_create.png?raw=true "Create workflow template")

The window changes to the workflow Visualizer

Click on __Start__

Node Type: __Select:__ Job Template

__Select:__ Resourcegroup

Press the __Save__ Button

![Alt text](images/21_work_step1.png?raw=true "Create workflow template step 1")

You will now see the first task in the workflow

![Alt text](images/21_work_step1_workflow.png?raw=true "Create workflow template step 1")

Hoover the mouse over the Resourcegroup box and click on the __+__ icon

![Alt text](images/21_work_step1_workflow_plus.png?raw=true "Create workflow template step 1")

Select __On Success__

Click __Next__

Node Type: __Select:__ Job Template

__Select:__ webserver

Press the __Save__ Button

![Alt text](images/23_work_step3.png?raw=true "Create workflow template step 3")

You will now see the first and second task in the workflow

![Alt text](images/23_work_step3_workflow.png?raw=true "Create workflow template step 3")

Hoover the mouse over the Webserver box and click on the __+__ icon

![Alt text](images/23_work_step3_workflow_plus.png?raw=true "Create workflow template step 3 add new")

Select __On Success__

Node Type: __Select:__ Inventory Source Sync

__Select:__ Azure

Press the __Save__ Button

![Alt text](images/24_work_step4.png?raw=true "Create workflow template step 4")

You will now see the first and second task + the inventory sync in the workflow

![Alt text](images/24_work_step4_workflow.png?raw=true "Create workflow template step 4")

Hoover the mouse over the Azure box and click on the __+__ icon

![Alt text](images/24_work_step3_workflow_plus.png?raw=true "Create workflow template step 3 add new")

Select __On Success__

Node Type: __Select:__ Job Template

__Select:__ Webserver_install

Press the __Save__ Button

![Alt text](images/25_work_step5.png?raw=true "Create workflow template step 4")

Click __Save__ in the top right corner

![Alt text](images/25_work_step5_workflow.png?raw=true "Create workflow template step 4")

To replace the vars we deleted in the playbook we will use a Survey

In the top bar click __Survey__ to add the two vars we deleted in the playbook __websiteheader:__ and __websiteauthor:__

Click __Add__

![Alt text](images/26_work_add_survey.png?raw=true "Create workflow survey")

__Question:__ Web Site Name

__Answer variable name:__ websiteheader

__Answer Type:__ Text

Press the __Save__ Button

![Alt text](images/25_survey_1.png?raw=true "Create survey 1")

Click __Add__ to add the secondone

__Question:__ Web Site author

__Answer variable name:__ websiteauthor

__Answer Type:__ Text

Press the __Save__ Button

![Alt text](images/26_survey_2.png?raw=true "Create survey 2")

Toggle __Survey Enabled__ switch to On

![Alt text](images/28_survey_on.png?raw=true "Create survey 2")
