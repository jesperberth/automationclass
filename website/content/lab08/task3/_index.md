---
title: Create user and group
weight: 30
---

## Task 3 Create user and group

[ansible docs - win domain group module](https://docs.ansible.com/ansible/latest/collections/community/windows/win_domain_group_module.html)
[ansible docs - win domain user module](https://docs.ansible.com/ansible/latest/collections/community/windows/win_domain_user_module.html)

In VSCode create a new file 02_domain.yml

Add below to the playbook, this will create a new group and user in AD.

__Type:__

```ansible
---
- name: Create Group and user
  hosts: domaincontroller
  vars:
    domain: ansible.local

  tasks:
    - name: Create Group
      microsoft.ad.group:
        name: corp
        scope: global
        state: present

    - name: Create user
      microsoft.ad.user:
        name: basim
        firstname: Bart
        surname: Simpson
        password: P@ssw0rd!
        state: present
        groups:
          add:
            - corp

```

![Alt text](images/05_addgrpanduser.png?raw=true "add group and user")

Save and commit to Git

On

![ansible](/images/ansible.png)

Pull the new playbook and run it

__Type:__

```bash

cd ansibleclass

git pull

ansible-playbook 02_domain.yml --ask-vault-password

```

![Alt text](images/06_addgrpanduser_run.png?raw=true "add group and user playbook run")
