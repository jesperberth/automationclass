---
title: Add member server to AD
weight: 50
---

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
