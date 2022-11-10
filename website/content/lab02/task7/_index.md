---
title: Add server two and run the playbook
weight: 70
---

## Task 7 Add server two and run the playbook

We will add server 2 to the inventory

**Type:**

```bash
cd

vi ansible-hosts

```

![Alt text](images/029_edit_hosts.png?raw=true "Edit hosts")

In vi **type:**

```bash
i (for input)

[linuxservers]
server1
server2
```

**Type:**

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

**Type:**

```bash
cd ansibleclass

ansible-playbook 01_linux.yml --ask-become-pass
```

![Alt text](images/030_2_server_play_error.png?raw=true "Run playbook error")

If server2 fails, did you copy your ssh key? "ssh-copy-id user@server2" and run the playbook again

![Alt text](images/030_2_server_play.png?raw=true "Run playbook")

The playbook now runs against both servers
