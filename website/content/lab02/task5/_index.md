---
title: Create the first playbook
weight: 50
---

## Task 5 Create the first playbook

In the file explorer part of VSCode rigth click on the pane below the "ANSIBLECLASS"

![Alt text](images/015_code_newfile.png?raw=true "new file in VSCode")

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

![Alt text](images/016_code_playbook.png?raw=true "playbook in VSCode")

Write a comment **"First Playbook**" and click "Ctrl + Enter" to commit the changes

Now Sync the changes Push/Pull, in the blue bar at the bottom, 0 up, 1 down it will start the sync process

![Alt text](images/018_code_git_sync.png?raw=true "git sync in VSCode")

The first time you will be prompted for github credentials

![Alt text](images/019_code_git_sync_login.png?raw=true "git login in VSCode")

Open the Git Hub repository, the 01_linux.yml is now added, note the comment next to the filename

![Alt text](images/020_github_new.png?raw=true "github new file")

Log on to server "ansible" using ssh

We need to install git

**Type:**

```bash
sudo dnf install git -y
```

![Alt text](images/021_install_git.png?raw=true "install git")

Lets test the playbook

Clone the git repository

**Note:**

Change to your repository

**Type:**

```bash
git clone https://github.com/jesperberth/ansibleclass.git
```

![Alt text](images/022_git_clone.png?raw=true "git clone")

Run the playbook

**Type:**

```bash
cd ansibleclass

ls

ansible-playbook 01_linux.yml --ask-become-pass

```

![Alt text](images/023_run_playbook.png?raw=true "Run playbook")
