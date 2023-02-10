---
title: Create a role - part 2
weight: 40
---

## Task 4 Create a role - part 2

In VSCode we need to create tasks, handlers, meta and defaults

First thing to do is install all needed packages, start the httpd daemon and open the firewall

In VSCode open the roles/webserver/tasks/main.yml add the following

```ansible
---
# tasks file for webserver
- name: Install Packages
  ansible.builtin.package:
    name: "{{ package }}"
    state: present
  notify: Httpd restart

- name: Enable httpd service
  ansible.builtin.systemd:
    name: httpd
    state: started
    enabled: true

- name: Configure firewall
  ansible.posix.firewalld:
    zone: public
    service: http
    permanent: true
    state: enabled
  notify: Firewall reload

```

![Alt text](images/010_vscode_tasks.png?raw=true "vscode tasks")

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

![Alt text](images/011_vscode_defaults.png?raw=true "vscode defaults")

We will add the handler firewall reload

Open handlers/main.yml and add the following

```ansible
---
# handlers file for webserver
- name: Firewall reload
  ansible.builtin.systemd:
    name: firewalld
    state: reloaded

- name: Httpd restart
  ansible.builtin.systemd:
    name: httpd
    state: restarted

```

![Alt text](images/012_vscode_handlers.png?raw=true "vscode handlers")

As a last thing, you need to update the meta/main.yml

In VSCode change the meta/main.yml so it matches your information, to get a god score on galaxy you will need to fill in

- author
- description
- company
- licens
- min_ansible_version
- platforms
- galaxy_tags
- dependecies (if any)

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

  min_ansible_version: "2.10"

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
        - "8"

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

![Alt text](images/013_vscode_meta.png?raw=true "vscode meta")

Create an php file index.php make sure its in the root of your ansibleclass repo

In VSCode add the following to index.php

```php
<?PHP
echo "Welcome to your new webserver: ";
echo gethostname();
?>

```

![Alt text](images/014_vscode_index_php.png?raw=true "vscode index.php")

And finally lets create a playbook to run it all

First we use our role to install and configure httpd and php next we have a simple task that copies our php file

Create a new file 02_roles.yml add the following

```ansible
---
- name: Webserver Role
  hosts: linuxservers
  become: true

  roles:
  - webserver

  tasks:
    - name: Copy Index.php
      ansible.builtin.copy:
        src: index.php
        dest: /var/www/html/index.php
        owner: root
        group: root
        mode: 0755

```

![Alt text](images/015_vscode_roles.png?raw=true "vscode roles")

Save and commit

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 02_roles.yml --ask-become-pass

```

![Alt text](images/016_vscode_roles_run.png?raw=true "vscode roles run")

Go to the azure portal and get the external ip of server1 or server2 and type it in your browser

![Alt text](images/01_webpage.png?raw=true "webpage")
