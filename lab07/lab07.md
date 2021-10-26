# Lab 6: Ansible Windows

In this session we will use ansible to setup and manage Active Directory, add users and groups and join a second server to the domain.

Server3 will act as Domain controller, server4 will join as a member

## Table of Contents

- [Prepare](#prepare)
- [Task 1 Task 1 Add new host groups](#task-1-add-new-host-groups)
- [Task 2 Create Domain controller](#task-2-create-domain-controller)
- [Task 3 Create user and group](#task-3-create-user-and-group)
- [Task 4 Change DNS for Domainmember](#task-4-change-dns-for-domainmember)
## Prepare

We will need the servers, __ansible__, __server3__ and __server4__ to be up and running - by default they are started after creation

## Task 1 Add new host groups

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

![Alt text](pics/01_changehosts.png?raw=true "change hosts file")

Lets test the groups

__Type:__

```bash

ansible windowsservers -m win_ping --ask-vault-password

ansible domaincontroller -m win_ping --ask-vault-password

ansible domainmember -m win_ping --ask-vault-password

```

![Alt text](pics/02_testgroups.png?raw=true "Test groups")

## Task 2 Create Domain controller

In VSCode create a new file 01_domain.yml

```ansible

---
- hosts: domaincontroller
  vars:
    domain: ansible.local

  tasks:
  - name: Install AD-Tools and DNS
    win_feature:
      name:
      - DNS
      - AD-Domain-Services
      state: present
      include_management_tools: yes
    register: feature_install

  - name: Reboot if required
    win_reboot:
    when: feature_install.reboot_required

  - name: Create new Active Directory
    win_domain:
      create_dns_delegation: no
      database_path: C:\Windows\NTDS
      dns_domain_name: "{{ domain }}"
      domain_mode: Win2012R2
      forest_mode: Win2012R2
      safe_mode_password: "{{ ansible_password }}"
      sysvol_path: C:\Windows\SYSVOL
    register: domain_install

  - name: Reboot if required
    win_reboot:
    when: domain_install.reboot_required
```

![Alt text](pics/03_domaincontroller.png?raw=true "domain controller playbook")

Save and commit to Git

Log on to server "ansible" using ssh

Use git to get the new azure playbook

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 01_domain.yml --ask-vault-password

```

![Alt text](pics/04_domaincontroller_play.png?raw=true "domain controller playbook run")

## Task 3 Create user and group

[ansible docs - win domain group module](https://docs.ansible.com/ansible/latest/collections/community/windows/win_domain_group_module.html)
[ansible docs - win domain user module](https://docs.ansible.com/ansible/latest/collections/community/windows/win_domain_user_module.html)

In VSCode create a new file 02_domain.yml

Add below to the playbook, this will create a new group and user in AD.

__Type:__

```ansible
---
- hosts: domaincontroller
  vars:
    domain: ansible.local

  tasks:
  - name: Create Group
    community.windows.win_domain_group:
      name: corp
      scope: global
      state: present

  - name: Create user
    community.windows.win_domain_user:
      name: basim
      firstname: Bart
      surname: Simpson
      password: P@ssw0rd!
      state: present
      groups:
      - corp
```

![Alt text](pics/05_addgrpanduser.png?raw=true "add group and user")

Save and commit to Git

Log on to server "ansible" using ssh

Use git to get the new azure playbook

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 01_domain.yml --ask-vault-password

```

![Alt text](pics/06_addgrpanduser_run.png?raw=true "add group and user playbook run")

## Task 4 Change DNS for Domainmember

Lab Done

[Ansible Tower AWX](../lab08/lab8.md)
