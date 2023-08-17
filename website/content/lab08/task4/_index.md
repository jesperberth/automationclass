---
title: Change DNS for Domainmember
weight: 40
---

## Task 4 Change DNS for Domainmember

[ansible docs - win dns client module](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_dns_client_module.html)

[ansible docs - win reboot module](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_reboot_module.html)

In

![vscode](/images/student-vscode.png)

Create a new file 01_changedns.yml

Add below to the playbook, this will set the member servers dns client to use the new domaincontroller.

```ansible
---
- name: Change DNS for member server
  hosts: domainmember

  tasks:
    - name: Change DNS for member servers
      ansible.windows.win_dns_client:
        adapter_names: "*"
        dns_servers: 10.1.0.7

    - name: Reboot member servers
      ansible.windows.win_reboot:

```

![Alt text](images/07_changedns.png?raw=true "changedns playbook")

Save and commit to Git

On

![ansible](/images/ansible.png)

Pull the new playbook and run it

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 01_changedns.yml --ask-vault-password

```

![Alt text](images/08_changedns_run.png?raw=true "changedns playbook run")
