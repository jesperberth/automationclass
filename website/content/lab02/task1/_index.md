---
title: Install Ansible
weight: 10
---

## Task 1 Install Ansible

In

![student-pwsh](/images/student-pwsh.png)

In the Windows Terminal write __ssh username@ansible__ hit enter

__Type:__

```bash

yes - to accept the fingerprint

```

![Alt text](images/000_azure_ssh.png?raw=true "ssh")

> __Note__
> Sudo Password is equal to your user account password

In

![ansible](/images/ansible.png)

Ansible is a Python based program, we will install python in a Python Virtuelenv, in which we can isolate the python version and modules from the system python.

Check python version

```bash

python3 --version

```

![Alt text](images/000_default_python.png?raw=true "default python")

We need to upgrade python to version 3.11

```bash

sudo dnf update -y

sudo dnf install python3.11

sudo dnf install python3.11-pip

python3.11 --version

```

Lets create a Python virtualenv for our ansible installation

__Type:__

```bash

python3.11 -m venv venv-ansible

```

![Alt text](images/003_create_virtualenv.png?raw=true "create virtualenv Ansible")

To activate our virtualenv ansible run the following

which python - is just to check that were using the correct python

If you close the ssh session you will need to run __source ansible/bin/activate__ again to enable the python virtual environement

__Type:__

```bash

source venv-ansible/bin/activate

which python

python --version

```

> **Note**
> That when you are in a virtualenv, the name of the environment will be in the beginning of you command prompt like (ansible)

If you need to exit the virtualenv, you type "deactivate"

![Alt text](images/003_activate_virtualenv.png?raw=true "active virtualenv Ansible")

__Type:__

```bash

pip3 install --upgrade pip

```

![Alt text](images/002_install_pip3_upgrade.png?raw=true "Upgrade PIP")

__Type:__

```bash
pip install ansible==9.4.0
```

![Alt text](images/003_install_ansible.png?raw=true "Install Ansible")
