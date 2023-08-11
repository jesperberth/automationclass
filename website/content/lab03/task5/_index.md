---
title: Add server two and run the playbook
weight: 50
---

## Task 5 Add server two and run the playbook

On

![ansible](/images/ansible.png)

We will add server 2 to the inventory

__Type:__

```bash
cd

vi ansible-hosts

```

![Alt text](images/029_edit_hosts.png?raw=true "Edit hosts")

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

![Alt text](images/030_2_server_play_error.png?raw=true "Run playbook error")

If server2 fails, did you copy your ssh key? "ssh-copy-id user@server2" and run the playbook again

![Alt text](images/030_2_server_play.png?raw=true "Run playbook")

The playbook now runs against both servers
