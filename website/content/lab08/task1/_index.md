---
title: Add new host groups
weight: 10
---

## Task 1 Add new host groups

[ansible docs - inventory](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html)

We need to add child groups to the windowsserver group in the host file, when using child groups we can target the group windowsserver or one of the child groups like domaincontrollers

Log on to server "ansible" using ssh

Use vi to edit ansible-hosts.yml

__Type:__

```bash
cd

vi ansible-hosts.yml
```

In vi __type:__

```bash
i (hit i to toggle input)
```

Add below between server4: and vars: be aware that the indentation needs to be correct

```bash
  children:
    domaincontroller:
      hosts:
        server3:
    domainmember:
      hosts:
        server4:
```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](images/01_changehosts.png?raw=true "change hosts file")

Lets test the groups

__Type:__

```bash

ansible windowsservers -m win_ping --ask-vault-password

ansible domaincontroller -m win_ping --ask-vault-password

ansible domainmember -m win_ping --ask-vault-password

```

![Alt text](images/02_testgroups.png?raw=true "Test groups")
