---
title: Ansible Galaxy and role install
weight: 10
---

## Task 1 Ansible Galaxy and role install

[https://galaxy.ansible.com](https://galaxy.ansible.com/home)

[Ansible Docs - ansible-galaxy](https://docs.ansible.com/ansible/latest/cli/ansible-galaxy.html)

![Alt text](images/001_ansible_galaxy.png?raw=true "ansible galaxy")

Ansible Galaxy holds roles and collections, its an Hub for sharing ansible content

Search for a role called el_httpd

![Alt text](images/002_ansible_galaxy_search.png?raw=true "ansible galaxy search")

Click on the top result "el_httpd"

Click the Read Me for a short description of the role and how use it

Click on the GitHub Repo button to get to the repository for this role, you are able to provide feedback and report issues here

![Alt text](images/003_ansible_galaxy_role.png?raw=true "ansible galaxy role")

Lets install the role

On the ansible server

__Type:__

```bash
cd

ansible-galaxy install jesperberth.el_httpd

ansible-galaxy role list

```

![Alt text](images/004_ansible_galaxy_role_install.png?raw=true "ansible galaxy role install")

To test the role lets create a new playbook

In VsCode create a new file 01_roles.yml

__Type:__

```ansible
---
- name: Roles
  hosts: linuxservers
  become: true

  roles:
      - jesperberth.el_httpd

```

Save, Commit and push

![Alt text](images/005_ansible_role_playbook.png?raw=true "ansible role playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_roles.yml --ask-become-pass

```

![Alt text](images/006_ansible_role_playbook_run.png?raw=true "ansible role playbook run")

__Note:__ All tasks should be OK as we installed httpd in a previous lab
