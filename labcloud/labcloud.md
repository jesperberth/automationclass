# Lesson xx: Ansible Cloud

In this session we will use ansible to setup and manage virtual machines and other resources in Azure 

## Prepare

We need to start servers, ansible

In Azure Cloud Shell(Bash)

``` bash
cd clouddrive
cd automationclass
cd azure_class_playbooks

ansible-playbook 0xx_azure_lessonxx_start.yml

```

## Task 1: Create credentials for Azure

Log on to server "ansible" using ssh

__Type:__

```bash
pip3 install ansible[azure] --user

```

![Alt text](pics/001_install_pip_azure.png?raw=true "install azure")

We need to register an azure application to enable ansible automation

In your browser log on to https://portal.azure.com

In the left pane, click "Azure Active Directory" and "App Registrations"

In the top click "New registration" 

![Alt text](pics/002_azure_app_registration.png?raw=true "new azure app")

Type a Name, Call it "ansible-yourname" so its possible to ID it later

Select the 

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

