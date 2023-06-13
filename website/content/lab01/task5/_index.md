---
title: Install WSL
weight: 50
---

## Task 5 Install WSL

Install WSL

In Terminal

When its ready, reboot the workstation

```powershell

wsl --install

```

![Alt text](images/01_install_wsl.png?raw=true "install wsl")

Login to you workstation

After the reboot

Ubuntu will continue the installation

When ready it will prompt for a username and password

![Alt text](images/02_install_wsl_add_user.png?raw=true "install wsl add user")

WSL is now ready

![Alt text](images/03_wsl_ready.png?raw=true "wsl ready")

Enable Systemd for WSL

Enter password when prompted

```bash

sudo su

echo -e "[boot]\nsystemd=true" >> /etc/wsl.conf

```

![Alt text](images/04_wsl_systemd.png?raw=true "wsl set systemd")

Close the Linux console

We will check for updates to WSL

The shutdown is need for the systemd to work

Open Windows Terminal and run

```powershell

wsl --update

wsl --shutdown

```

![Alt text](images/04_wsl_update.png?raw=true "wsl update")

Close the terminal and reopen it

We need to install the vscode remote extention

In the terminal

```powershell

code --install-extension ms-vscode-remote.remote-wsl

```

![Alt text](images/05_code_remote_ext.png?raw=true "code extention")

Now start WSL from Windows Terminal

In the menu select __Ubuntu__

![Alt text](images/06_start_ubuntu.png?raw=true "start ubuntu")

Now update the Ubuntu

```bash

sudo apt-get update && sudo apt-get upgrade -y

```

![Alt text](images/07_update_ubuntu.png?raw=true "update ubuntu")

Install docker

```bash

sudo apt-get install docker.io -y

```

![Alt text](images/08_install_docker.png?raw=true "install docker")

Add user to the docker group

```bash

sudo usermod -aG docker $USER

```

![Alt text](images/10_groupadd.png?raw=true "groupadd")

Next allow your user to run docker without typing a password

```bash

echo $USER' ALL = NOPASSWD: /usr/bin/dockerd' | sudo EDITOR='tee -a' visudo

```

![Alt text](images/11_visudo.png?raw=true "visudo")

__Close__ the Ubuntu tab in Windows Terminal and open it again

run a docker command to check that it works

```bash

docker ps

```

if it looks like this, it worked

![Alt text](images/12_docker_ps.png?raw=true "docker ps")

Lets install some VS Code extentions

- Ansible
- Indent Rainbow
- Indent One Space

In the terminal run below to install the extentions

__Note:__ Make sure you are in the Windows Powershell Tab

```bash

code --install-extension redhat.ansible
code --install-extension oderwat.indent-rainbow
code --install-extension usernamehw.indent-one-space

```

![Alt text](images/13_install_code_extentions.png?raw=true "Install code extentions")
