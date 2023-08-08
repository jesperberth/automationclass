---
title: Connect Windows Host
weight: 40
---

## Task 4 Connect Windows Host

Windows Servers can be connected in different ways, we will use ansible_messageencryption, but Certificate encryption is available, but requires more work

![ansible](/images/ansible.png)

Log on to server "ansible" using ssh

We need to install pywinrm before being able to connect to windows servers from ansible

__Type:__

```bash
pip install pywinrm
```

![Alt text](images/019_install_pywinrm.png?raw=true "enable winRm")

Lets add the windows server to our ansible hosts file

Yes the password is in clear text, you can encrypt the password with ansible-vault

> **Note**
> Change __ansible_user__ and __ansible_password__ to your username and password

Add after the first group, linuxservers

__Type:__

```bash
vi ansible-hosts

i (for input)

[windowsservers]
server3

```

```bash

[windowsservers:vars]
ansible_user=jesbe
ansible_password=SomeThingSimple8
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

![Alt text](images/020_winrm_hostsfile.png?raw=true "hosts file winRm")

Lets test connection to the Windows server

__Type:__

```bash
ansible windowsservers -m win_ping
```

![Alt text](images/021_ansible_win_ping.png?raw=true "win_ping")
