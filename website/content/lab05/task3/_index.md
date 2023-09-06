---
title: Handlers
weight: 30
---

## Task 3 Handlers

[ansible docs - handlers](https://docs.ansible.com/ansible/latest/user_guide/playbooks_handlers.html)

[ansible docs - firewalld module](https://docs.ansible.com/ansible/latest/collections/ansible/posix/firewalld_module.html)

Handlers will run tasks on changes in other tasks

A handler is a task placed in a seperat section __handlers:__ in the playbook and run when a task __notify__ it to run

In

![vscode](/images/student-vscode.png)

Add below to the playbook 01_vars.yml

First task configures the firewall and has the notify option sat

below is the handlers: section, we create the firewall reload handler

__Type:__

```ansible

    - name: Configure firewall
      ansible.posix.firewalld:
        zone: public
        service: http
        permanent: true
        state: enabled
      notify: Firewall reload

  handlers:
    - name: Firewall reload
      ansible.builtin.systemd:
        name: firewalld
        state: reloaded

```

Save the playbook, Commit the changes and push to github

![Alt text](images/001_handlers_playbook.png?raw=true "ansible handlers in playbook")

On

![ansible](/images/ansible.png)

Pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_vars.yml 

```

![Alt text](images/002_handlers_playbook_run.png?raw=true "ansible handlers playbook run")

On the ansible server run the playbook again, note this time it will not run the handler

__Type:__

```bash

ansible-playbook 01_vars.yml 

```

![Alt text](images/003_handlers_playbook_run2.png?raw=true "ansible handlers playbook second run")
