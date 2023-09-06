---
title: Install Software
weight: 30
---

## Task 3 Install Software

In

![student-pwsh](/images/student-pwsh.png)

Set the timezone to match your current timezone

```bash

tzutil /s "Romance Standard Time"

```

![Alt text](images/001_set_timezone.png?raw=true "set timezone")

You need to install the following software

We will use Windows 11's builtin package management system __winget__

Winget is installed as default on Windows 11 22H2

- Git
- VSCode

Run the following command

```bash

winget install git.git Microsoft.VisualStudioCode --accept-source-agreements

```

![Alt text](images/001_winget_install.png?raw=true "winget accept")
