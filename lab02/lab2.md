# Lab 2: Ansible Playbooks

In this session we will install and use Visual Studio Code with a few plugins to start working with ansible playbooks and create two playbooks, one for linux and one for windows

## Table of Contents

- [Prepare](#prepare)
- [Task 1 Setup Visual Studio Code and GIT](#task-1-setup-visual-studio-code-and-git)
- [Task 2 Clone Git Repository](#task-2-clone-git-repository)
- [Task 3 Create the first playbook](#task-3-create-the-first-playbook)
- [Task 4 Adding tasks to the playbook](#task-4-adding-tasks-to-the-playbook)
- [Task 5 Add server two and run the playbook](#task-5-add-server-two-and-run-the-playbook)

## Prepare

We will need the servers, ansible, server1 and server2 to be up and running - by default they are started after creation

## Task 1 Setup Visual Studio Code and GIT

Download and install VSCode [Download vscode](https://code.visualstudio.com/download)

![Alt text](pics/001_download_vscode.png?raw=true "Download VSCode")

Start VSCode

![Alt text](pics/002_vscode_start.png?raw=true "Start VSCode")

In VSCode

Get extention "indent one space" from Alexander

Get extention "Trailing Spaces" from Shardul Mahadik

Get extention "Indent-rainbow" from oderwat

![Alt text](pics/003_vscode_install_ansible.png?raw=true "Install extention in VSCode")

Download and install GIT [Download Git](https://git-scm.com/downloads)

![Alt text](pics/004_download_git.png?raw=true "Download GIT")

Open a browser and go to [Git Hub](https://github.com)

If you have a github account login, otherwise create a new account

![Alt text](pics/005_create_github.png?raw=true "Create GitHub Account")

Login to your github account

Click on Repositories

Click the green "New" in the top right corner

![Alt text](pics/006_login_github.png?raw=true "Login GitHub")

Give you repository a name "ansibleclass"

Select "Public" - it's default - **for the purpose of these labs keep it public**

Make Sure you tick **"Initialize this repository with a README"**

Click "Create repository"

![Alt text](pics/007_newrepo_github.png?raw=true "Create Repo")

Your new repository is created with an empty README.md file

![Alt text](pics/008_newrepo_created_github.png?raw=true "New Repo")

## Task 2 Clone Git Repository

We need to configure git with a Name and email to track the changes you are making

Open Powershell on your desktop

```bash
git config --global user.name "Full Name"
git config --global user.email "email@address.com"
git config --list
```

![Alt text](pics/009_git_config.png?raw=true "Git Config")

We need to create a simple folder structure for keeping our files

Open a Powershell Terminal

**Type:**

```powershell
mkdir ansible
cd ansible
code .
```

![Alt text](pics/009_start_code.png?raw=true "Start VSCode")

Click "Yes, I trust the authers" button

![Alt text](pics/009_start_code_trust.png?raw=true "Start VSCode trust")

On your "ansibleclass" repository page

Click the green "Code" button to retrieve the URL for the repository

![Alt text](pics/010_repourl.png?raw=true "Repo URL")

In VSCode

Click (Windows: Ctrl + Shift + P) (Mac: Command + Shift + P)
This will open the VSCode command Palette

Write "Git Clone"

![Alt text](pics/011_git_clone.png?raw=true "VSCode Command")

Paste the git url

![Alt text](pics/012_git_clone_url.png?raw=true "Paste Repo URL")

Specify a path for the git repository on your disk (Don't use a One Drive)

![Alt text](pics/013_git_clone_path.png?raw=true "Set Git local path")

Click "Yes" to Open the repository

![Alt text](pics/014_git_in_vscode.png?raw=true "Git repo is now in VSCode")

## Task 3 Create the first playbook

In the file explorer part of VSCode rigth click on the pane below the "ANSIBLECLASS"

![Alt text](pics/015_code_newfile.png?raw=true "new file in VSCode")

Name it "01_linux.yml"

Write the following in the text pane

```ansible
---
- hosts: linuxservers
  become: yes

  tasks:
  - name: Create file
    file:
      path: /root/testfile.txt
      state: touch
```

Save the file (Ctrl + S)

Click the Source control button in the left panel.

![Alt text](pics/016_code_playbook.png?raw=true "playbook in VSCode")

Write a comment **"First Playbook**" and click "Ctrl + Enter" to commit the changes

Now Sync the changes Push/Pull, in the blue bar at the bottom, 0 up, 1 down it will start the sync process

![Alt text](pics/018_code_git_sync.png?raw=true "git sync in VSCode")

The first time you will be prompted for github credentials

![Alt text](pics/019_code_git_sync_login.png?raw=true "git login in VSCode")

Open the Git Hub repository, the 01_linux.yml is now added, note the comment next to the filename

![Alt text](pics/020_github_new.png?raw=true "github new file")

Log on to server "ansible" using ssh

We need to install git

**Type:**

```bash
sudo dnf install git -y
```

![Alt text](pics/021_install_git.png?raw=true "install git")

Lets test the playbook

Clone the git repository

**Note:**

Change to your repository

**Type:**

```bash
git clone https://github.com/jesperberth/ansibleclass.git
```

![Alt text](pics/022_git_clone.png?raw=true "git clone")

Run the playbook

**Type:**

```bash
cd ansibleclass

ls

ansible-playbook 01_linux.yml --ask-become-pass

```

![Alt text](pics/023_run_playbook.png?raw=true "Run playbook")

## Task 4 Adding tasks to the playbook

Lets add a second task in the playbook 01_linux.yml

In VSCode add the following text to the file

```ansible

  - name: Add line in file
    lineinfile:
      path: /root/testfile.txt
      line: Ansible was here...

```

![Alt text](pics/024_secondtask_code.png?raw=true "Add second task to playbook")

Save the file

Notice that Git detects the changed file, do a commit add a comment "Second Edition" and Sync to Git

![Alt text](pics/025_secondtask_commit.png?raw=true "Second Commit to playbook")

On ansible

Pull the updated git repository

**Type:**

```bash
git pull
```

![Alt text](pics/026_git_pull.png?raw=true "git pull")

Run the playbook

**Type:**

```bash
ls

ansible-playbook 01_linux.yml --ask-become-pass
```

![Alt text](pics/027_run_playbook_secondtask.png?raw=true "Run playbook")

Run the playbook again, the second task will become green as the line is already there, this is the idempotency

The "Create File" task will be changed every time as we use the touch command on the file

**Type:**

```bash
ansible-playbook 01_linux.yml --ask-become-pass
```

![Alt text](pics/028_run_playbook_secondtask_idempodent.png?raw=true "Run playbook")

## Task 5 Add server two and run the playbook

We will add server 2 to the inventory

**Type:**

```bash
cd

vi ansible-hosts

```

![Alt text](pics/029_edit_hosts.png?raw=true "Edit hosts")

In vi **type:**

```bash
i (for input)

[linuxservers]
server1
server2
```

**Type:**

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

**Type:**

```bash
cd ansibleclass

ansible-playbook 01_linux.yml --ask-become-pass
```

![Alt text](pics/030_2_server_play_error.png?raw=true "Run playbook error")

If server2 fails, did you copy your ssh key? "ssh-copy-id user@server2" and run the playbook again

![Alt text](pics/030_2_server_play.png?raw=true "Run playbook")

The playbook now runs against both servers

Lab done

[Ansible Vault](../lab03/lab3.md)
