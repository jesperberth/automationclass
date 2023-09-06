---
title: Clone Git Repo
weight: 70
---

## Task 7 Clone Git Repository

We need to configure git and clone the repository on the Student/WSL

On

![student-wsl](/images/student-wsl.png)

You must be in the __/home/USER__

```bash

cd

pwd

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

![Alt text](images/02_git_dir.png?raw=true "Git dir")

On

![github](/images/github.png)

On your __ansibleclass__ repository page

Click the green __Code__ button to retrieve the URL for the repository

Copy the __HTTPS__ url

![Alt text](images/010_repourl.png?raw=true "Paste Repo URL")

On

![student-wsl](/images/student-wsl.png)

write __git clone__ and paste the url

```bash

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

In

![vscode](/images/student-vscode.png)

Click __Yes, I trust the authers__ button

![Alt text](images/009_start_code_trust.png?raw=true "Start VSCode trust")

Select your __Theme__

Click __Mark Done__

And Close the __Welcome__ Tab

![Alt text](images/04_theme_vscode.png?raw=true "VSCode Theme")

Now we have our __Ansibleclass__ repo with the __README.md__ file in VSCode

![Alt text](images/05_vscode_ready.png?raw=true "Git repo is now in VSCode")

To push changes back to our GitHub repository we need to authenticate

In the __EXPLORER__ (The Red box is the File Explorer) click once on the README.md file

![Alt text](images/06_vscode_explorer.png?raw=true "EXPLORER in VSCode")

Add the following line to the __README__ (The Red box is the editor) each file you open will be a Tab here in the editor

__Note:__ The White Dot next to the filename __README.md__ this is to indicate that the file isn't saved

```md

Playbooks for ansible basic

```

Click __Ctrl + S__ to save the file

![Alt text](images/06_vscode_readme.png?raw=true "README in VSCode")

All files in the __ansibleclass__ folder are monitored by __git__

Git detects the changes

- In the left menu, the source control 

![Alt text](images/07_vscode_readme.png?raw=true "README in VSCode")