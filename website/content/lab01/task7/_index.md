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

- In the left menu, the source control will reflect number of files with changes
- In the Editor, git will show added lines with green mark on each line, and a red arrow where a line is deleted
- In the bottom, git will show the branch we are on and indicate with a * that there are uncommited changes for this branch

![Alt text](images/07_vscode_readme.png?raw=true "README in VSCode")

Click on the __Source Control__ in the left menu

The left pane now changes to SCM (Git) here we can see files that have changed

![Alt text](images/08_vscode_scm.png?raw=true "VSCode SCM")

If you click the file __README.md__ you will see the original file in the left and the __Working Tree__ file to the right with the differences highlighted

Close the __working tree__ tab

![Alt text](images/09_vscode_working_tree.png?raw=true "VSCode SCM")

The __Message__ box in SCM is for the Commit message

Add the following text: __Add text in readme__

Click __Commit__

![Alt text](images/10_vscode_commit.png?raw=true "VSCode Commit")

The new file is in the __Working Tree__ the file need to be staged in Git before it can be Commited

Click __Always__ now VSCode will automatically add new files to the stageing area

![Alt text](images/11_vscode_stage.png?raw=true "VSCode Commit")

The README.md file has now been __Staged__ and __Commited__ to our local repository to push the changes to GitHub click on __Sync Changes__

On the bottom status line you can see that our local repository has changes that need to be pushed up

Click __Ok, Don't Show Again__

![Alt text](images/12_vscode_sync.png?raw=true "VSCode Sync")

To push changes back to our GitHub repository we need to authenticate the first time

Click __Allow__

![Alt text](images/13_vscode_allow.png?raw=true "VSCode allow")

A browser will open and let you authorize GitHub for VSCode

Click __Authorize Visual-Studio-Code__

![Alt text](images/14_github_auth.png?raw=true "VSCode allow")

Type your __Password__ and click __Confirm__

![Alt text](images/15_github_auth_password.png?raw=true "VSCode allow")

Click __Open__

![Alt text](images/16_github_auth_password.png?raw=true "VSCode allow")

You are now Authorized and the changes are synced

![Alt text](images/18_vscode_github_done.png?raw=true "VSCode allow")

Go to your github repository and check that the change has been synced

![Alt text](images/19_github_repo.png?raw=true "github repo")
