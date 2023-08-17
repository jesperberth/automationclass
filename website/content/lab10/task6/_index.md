---
title: Create Azure Dynamic Inventory Source
weight: 60
---

## Task 6 Create Azure Dynamic Inventory Source

In the left pane click on __Inventory__

Select your __inventory__

Click on the __Sources__ button on the top

Click __Add__ to create a new source

We can control how the plugin will retrieve resources from azure by adding variables to the Source

__Name:__ Azure

__Source:__ Microsoft Azure Resource Manager

__Credential:__ Azure Credentials

__Overwrite:__ Checked

__Overwrite Variables:__ Checked

__Update on Launch:__ Checked

In the Source variables add this:

```ansible
---
keyed_groups:
- prefix: tag
  key: tags

```

Leave the rest as default

Click __Save__

![Alt text](images/14_azure_inventory.png?raw=true "azure inventory")

In the bottom of the screen click on the __Sync__ button

![Alt text](images/15_azure_inventory_sync.png?raw=true "azure inventory sync")

In the left pane click on __inventory__

Select your __inventory__

Click on the __Groups__ button on the top

You should see a few groups based on the tags that are on the vm's in Azure

![Alt text](images/15_azure_inventory_result.png?raw=true "azure inventory sync result")
