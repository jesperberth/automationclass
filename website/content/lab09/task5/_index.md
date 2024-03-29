---
title: Create an ansible dynamic inventory for Azure RM
weight: 50
---

## Task 5 Create an ansible dynamic inventory for Azure RM

We can either add the webserver in the ansible-hosts file or use an Inventory plugin

The Azure Resource Manager inventory plugin is part of ansible and can return a dynamic inventory grouped on tags

[Azure Resource Manager inventory plugin](https://docs.ansible.com/ansible/latest/plugins/inventory/azure_rm.html)

In

![vscode](/images/student-vscode.png)

Create a new file __webserver.azure_rm.yml__

Note: The inventory file must end with __.azure_rm.yml__

```ansible
plugin: azure_rm
auth_source: auto
include_vm_resource_groups:
  - '*'
keyed_groups:
  - prefix: tag
    key: tags

```

![Alt text](images/018_azure_inventory.png?raw=true "vscode create inventory file")

Save and commit to Git

On

![ansible](/images/ansible.png)

Pull the new playbook and run it

__Type:__

```bash

cd ansibleclass

git pull

ansible-inventory -i ./webserver.azure_rm.yml --graph

ansible-inventory -i ./webserver.azure_rm.yml --list

```

![Alt text](images/019_azure_inventory_run.png?raw=true "azure inventory run")

![Alt text](images/020_azure_inventory_run_list.png?raw=true "azure inventory run list")

--list will give a lot more information, --graph will consolidate output in a more viewable way

If we add another server in the Resource Group it will be included in the inventory
