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

- Git
- VSCode

Run the following command

```bash

winget install git.git Microsoft.VisualStudioCode --accept-source-agreements

```

![Alt text](images/001_winget_install.png?raw=true "winget accept")

### Optional - Use winget search

If you need to install other software you can search for it with __winget search__

Eg.

```bash

winget search firefox

```

![Alt text](images/005_winget_search.png?raw=true "search")

Close __Windows Terminal__
