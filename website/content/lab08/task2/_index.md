---
title: Create Domain controller
weight: 20
---

## Task 2 Create Domain controller

[ansible docs - win feature module](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_feature_module.html)

[ansible docs - win reboot](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_reboot_module.html)

[ansible docs - win domain](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_domain_module.html)

In VSCode create a new file 01_domain.yml

Add below to the playbook, this will create a new Active Directory.

```ansible
---
- name: Create Active Directory
  hosts: domaincontroller

  vars:
    domain: ansible.local

  tasks:
    - name: Install AD-Tools and DNS
      ansible.windows.win_feature:
        name:
          - DNS
          - AD-Domain-Services
        state: present
        include_management_tools: true
      register: feature_install

    - name: Reboot if required
      ansible.windows.win_reboot:
      when: feature_install.reboot_required

    - name: Create new Active Directory
      microsoft.ad.domain:
        create_dns_delegation: false
        database_path: C:\Windows\NTDS
        dns_domain_name: "{{ domain }}"
        domain_mode: Win2012R2
        forest_mode: Win2012R2
        safe_mode_password: "{{ ansible_password }}"
        sysvol_path: C:\Windows\SYSVOL
      register: domain_install

    - name: Reboot if required
      ansible.windows.win_reboot:
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
