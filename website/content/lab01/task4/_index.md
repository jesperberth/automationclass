---
title: Connect Linux host
weight: 40
---

## Task 4 Connect Linux host

Log on to server "ansible" using ssh

Lets create a configuration file for ansible in your root dir

We will use it to control our ansible environment

[Ansible Configuration file](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#ansible-configuration-settings-locations)

__Type:__

```bash
cd

pwd

vi .ansible.cfg
```

![Alt text](images/007_ansible_cfg.png?raw=true "ansible config")

> **Note**
> Change __jesbe__ in the path with your username

In vi __type:__

```bash
i (hit i to toggle input)
```

```bash
[defaults]
inventory = /home/jesbe/ansible-hosts
```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](images/008_ansible_cfg_set_inventory.png?raw=true "set ansible inventory")

Create the Ansible Hosts file

__Type:__

```bash
vi ansible-hosts
```

In vi __Type:__

```bash
i (hit i to toggle input)
```

```bash
[linuxservers]
server1
```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](images/009_edit_hostfile.png?raw=true "Edit ansible hostfile")

Lets ping our remote host server1

__Type:__

```bash
ansible linuxservers -m ping
```

If it asks "Are you sure you want to continue connecting (yes/no)?" type yes

![Alt text](images/009_connect_error.png?raw=true "Connect Error")

Connection will fail, as ansible expects passwordless ssh connections to be established before running

Test ssh to server 1

__Type:__

```bash
ssh server1
```

![Alt text](images/010_ssh_connect.png?raw=true "SSH Connect")

__Type:__

```bash
exit
```

We need to generate a ssh-key pair for passwordless connection

__Type:__

```bash
ssh-keygen
```

```bash
hit enter on key-path
hit enter for empty passphrase
hit enter again
```

![Alt text](images/011_ssh_keygen.png?raw=true "SSH Connect")

We need to copy the public key to server1

> **Note**
> Change __jesbe__ to your username

__Type:__

```bash
ssh-copy-id jesbe@server1
```

![Alt text](images/012_ssh_copy.png?raw=true "SSH Copy ID")

__Type:__

```bash
ssh server1
```

You should now be able to ssh to server1 without beeing prompted for a password

![Alt text](images/013_ssh_passwordless.png?raw=true "SSH Copy ID")

__Type:__

```bash
exit
```

Ping linuxservers

__Type:__

```bash
ansible linuxservers -m ping
```

![Alt text](images/014_ping_pong.png?raw=true "SSH Copy ID")

Lets test a few ansible commands

> **Note**
> Change jesbe to your username

__Type:__

```bash
ansible linuxservers -m file -a "path=/home/jesbe/testfile.txt state=touch"

ssh server1

ls
```

is the file testfile.txt there?

```bash

exit
```

![Alt text](images/015_file_test.png?raw=true "ansible file")

[Ansible Systemd module](https://docs.ansible.com/ansible/latest/modules/systemd_module.html)

__Type:__

```bash
ansible linuxservers -m systemd -a "name=cockpit.socket state=started enabled=yes"
```

![Alt text](images/016_systemd_error.png?raw=true "ansible systemd error")

This will fail as the user dosn't have the right permissions

Add -b (become will default use sudo to root) and --ask-become-pass is the escalation password

__Type:__

```bash
ansible linuxservers -m systemd -a "name=cockpit.socket state=started enabled=yes" -b --ask-become-pass
```

![Alt text](images/017_systemd_works.png?raw=true "ansible systemd works")
