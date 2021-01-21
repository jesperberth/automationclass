# Lab 4: Roles

Using roles

## Prepare

We will need the servers, ansible, server1 and server2 to be up and running - by default they are started after creation

## Task 1: Ansible Galaxy and role install

[https://galaxy.ansible.com](https://galaxy.ansible.com/home)

[Ansible Docs - ansible-galaxy](https://docs.ansible.com/ansible/latest/cli/ansible-galaxy.html)

![Alt text](pics/001_ansible_galaxy.png?raw=true "ansible galaxy")

Ansible Galaxy holds roles and collections, its an Hub for sharing ansible content

Search for a role called el_httpd

![Alt text](pics/002_ansible_galaxy_search.png?raw=true "ansible galaxy search")

Click on the top result "el_https"

Click the Read Me for a short description of the role and how use it

Click on the GitHub Repo button to get to the repository for this role, you are able to provide feedback and report issues here

![Alt text](pics/003_ansible_galaxy_role.png?raw=true "ansible galaxy role")

Lets install the role

On the ansible server

__Type:__

```bash
cd

ansible-galaxy install jesperberth.el_httpd

ansible-galaxy role list

```

![Alt text](pics/004_ansible_galaxy_role_install.png?raw=true "ansible galaxy role install")

To test the role lets create a new playbook

In VsCode create a new file 01_roles.yml


__Type:__

```ansible

---
- hosts: linuxservers
  become: yes

  roles:
     - jesperberth.httpd

```

Save, Commit and push

![Alt text](pics/005_ansible_role_playbook.png?raw=true "ansible role playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_roles.yml --ask-become-pass

```

![Alt text](pics/006_ansible_role_playbook_run.png?raw=true "ansible role playbook run")

__Note:__ All tasks should be OK as we installed httpd in a previous lab

## Task 2: Create a role - part 1

[Ansible docs - Roles](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html)

Now we will create our own Role, webserver installing and configuring httpd and php

The role will be placed in the same git repository as we are using for the playbooks, but could have been placed in a seperate repo and committed to Ansible-Galaxy

We need to do some config to git, as we need to do some of the work on our linux host

We will set git to remember our git account password in memory for 1 hour

__Note:__ On August 13, 2021 you will no longer be allowed to login with a password, you will need to change to ssh keys

On ansible

__Type:__

```bash
cd

git config --global credential.helper 'cache --timeout=3600'

```

We will use ansible-galaxy command to initialize a role template

Its important that you do a git pull before we are adding anything in the folders

On ansible

__Type:__

```bash

cd  ansibleclass

git pull

mkdir roles

cd roles

ansible-galaxy init webserver

ls -al

```

![Alt text](pics/007_ansible_galaxy_init.png?raw=true "ansible galaxy init")

Now lets add, commit and push this to our git repo so we can work with the role in VSCode

On ansible

__Type:__

```bash

cd

cd ansibleclass

git add .

git commit -m "Adding roles"

git push origin master


```

![Alt text](pics/008_ansible_git_push.png?raw=true "ansible git push")

In VSCode do a push/pull to get the changes, you should see the roles \ webserver with all the default content

![Alt text](pics/009_vscode_push_pull.png?raw=true "vscode push pull")

## Task 3: Create a role - part 2

In VSCode we need to create tasks, handlers, meta and defaults

First thing to do is install all needed packages, start the httpd daemon and open the firewall

In VSCode open the roles/webserver/tasks/main.yml add the following

```ansible

---
# tasks file for webserver
- name: Install Packages
  ansible.builtin.package:
    name: "{{ package }}"
    state: latest

- name: Enable httpd service
  ansible.builtin.systemd:
    name: httpd
    state: started
    enabled: yes
  register: httpd_status

- name: Configure firewall
  ansible.posix.firewalld:
    zone: public
    service: http
    permanent: yes
    state: enabled
  notify: firewall reload

```

![Alt text](pics/010_vscode_tasks.png?raw=true "vscode tasks")

We will put a list - package in the defaults main.yml

Open defaults/main.yml and add the following

```ansible

---
# defaults file for webserver
package:
   - httpd
   - mod_ssl
   - openssl
   - php
   - php-gd
   - php-mbstring

```

![Alt text](pics/011_vscode_defaults.png?raw=true "vscode defaults")

We will add the handler firewall reload

Open handlers/main.yml and add the following

```ansible

---
---
# handlers file for webserver
- name: firewall reload
  ansible.builtin.systemd:
    name: firewalld
    state: reloaded

```

![Alt text](pics/012_vscode_handlers.png?raw=true "vscode handlers")

As a last thing, you need to update the meta/main.yml

In VSCode change the meta/main.yml so it matches your information, to get a god score on galaxy you will need to fill in

* author
* description
* company
* licens
* min_ansible_version
* platforms
* galaxy_tags
* dependecies (if any)

Fill in author, description, company, licens and platform

```ansible
galaxy_info:
  author: Jesper Berth
  description: Install and configure httpd and php on Enterprise Linux
  company: Arrow ECS

  # If the issue tracker for your role is not on github, uncomment the
  # next line and provide a value
  # issue_tracker_url: http://example.com/issue/tracker

  # Choose a valid license ID from https://spdx.org - some suggested licenses:
  # - BSD-3-Clause (default)
  # - MIT
  # - GPL-2.0-or-later
  # - GPL-3.0-only
  # - Apache-2.0
  # - CC-BY-4.0
  license: BSD-3-Clause

  min_ansible_version: 2.10

  # If this a Container Enabled role, provide the minimum Ansible Container version.
  # min_ansible_container_version:

  #
  # Provide a list of supported platforms, and for each platform a list of versions.
  # If you don't wish to enumerate all versions for a particular platform, use 'all'.
  # To view available platforms and versions (or releases), visit:
  # https://galaxy.ansible.com/api/v1/platforms/
  #
  platforms:
   - name: EL
     versions:
     - 8

  galaxy_tags: []
    # List tags for your role here, one per line. A tag is a keyword that describes
    # and categorizes the role. Users find roles by searching for tags. Be sure to
    # remove the '[]' above, if you add tags to this list.
    #
    # NOTE: A tag is limited to a single word comprised of alphanumeric characters.
    #       Maximum 20 tags per role.

dependencies: []
  # List your role dependencies here, one per line. Be sure to remove the '[]' above,
  # if you add dependencies to this list.


```

![Alt text](pics/013_vscode_meta.png?raw=true "vscode meta")

Create an php file index.php make sure its in the root of your ansibleclass repo

In VSCode add the following to index.php

```php
<?PHP
echo "Welcome to your new webserver";
echo gethostname();
?>

```

![Alt text](pics/014_vscode_index_php.png?raw=true "vscode index.php")

And finally lets create a playbook to run it all

Create a new file 02_roles.yml add the following

```ansible
---
- hosts: linuxservers
  become: yes

  roles:
     - webserver

  tasks:
  - name: Copy Index.php
    ansible.builtin.copy:
      src: index.php
      dest: /var/www/html/index.php
      owner: root
      group: root

```

![Alt text](pics/015_vscode_roles.png?raw=true "vscode roles")

Save and commit

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 02_roles.yml --ask-become-pass

```

Lab done

[Cloud](../lab05/lab5.md)
