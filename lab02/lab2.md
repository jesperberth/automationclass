# Lab 2: Ansible Playbooks

In this session we will install and use Visual Studio Code with a few plugins to start working with ansible playbooks and create two playbooks, one for linux and one for windows

## Prepare

We will need the servers, ansible, server1 and server2 to be up and running - by default they are started after creation

## Task 1: Setup Visual Studio Code and GIT

Download and install VSCode [Download vscode](https://code.visualstudio.com/download)

![Alt text](pics/001_download_vscode.png?raw=true "Download VSCode")

Start VSCode

![Alt text](pics/002_vscode_start.png?raw=true "Start VSCode")

In VSCode

Get extention "indent one space" from Alexander

Get extention "Trailing Spaces" from Shardul Mahadik

![Alt text](pics/003_vscode_install_ansible.png?raw=true "Install extention in VSCode")

Download and install GIT [Download Git](https://git-scm.com/downloads)

![Alt text](pics/004_download_git.png?raw=true "Download GIT")

Open a browser and go to [Git Hub](https://github.com)

If you have a github account login, otherwise create a new account

![Alt text](pics/005_create_github.png?raw=true "Create GitHub Account")

Lets create a new Repository, click the green "New" in the top right corner

![Alt text](pics/006_login_github.png?raw=true "Login GitHub")

Give you repository a name "ansibleclass"

Select "Public" - it's default - __for the purpose of these labs keep it public__

Make Sure you tick __"Initialize this repository with a README"__

Click "Create repository"

![Alt text](pics/007_newrepo_github.png?raw=true "Create Repo")

Your new repository is created with an empty README.md file

![Alt text](pics/008_newrepo_created_github.png?raw=true "New Repo")

## Task 2: Clone Git Repository

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

__Type:__

```powershell
mkdir ansible
cd ansible
code .
```

![Alt text](pics/009_start_code.png?raw=true "Start VSCode")

On your "ansibleclass" repository page

Click the "Clone or Download" to retrieve the URL for the repository

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

## Task 3: Create the first playbook

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

Notice that there are three changes waiting

* .gitignore
* 01_linux.yml
* settings.yml

We need to commit the changes before .gitignore will ignore settings.yml

![Alt text](pics/016_code_playbook.png?raw=true "playbook in VSCode")

Write a comment __"First Playbook__" and click "Ctrl + Enter" to commit the changes

Now Sync the changes Push/Pull, in the blue bar at the bottom, 0 up, 1 down it will start the sync process

![Alt text](pics/018_code_git_sync.png?raw=true "git sync in VSCode")

The first time you will be prompted for github credentials

![Alt text](pics/019_code_git_sync_login.png?raw=true "git login in VSCode")

Open the Git Hub repository, the 01_linux.yml is now added, note the comment next to the filename

![Alt text](pics/020_github_new.png?raw=true "github new file")

Log on to server "ansible" using ssh

We need to install git

__Type:__

```bash
sudo dnf install git -y
```

![Alt text](pics/021_install_git.png?raw=true "install git")

Lets test the playbook

Clone the git repository

__Note:__

Change to your repository

__Type:__

```bash
git clone https://github.com/jesperberth/ansibleclass.git
```

![Alt text](pics/022_git_clone.png?raw=true "git clone")

Run the playbook

__Type:__

```bash
cd ansibleclass

ls

ansible-playbook 01_linux.yml --ask-become-pass

```

![Alt text](pics/023_run_playbook.png?raw=true "Run playbook")

## Task 4: Adding tasks to the playbook

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

__Type:__

```bash
git pull
```

![Alt text](pics/026_git_pull.png?raw=true "git pull")

Run the playbook

__Type:__

```bash
ls

ansible-playbook 01_linux.yml --ask-become-pass
```

![Alt text](pics/027_run_playbook_secondtask.png?raw=true "Run playbook")

Run the playbook again, the second task will become green as the line is already there, this is the idempotency

The "Create File" task will be changed every time as we use the touch command on the file

__Type:__

```bash
ansible-playbook 01_linux.yml --ask-become-pass
```

![Alt text](pics/028_run_playbook_secondtask_idempodent.png?raw=true "Run playbook")

## Task 5: Add server two and run the playbook

We will add server 2 to the inventory

__Type:__

```bash
cd

vi ansible-hosts

```

![Alt text](pics/029_edit_hosts.png?raw=true "Edit hosts")

In vi __type:__

```bash
i (for input)

[linuxservers]
server1
server2
```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

__Type:__

```bash
cd ansibleclass

ansible-playbook 01_linux.yml --ask-become-pass
```

![Alt text](pics/030_2_server_play.png?raw=true "Run playbook")

If server2 fails, did you copy your ssh key? "ssh-copy-id user@server2" and run the playbook again

## Task 6: Ansible-vault

[Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html)

In this lab we will work with ansible-vault to encrypt sensitive data as passwords

First we need to remove the password for the windows servers in the ansible-hosts file

```bash
cd

vi ansible-hosts

```

In vi go to the line ansible_password=SomeThingSimple8

__type:__

in vi dd will remove the line

```bash
dd

[windowsservers:vars]
ansible_user=jesbe
ansible_password=SomeThingSimple8   <--------- Make sure the marker is at this line
ansible_port=5985
ansible_connection=winrm
ansible_winrm_transport=ntlm
ansible_winrm_message_encryption=always
```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](pics/031_remove_password.png?raw=true "remove password")

Next lets create an encryptet var file for ansible

__Type:__

```bash
cd

ansible-vault create secret.yml

```

You will be promptet for a password and to confirm the password

![Alt text](pics/032_create_vault.png?raw=true "create vault")

ansible-vault will open your default editor - in our case its vi

In vi __type:__

```bash
i (for input)

---

windows_password: SomeThingSimple8   <------ Type your Windows password here

```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](pics/033_create_vault_save.png?raw=true "edit vault")

Try to cat the file

__Type:__

```bash

cat secret.yml

```

![Alt text](pics/034_cat_vault.png?raw=true "cat vault")

To change the content of an encryptet file use ansible-vault edit filename

You will need to type your password again ..

__Type:__

```bash

ansible-vault edit secret.yml

```

![Alt text](pics/034_edit_vault.png?raw=true "edit vault")

Lets create a playbook to use the encryptet var file

In VSCode

Create a new file 01_vault.yml

__Type:__

```ansible
---
- hosts: windowsservers
  collections:
   - ansible.windows
  vars_files:
    - ~/secret.yml
  vars:
    ansible_password: "{{ windows_password }}"
  tasks:
  - name: Install IIS (Web-Server only)
    win_feature:
      name: Web-Server
      state: present
```

Save the file

Notice that Git detects the changed file, do a commit add a comment "Vault" and Sync to Git

![Alt text](pics/035_vault_playbook.png?raw=true "vault playbook")

On server ansible do a git pull and run the playbook

```bash

cd ansibleclass

git pull

ansible-playbook 01_vault.yml --ask-vault-pass

```

![Alt text](pics/036_vault_playbook_run.png?raw=true "vault playbook run")

## Task 7: Ansible Inventory yaml

Another option for the inventory is using a yaml file instead of the ini format, the yaml file will give us some other options for the vault

Lets create a new ansible-hosts.yml

Copy the following inventory to ansible-hosts.yml

__Note:__

We need to set an option in vi before pasteing the configuration



```ansible

linuxservers:
        hosts:
                server1:
                server2:
windowsservers:
        hosts:
                server3:
                server4:
        vars:
                ansible_user: jesbe
                ansible_port: 5985
                ansible_connection: winrm
                ansible_winrm_transport: ntlm
                ansible_winrm_message_encryption: always

```

__Type:__

```bash

cd

vi ansible-hosts.yml

Hit Esc-key

:set paste <Hit Enter>

Hit Esc-key

i (to toggle insert)
```

![Alt text](pics/037_set_paste.png?raw=true "vi paste")

Note that it now writes -- INSERT (paste) -- in the bottom

You can do a copy/paste of the inventory

![Alt text](pics/037_yaml_inventory.png?raw=true "yaml inventory")

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

Lets change ansible.cfg to use the new inventory, you just need to add the .yml to the inventory line

```bash

cd

vi .ansible.cfg

i (for input)

inventory = /home/jesbe/ansible-hosts.yml

```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](pics/038_ansible_cfg.png?raw=true "config")

