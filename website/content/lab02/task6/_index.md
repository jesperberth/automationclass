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

We need to configure git

And copy our public ssh key to our github account

__Type:__

```bash
cd

git config --global user.name "Your Name"

git config --global user.email "you@example.com"

cat ~/.ssh/id_rsa.pub

```

![Alt text](images/001_git_commands.png?raw=true "git commands")

On

![github](/images/github.png)

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

Type __Password__

![Alt text](images/006_github_pubkey_add_password.png?raw=true "github settings")

Now the key is created, you can see usage and delete the key when you are done with this course (My key is deleted)

![Alt text](images/007_github_pubkey.png?raw=true "github settings")

Go to your repository __ansibleclass__ click the green __Code__ button and select __SSH__ copy the url

![Alt text](images/008_github_sshurl.png?raw=true "github sshurl")

On

![ansible](/images/ansible.png)

Change the __url__ to your own

It will prompt you for RSA fingerprint authenticy, write "yes"

__Type:__

```bash
cd

mkdir git

cd git

git clone git@github.com:jesperberth/ansibleclass.git

```

![Alt text](images/009_github_sshurl_cmd.png?raw=true "github sshurl cmd")

Take a look

__Type:__

```bash
cd ansibleclass

ls

```

![Alt text](images/10_ansibleclass.png?raw=true "ansibleclass")
