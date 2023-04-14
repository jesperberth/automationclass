---
title: Install Ansible
weight: 10
---

## Task 1 Install Ansible

Start Windows Terminal

In the startmenu __Type__ "terminal" and click on __Windows Terminal__

![Alt text](images/000_student_start_winterm.png?raw=true "Student start winterminal")

In the Windows Terminal write ssh __username@ansible__ hit enter

__Type:__

```bash

yes - to accept the fingerprint

```

![Alt text](images/000_azure_ssh.png?raw=true "ssh")

> __Note__
> Sudo Password is equal to your user account password

Ansible is a Python based program, we will install python in a Python Virtuelenv, in which we can isolate the python version and modules from the system python.

Check python version

```bash

python3 --version

```

![Alt text](images/000_default_python.png?raw=true "default python")

Lets create a Python virtualenv for our ansible installation

__Type:__

```bash

python3 -m venv ansible

```

![Alt text](images/003_create_virtualenv.png?raw=true "create virtualenv Ansible")

To activate our virtualenv ansible run the following

which python - is just to check that were using the correct python

__Type:__

```bash

source ansible/bin/activate

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
pip install ansible
```

![Alt text](images/003_install_ansible.png?raw=true "Install Ansible")
