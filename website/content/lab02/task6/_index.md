---
title: Clone Git Repo
weight: 60
---

Lets install git and clone our GitHub repository to the ansible host

On

![ansible](/images/ansible.png)

Install git

__Type:__

```bash
sudo dnf install git -y
```

![Alt text](images/021_install_git.png?raw=true "install git")

We need to do some config to git, as we need to do some of the work on our linux host

And copy our public ssh key to our github account

On

![ansible](/images/ansible.png)

__Type:__

```bash
cd

git config --global user.email "you@example.com"

git config --global user.name "Your Name"

cat ~/.ssh/id_rsa.pub

```

![Alt text](images/001_git_commands.png?raw=true "git commands")

Go to

![github](/images/github.png)

Login to your account

In the top right corner "click" on your profile and select "Settings"

![Alt text](images/002_github_settings.png?raw=true "github settings")

In the left menu "click" on "SSH and GPG keys"

![Alt text](images/003_github_settings.png?raw=true "github settings")

"Click" on the green "New SSH key"

![Alt text](images/004_github_newssh.png?raw=true "github settings")

On

![ansible](/images/ansible.png)

copy the pub key

![Alt text](images/005_github_pubkey.png?raw=true "github settings")

On

![github](/images/github.png)

Give the new key a Title "ansible"

paste the key

and click "Add SSH key"

![Alt text](images/006_github_pubkey_add.png?raw=true "github settings")

Now the key is created, you can see usage and delete the key when you are done with this course (My key is deleted)

![Alt text](images/007_github_pubkey.png?raw=true "github settings")

Now lets get the ssh url

In the browser go to your repository on github "click" the green "Code" button and select "SSH" copy the url

![Alt text](images/008_github_sshurl.png?raw=true "github sshurl")

On

![ansible](/images/ansible.png)

Change the __url__ to your own

__Type:__

```bash
cd

cd ansibleclass

git clone git@github.com:jesperberth/ansibleclass.git

```

![Alt text](images/009_github_sshurl_cmd.png?raw=true "github sshurl cmd")

Do a git pull

It will prompt you for RSA fingerprint authenticy, write "yes"

![Alt text](images/010_git_pull.png?raw=true "git pull")
