---
title: Variables and Lists
weight: 10
---

## Task 1 Variables and Lists

[ansible docs - variables](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html)

Variables are a key value pair we can use to make dynamic tasks in our playbooks

In ansible vars can be defined in 22 different places, yes .... and they all take precedence over one and other see the list here

[ansible docs - variable precedence](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#understanding-variable-precedence)

[ansible docs - package module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/package_module.html)

Lets use a single variable in a playbook

Create a new playbook 01_vars.yml

__Type:__

```ansible
---
- name: Vars
  hosts: linuxservers
  become: true

  vars:
    package: httpd

  tasks:
    - name: Install Packages
      ansible.builtin.package:
        name: "{{ package }}"
        state: present
```

Save the playbook, Commit the changes and push to github

![Alt text](images/001_vars_playbook.png?raw=true "ansible vars in playbook")

On

![ansible](/images/ansible.png)

Pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_vars.yml --ask-become-pass

```

![Alt text](images/002_vars_playbook_run.png?raw=true "ansible vars in playbook run")

Lets change the playbook to use a list to install several packages

Change the playbook 01_vars.yml

__Type:__

```ansible
---
- name: Vars List
  hosts: linuxservers
  become: true

  vars:
    package:
      - httpd
      - mariadb-server
      - php
      - php-mysqlnd

  tasks:
    - name: Install Packages
      ansible.builtin.package:
        name: "{{ package }}"
        state: present

```

Save the playbook, Commit the changes and push to github

![Alt text](images/004_vars_list_playbook.png?raw=true "ansible vars list in playbook")

On

![ansible](/images/ansible.png)

Pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_vars.yml --ask-become-pass

```

![Alt text](images/005_vars_list_playbook_run.png?raw=true "ansible vars list in playbook run")
