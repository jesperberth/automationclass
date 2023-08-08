---
title: Install Software
weight: 40
---

## Task 4 Install Software

In

![student-pwsh](/images/student-pwsh.png)

Set the timezone to match your current timezone

```bash

tzutil /s "Romance Standard Time"

```

![Alt text](images/001_set_timezone.png?raw=true "set timezone")

You need to install the following software

```bash

winget install microsoft.powershell

winget install git.git

winget install Microsoft.VisualStudioCode

winget install Microsoft.AzureCLI

```

Click "Y" to accept the source aggreement

![Alt text](images/001_winget_accept.png?raw=true "winget accept")

![Alt text](images/001_install_powershell.png?raw=true "powershell")

![Alt text](images/002_install_git.png?raw=true "git")

![Alt text](images/003_install_vscode.png?raw=true "vscode")

![Alt text](images/004_install_azcli.png?raw=true "az cli")

If you need to install other software you can search for it with __winget search__

Eg.

```bash

winget search firefox

```

![Alt text](images/005_winget_search.png?raw=true "search")

Close __Windows Terminal__
