# Lesson 2: Playbooks

In this session we will install and use Visual Studio Code with a few plugins to start working with ansible playbooks and create two playbooks, one for linux and one for windows

## Prepare

We need to start servers, ansible, server1 and server3

In Azure Cloud Shell(Bash)

``` bash
cd clouddrive
cd automationclass
cd setup_class
cd azure_class_playbooks

ansible-playbook 03_azure_lesson2_start.yml

```

## Task 1: Setup Visual Studio Code and GIT

Download and install VSCode [Download vscode](https://code.visualstudio.com/download)

![Alt text](pics/001_download_vscode.png?raw=true "Download VSCode")

Start VSCode

![Alt text](pics/002_vscode_start.png?raw=true "Start VSCode")

In VSCode

Get extention "Ansible" from Microsoft

![Alt text](pics/003_vscode_install_ansible.png?raw=true "Install extention in VSCode")

Download and install GIT [Download Git](https://git-scm.com/downloads)

![Alt text](pics/004_download_git.png?raw=true "Download GIT")

Open a browser and go to [Git Hub](https://github.com)

If you have a github account login, otherwise create a new account

![Alt text](pics/005_create_github.png?raw=true "Create GitHub Account")

Lets create a new Repository, click the green "New" in the top left corner

![Alt text](pics/006_login_github.png?raw=true "Login GitHub")

Give you repository a name "ansibleclass"

Make Sure you tick __"Initialize this repository with a README"__

Click "Create repository"

![Alt text](pics/007_newrepo_github.png?raw=true "Create Repo")

Your new repository is created with an empty README.md file

![Alt text](pics/008_newrepo_created_github.png?raw=true "New Repo")

## Task 2: Create first playbook using VSCode

We need to create a simple folder structure for keeping our files

Open a Powershell Terminal

__Type:__

```powershell
mkdir ansible
cd ansible
code .
```

![Alt text](pics/009_start_code.png?raw=true "Start VSCode")

On your "ansbleclass" repository page

Click the "Clone or Download" to retrieve the URL for the repository

![Alt text](pics/010_repourl.png?raw=true "Repo URL")

In VSCode

Click (Windows: Ctrl + Shift + P) (Mac: Command + Shift + P)
This will open the VSCode command Palette

![Alt text](pics/011_git_clone.png?raw=true "VSCode Command")

Paste the git url

![Alt text](pics/012_git_clone_url.png?raw=true "Paste Repo URL")

Specify a path for the git repository on your disk (Don't use a One Drive)

![Alt text](pics/013_git_clone_path.png?raw=true "Set Git local path")

Click "Yes" to Open the repository

![Alt text](pics/014_git_in_vscode.png?raw=true "Git repo is now in VSCode")