Do a ping test to check if we are using the new inventory

```bash

ansible linuxservers -m ping

```

![Alt text](pics/039_ansible_yaml_test.png?raw=true "test yaml inventory")

## Task 8: Ansible Vault - Yaml inventory

In this task we will encrypt the password for the windows servers and place it in the new yaml inventory file

Encrypt you password

__Type:__

```bash

ansible-vault encrypt_string 'SomeThingSimple8' --name ansible_password

```

![Alt text](pics/040_ansible_vault_string.png?raw=true "Encrypt string")

Copy the string

![Alt text](pics/041_ansible_vault_string_copy.png?raw=true "Encrypt string copy")

Paste the encryptet string into ansible-hosts.yml

When copied you might need to indent the lines with spaces so it placed under the first S in password, se the picture

```bash

cd

vi ansible-hosts.yml

Hit Esc-key

:set paste <Hit Enter>

Hit Esc-key

i (to toggle insert)

```

Save the inventory file

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](pics/042_inventory_encrypt.png?raw=true "inventory encryptet string")

Lets do a test with win_ping

```bash

ansible windowsservers -m win_ping --ask-vault-pass

```

![Alt text](pics/043_win_ping.png?raw=true "win ping")

Lab done

[Work with Playbooks](../lab03/lab3.md)
