---
title: Deploy Lab
weight: 10
---

## Task 1 Deploy Lab

Login to Azure

![azure](/images/azure.png)

In your browser go to [http://portal.azure.com](http://portal.azure.com)

Your username will be __userX__ as below

```bash

userX@redhatbyarrow.onmicrosoft.com

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

Lab is now deployed

Close the Cloudshell
