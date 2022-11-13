---
title: Install Ansible
weight: 10
---

## Task 1 Install Ansible

Log on to your workstation __student__ using rdp

On the Azure portal click Virtual Machines

![Alt text](images/000_azure_portal.png?raw=true "Azure Portal")

Select your Resource Group, it's named __ansible-initials__

![Alt text](images/000_azure_portal_resourcegroup.png?raw=true "Azure Portal")

Click on the student vm

![Alt text](images/000_azure_portal_vm.png?raw=true "Azure Portal VMs")

Get the ansible servers external ip, click on the "Copy to ClipBoard"

![Alt text](images/000_azure_portal_vm_ip.png?raw=true "Azure Portal VM ip")

Start a Remote Desktop Client (On windows run __mstsc__) paste the public IP and connect

![Alt text](images/000_azure_portal_vm_mstsc.png?raw=true "mstsc")

Click "More choises" type your username/initials and password click __Ok__

![Alt text](images/000_azure_portal_vm_mstsc_login.png?raw=true "mstsc login")

Select the "Don't ask me again for connections to this computer and click __Yes__

![Alt text](images/000_azure_portal_vm_mstsc_login_yes.png?raw=true "mstsc login")

On the stundent vm click __Accept__

![Alt text](images/000_student_accept.png?raw=true "Student accept")

Start Windows Terminal

In the startmenu __Type__ "terminal" and click on __Windows Terminal__

![Alt text](images/000_student_start_winterm.png?raw=true "Student start winterminal")

In the Windows Terminal write ssh __username@ansible__ hit enter

__Type:__

```bash

yes - to accept the fingerprint

```

![Alt text](images/000_azure_ssh.png?raw=true "ssh")

__Type:__

> **Note**
> Sudo Password is equal to your user account password

Ansible is a Python based program, we will install python in a Python Virtuelenv, in which we can isolate the python version and modules from the system python.

To meet ansible 2.12 requirements we need to upgrade Python to version 3.9

```bash

sudo dnf install -y @python39

```

![Alt text](images/000_install_python.png?raw=true "install python")

And we need to set the alternative for python3 command to python3.9

```bash

sudo alternatives --set python3 /usr/bin/python3.9

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
