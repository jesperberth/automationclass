---
title: Deploy Lab
weight: 10
---

## Task 1 Deploy Lab

Login to Azure

![azure](/images/azure.png)

In your browser go to [http://portal.azure.com](http://portal.azure.com)

Your username will be __userxx__ as below

```bash

userxx@redhatbyarrow.onmicrosoft.com

```

__Note:__ Run the browser in Incognito/Private mode to avoid issues with cashed credentials

![Alt text](images/01_azure_login.png?raw=true "Azure login")

In the top bar, click the "cloudshell" icon marked with red

![Alt text](images/05_start_cloud_shell.png?raw=true "Cloud Shell")

Select Bash

![Alt text](images/05_start_cloud_shell_bash.png?raw=true "Cloud Shell Bash")

Select "Show advanced settings"

![Alt text](images/06_start_cloud_shell_advanced.png?raw=true "Cloud Shell bash")

Set Cloud Shell region to __"North Europe"__

Resource group: Select Use existing and set it to your Resource group __userX-ansible__

Storage account: Select Use existing your storage account will be selected, as you only have one

File Share: Select existing __userXansible__

![Alt text](images/07_start_cloud_shell_advanced_set.png?raw=true "Cloud Shell advanced")

Cloud shell is now ready

![Alt text](images/09_start_cloud_shell_ready.png?raw=true "Cloud Shell storage")

In Azure Cloud Shell(Bash)

We will download the deployment script and execute it

```bash

curl -o deploy_lab.sh https://raw.githubusercontent.com/jesperberth/automationclass_setup/main/azure/deploy_lab.sh

chmod +x deploy_lab.sh

./deploy_lab.sh

```

![Alt text](images/10_run_deploy_lab.png?raw=true "Run deploy_lab.sh")

__Note:__

Username __cannot__ be any of the names below:

|  |  |  |  |  |  |  |
|---|---|---|---|---|---|---|
| 1 | 123 | a | actuser | adm | admin | admin1 |
| admin2 | administrator | aspnet | backup | console | david | guest |
| john | owner | root | server | sql | support_388945a0 | support |
| sys | test | test1 | test2 | test3 | user | user1 |
| user2 |

__Use your initials as username__ eg. jesbe

Password must be complex

Be between 12 and 123 characters

- Have lower characters
- Have upper characters
- Have a digit
- Have a special character (Regex match [\W_])

__DON'T__ Start with a special character as it will give us troubles later on in the lab

Special charactor is one of these:

```bash

#$%^&*_-+=`|\(){}[]:;"'<>,.?/~!@

```

Following is __NOT__ allow as password
|  |  |  |  |  |
|---|---|---|---|---|
| abc@123 |	iloveyou! |	P@$$w0rd | P@ssw0rd | P@ssword123 |
| Pa$$word | pass@word1 | Password!	| Password1 | Password22 |

__Note:__

Password will be visible on the screen

The playbook will create all resources needed for the Automation class - Lab 01 -> Lab 05

![Alt text](images/11_enter_user_password.png?raw=true "Enter Username and password")

![Alt text](images/11_lab_ready.png?raw=true "Labs are ready")

Lab is now deployed

Close the Cloudshell
