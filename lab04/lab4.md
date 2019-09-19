# Lesson 04: Ansible Cloud

In this session we will use ansible to setup and manage resources in Azure to deploy a virtual machine with a webserver installed and running

## Prepare

We need to start servers, ansible

In Azure Cloud Shell(Bash)

``` bash
cd clouddrive
cd automationclass
cd azure_class_playbooks

ansible-playbook 04_azure_lab4_start.yml

```

## Task 1: Create credentials for Azure

Log on to server "ansible" using ssh

__Type:__

```bash
pip3 install ansible[azure] --user

```

![Alt text](pics/001_install_pip_azure.png?raw=true "install azure")

We need to register an azure application to enable ansible automation

In your browser log on to [https://portal.azure.com](https://portal.azure.com)

In the left pane, click "Azure Active Directory" and "App Registrations"

In the top click "New registration"

![Alt text](pics/002_azure_app_registration.png?raw=true "new azure app")

Type a Name, Call it "ansible-yourname" so its possible to ID it later

Select the:

"Accounts in this organizational directory only (AzureADFS only - Single tenant)"

Should be default

Click Register

![Alt text](pics/003_azure_app_registration_name.png?raw=true "register azure app")

Copy the "Tenant ID" and "Client ID" save them in a text file for now

![Alt text](pics/004_azure_app_tenent_id.png?raw=true "get tenant id client id")

Click "Certificates & Secrets" and "New client secret"

![Alt text](pics/005_azure_app_client_secret.png?raw=true "new secret")

Copy the "Tenant ID" and "Client ID" save them in a text file for now

![Alt text](pics/006_azure_app_client_secret_value.png?raw=true "secret value")

We need to assign rights to the application

In the left pane go to "Subscribtions" and select the one we are working in now

Click "Access Control IAM"

Click "Add" Select "Add role assignment"

Under "Role" select "Contributor"

In the Select box, search for the application name

Select your application and click Save

![Alt text](pics/007_azure_assign_rights.png?raw=true "azure role assignment")

Still in the Subscribtion pane, click the "Overview"

Copy the "Subscribtion ID" to the text file

![Alt text](pics/008_azure_sub_id.png?raw=true "azure sub id")

Log on to server "ansible" using ssh

We will create the authentication file

__Type:__

```bash
mkdir .azure
vi .azure/credentials

```

![Alt text](pics/009_azure_credfile.png?raw=true "azure credentials")

In vi __type:__

Use the vaules you collected from the Azure portal

```bash
i (for input)

[default]
subscription_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
client_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
secret=xxxxxxxxxxxxxxxxx
tenant=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

![Alt text](pics/009_azure_credfile.png?raw=true "azure credentials file")

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](pics/010_azure_credfile_input.png?raw=true "azure credentials file input")

Lets test the connection to azure by creating a small playbook

In VSCode

create a new playbook file 01_azure.yml

add the following text to the file, change the name of the resource group to "webserver_userxx"

```ansible
---
- hosts: localhost
  connection: local
  tasks:
  - name: Create resource group
    azure_rm_resourcegroup:
      name: webserver_userxx
      location: northeurope
    register: rg
  - debug:
      var: rg
```

![Alt text](pics/011_azure_play.png?raw=true "azure play")

Log on to server "ansible" using ssh

Use git to get the new azure playbook

Change url to your own repository

__Type:__

```bash

git clone https://github.com/jesperberth/ansibleclass.git

cd ansibleclass

ansible-playbook 01_azure.yml

```

## Task 2: Create Network in Azure

In VSCode

create a new playbook file 02_azure.yml

add the following text to the file, change the name of any vars with _userxx to your number 

```ansible
---
- hosts: localhost
  connection: local
  vars:
    location: northeurope
    virtual_network_name: webserver_userxx
    subnet: Webserver
    resource_group: webserver_userxx
    domain_sub: domainuserxx

  vars_prompt:
    - name: adminUser
      prompt: "Type the name of your root/administrator account"
      private: no
    - name: adminPassword
      prompt: "Type the password of your root/administrator account"
      private: no

  tasks:
  - name: Create a virtual network
    azure_rm_virtualnetwork:
      resource_group: "{{ resource_group }}"
      name: "{{ virtual_network_name }}"
      address_prefixes_cidr: "10.99.0.0/16"
      tags:
          purpose: production
          delete: not_allowed
  
  - name: Create a subnet
    azure_rm_subnet:
      resource_group: "{{ resource_group }}"
      virtual_network_name: "{{ virtual_network_name }}"
      name: "{{ subnet }}"
      address_prefix_cidr: "10.99.0.0/24"
```
