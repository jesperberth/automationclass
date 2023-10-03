---
title: Add member server to AD
weight: 50
---

## Task 5 Add member server to AD

[ansible docs - win domain membership module](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_domain_membership_module.html)

[ansible docs - win reboot module](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_reboot_module.html)

In

![vscode](/images/student-vscode.png)

Create a new file __01_joinad.yml__

Add below to the playbook, this will join the member servers to the new Active Directory.

```ansible
---
- name: Join Active Directory
  hosts: domainmember
  vars:
    domain: ansible.local

  tasks:
    - name: Domain Join
      microsoft.ad.membership:
        dns_domain_name: "{{ domain }}"
        domain_admin_user: "{{ ansible_user }}@{{ domain }}"
        domain_admin_password: "{{ ansible_password }}"
        state: domain
      register: domain_join

    - name: Reboot Server
      ansible.windows.win_reboot:
      when: domain_join.reboot_required

```

![Alt text](images/09_joinad.png?raw=true "join ad")

Save and commit to Git

On

![ansible](/images/ansible.png)

Pull the new playbook and run it

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 01_joinad.yml --ask-vault-password

```

![Alt text](images/10_joinad_run.png?raw=true "join ad playbook run")

Check that everything worked

In

![vscode](/images/student-vscode.png)

Create a new playbook __03_domain.yml__

To list all computers in the OU __Computers__

```ansible
---
- name: Create Group and user
  hosts: domaincontroller
  vars:
    domain: ansible.local

  tasks:
    - name: Search all computer accounts
      microsoft.ad.object_info:
        filter: objectClass -eq 'computer'
        properties: '*'
        search_scope: one_level
        search_base: CN=Computers,DC=ansible,DC=local
      register: computers

    - name: Show Computers
      ansible.builtin.debug:
        msg: "{{ computers }}"

```

![Alt text](images/11_list_computers.png?raw=true "list computers")

Save and commit to Git

On

![ansible](/images/ansible.png)

Pull the new playbook and run it

__Type:__

```bash

cd ansibleclass

git pull

ansible-playbook 03_domain.yml --ask-vault-password

```

![Alt text](images/12_list_computers_run.png?raw=true "list computers run")
