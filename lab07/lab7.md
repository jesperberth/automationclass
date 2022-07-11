# Lab 7: Ansible Windows

In this session we will use ansible to setup and manage Active Directory, add users and groups and join a second server to the domain.

Server3 will act as Domain controller, server4 will join as a member

## Table of Contents

- [Prepare](#prepare)
- [Task 1 Task 1 Add new host groups](#task-1-add-new-host-groups)
- [Task 2 Create Domain controller](#task-2-create-domain-controller)
- [Task 3 Create user and group](#task-3-create-user-and-group)
- [Task 4 Change DNS for Domainmember](#task-4-change-dns-for-domainmember)
- [Task 5 Add member server to AD](#task-5-add-member-server-to-ad)

## Prepare

We will need the servers, __ansible__, __server3__ and __server4__ to be up and running - by default they are started after creation

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

## Task 2 Create Domain controller

[ansible docs - win feature module](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_feature_module.html)

[ansible docs - win reboot](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_reboot_module.html)

[ansible docs - win domain](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_domain_module.html)

In VSCode create a new file 01_domain.yml

Add below to the playbook, this will create a new Active Directory.

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

![Alt text](images/03_domaincontroller.png?raw=true "domain controller playbook")

Save and commit to Git

Log on to server "ansible" using ssh

Use git to get the new azure playbook

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 01_domain.yml --ask-vault-password

```

![Alt text](images/04_domaincontroller_play.png?raw=true "domain controller playbook run")

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

![Alt text](images/05_addgrpanduser.png?raw=true "add group and user")

Save and commit to Git

Log on to server "ansible" using ssh

Use git to get the new azure playbook

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 02_domain.yml --ask-vault-password

```

![Alt text](images/06_addgrpanduser_run.png?raw=true "add group and user playbook run")

## Task 4 Change DNS for Domainmember

[ansible docs - win dns client module](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_dns_client_module.html)

[ansible docs - win reboot module](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_reboot_module.html)

In VSCode create a new file 01_changedns.yml

Add below to the playbook, this will set the member servers dns client to use the new domaincontroller.

```ansible
---
- hosts: domainmember

  tasks:
  - name: Change DNS for member servers
    ansible.windows.win_dns_client:
      adapter_names: "*"
      dns_servers: 10.1.0.7

  - name: Reboot member servers
    win_reboot:
```

![Alt text](images/07_changedns.png?raw=true "changedns playbook")

Save and commit to Git

Log on to server "ansible" using ssh

Use git to get the new azure playbook

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 01_changedns.yml --ask-vault-password

```

![Alt text](images/08_changedns_run.png?raw=true "changedns playbook run")

## Task 5 Add member server to AD

[ansible docs - win domain membership module](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_domain_membership_module.html)

[ansible docs - win reboot module](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_reboot_module.html)

In VSCode create a new file 01_joinad.yml

Add below to the playbook, this will join the member servers to the new Active Directory.

```ansible
---
- hosts: domainmember
  vars:
    domain: ansible.local

  tasks:
  - name: Domain Join
    win_domain_membership:
      dns_domain_name: "{{ domain }}"
      domain_admin_user: "{{ ansible_user }}@{{ domain }}"
      domain_admin_password: "{{ ansible_password }}"
      state: domain
    register: domain_join

  - name: Reboot Server
    win_reboot:
    when: domain_join.reboot_required

```

![Alt text](images/09_joinad.png?raw=true "join ad")

Save and commit to Git

Log on to server "ansible" using ssh

Use git to get the new azure playbook

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 01_joinad.yml --ask-vault-password

```

![Alt text](images/10_joinad_run.png?raw=true "join ad playbook run")

Lets check that everything worked

Logon to the Domain Controller (server3) using RDP

In the Server Manager Console, top right corner select tools and click on "Active Directory Users and Computers"

![Alt text](images/11_open_ad_users.png?raw=true "Open Active Directory Users and Computers")

In the new window click on computers, server4 should be visible here

![Alt text](images/12_computers.png?raw=true "Show Computers")

Click on users, see that the user "basim" exist and the group "corp" exist, right click on "corp" and select properties select the "Members" Tab, the user "basim" should be a member.

![Alt text](images/13_grpanduser.png?raw=true "Show Users")

Lab Done

[Ansible Cloud](../lab08/lab8.md)
