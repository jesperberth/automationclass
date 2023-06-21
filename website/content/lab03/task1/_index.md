---
title: Clone Git Repo
weight: 10
---

## Task 1 Clone Git Repository

We will run Visual Studio Code from WSL to get the most out of the Ansible plugin

We need to configure git with a Name and email to track the changes you are making

__Note:__ This has to be done on your Student machine

Open Terminal / WSL (Ubuntu)

```bash

git config --global user.name "Full Name"

git config --global user.email "email@address.com"

git config --list

```

![Alt text](images/009_git_config.png?raw=true "Git Config")

We need to create a folder for our local git repositories

__Type:__

```bash
mkdir git

cd git

```

On your "ansibleclass" repository page

Click the green "Code" button to retrieve the URL for the repository

Copy the url

![Alt text](images/010_repourl.png?raw=true "Paste Repo URL")

In Terminal

write __git clone__ and paste the url

```powershell

git clone https://github.com/jesperberth/ansibleclass.git

```

![Alt text](images/009_git_clone.png?raw=true "git clone")

Open the new git project folder __ansibleclass__

start Visual Studio Code

```powershell

cd ansibleclass

code .

```

![Alt text](images/009_start_code.png?raw=true "Start VSCode")

Click "Yes, I trust the authers" button

![Alt text](images/009_start_code_trust.png?raw=true "Start VSCode trust")

![Alt text](images/014_git_in_vscode.png?raw=true "Git repo is now in VSCode")
