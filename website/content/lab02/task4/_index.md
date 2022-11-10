---
title: Clone Git Repo
weight: 40
---

## Task 4 Clone Git Repository

We need to configure git with a Name and email to track the changes you are making

Open Powershell on your desktop

```bash
git config --global user.name "Full Name"
git config --global user.email "email@address.com"
git config --list
```

![Alt text](images/009_git_config.png?raw=true "Git Config")

We need to create a simple folder structure for keeping our files

Open a Powershell Terminal

**Type:**

```powershell
mkdir ansible
cd ansible
code .
```

![Alt text](images/009_start_code.png?raw=true "Start VSCode")

Click "Yes, I trust the authers" button

![Alt text](images/009_start_code_trust.png?raw=true "Start VSCode trust")

On your "ansibleclass" repository page

Click the green "Code" button to retrieve the URL for the repository

![Alt text](images/010_repourl.png?raw=true "Repo URL")

In VSCode

Click (Windows: Ctrl + Shift + P) (Mac: Command + Shift + P)
This will open the VSCode command Palette

Write "Git Clone"

![Alt text](images/011_git_clone.png?raw=true "VSCode Command")

Paste the git url

![Alt text](images/012_git_clone_url.png?raw=true "Paste Repo URL")

Specify a path for the git repository on your disk (Don't use a One Drive)

![Alt text](images/013_git_clone_path.png?raw=true "Set Git local path")

Click "Yes" to Open the repository

![Alt text](images/014_git_in_vscode.png?raw=true "Git repo is now in VSCode")
