---
title: Install Software
weight: 30
---

## Task 3 Install Software

In

![student-pwsh](/images/student-pwsh.png)

Start the terminal with __elevated rights__

Set the timezone to match your current timezone

```bash
tzutil /s "Romance Standard Time"

```

![Alt text](images/001_set_timezone.png?raw=true "set timezone")

You need to install the following software

- Git
- VSCode

We will use Chocolatey to install the software

To install chocolatay Run the following command

```bash
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

```

Close and start the Terminal with elevated rights

```bash
choco install git -y

choco install vscode -y

```

![Alt text](images/001_winget_install.png?raw=true "winget accept")
