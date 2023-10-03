---
title: Create credentials for Azure
weight: 20
---

## Task 2 Create credentials for Azure

We need to register an azure application to enable ansible automation

In your browser log on to [https://portal.azure.com](https://portal.azure.com)

On

![azure](/images/azure.png)

In the top bar, click the __cloudshell__ icon marked with red

![Alt text](images/01_start_cloud_shell.png?raw=true "Cloud Shell")

Select __Bash__

![Alt text](images/02_start_cloud_shell_bash.png?raw=true "Cloud Shell")

Run the following command to create a new Service User

Set the user variable to your initials

```bash

USER=jesbe

SubID=$(az account list --query "[].{id:id}" -o tsv)

az ad sp create-for-rbac --name ansible-$USER --role Contributor --scopes /subscriptions/$SubID

```

Copy the JSON output to a notepad file we will need the information later

![Alt text](images/02_create_sp.png?raw=true "Cloud Shell output")

We need to get the Subscription ID run the following in the Cloud Shell

```bash

echo $SubID

```

![Alt text](images/03_get_sub_id.png?raw=true "Cloud Shell sub id")

Copy the line id: "xxx-xxx" to the same notepad

On

![ansible](/images/ansible.png)

We will create the authentication file, you must start in your home dir

__Type:__

```bash
cd
mkdir .azure
vi .azure/credentials

```

![Alt text](images/009_azure_credfile.png?raw=true "azure credentials")

In vi __type:__

Use the vaules you collected from the Azure portal

```bash
i (to toggle input)
```

```bash
[default]
subscription_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
client_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
secret=xxxxxxxxxxxxxxxxx
tenant=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

```bash

In the file

subscription_id = id from the last command

client_id = appID in the first command

secret = Password in the first command

tenant = tenant in the first command

```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](images/010_azure_credfile_input.png?raw=true "azure credentials file input")

Lets test the connection to azure by creating a small playbook

[Ansible Module azure_rm_resourcegroup](https://docs.ansible.com/ansible/latest/modules/azure_rm_resourcegroup_module.html#azure-rm-resourcegroup-module)

In

![vscode](/images/student-vscode.png)

Create a new playbook file __01_azure.yml__

add the following text to the file, change the name of the variable __user to your initials__ use the same as you use to login to ansible server

```ansible
---
- name: Azure Create RG
  hosts: localhost
  connection: local
  vars:
    user: write your username here
  tasks:
    - name: Create resource group
      azure.azcollection.azure_rm_resourcegroup:
        name: "webserver_{{ user }}"
        location: northeurope
        tags:
            solution: "webserver_{{ user }}"
            delete: ansibletraining
      register: rg
    - name: Show RG
      ansible.builtin.debug:
        var: rg

```

![Alt text](images/011_azure_play.png?raw=true "azure play")

On

![ansible](/images/ansible.png)

Pull the new playbook and run it

__Type:__

```bash

cd ansibleclass

git pull

ansible-playbook 01_azure.yml

```

![Alt text](images/011_azure_play_run.png?raw=true "azure play run")
