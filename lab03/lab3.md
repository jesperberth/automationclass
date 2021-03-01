# Lab 3: Work with Playbooks

Running advanced playbooks with ansible

* Variables
* Lists
* Register
* Conditions
* Handlers
* Facts
* Debug
* Loops
* Loops Async

## Prepare

We will need the servers, ansible, server1, server2 and server3 to be up and running - by default they are started after creation

## Task 1: Variables and Lists

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
- hosts: linuxservers
  become: yes

  vars:
      package: httpd

  tasks:
  - name: Install Packages
    ansible.builtin.package:
      name: "{{ package }}"
      state: latest
```

Save the playbook, Commit the changes and push to github

![Alt text](pics/001_vars_playbook.png?raw=true "ansible vars in playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_vars.yml --ask-become-pass

```

![Alt text](pics/002_vars_playbook_run.png?raw=true "ansible vars in playbook run")

Lets change the playbook to use a list to install several packages

Change the playbook 01_vars.yml

__Type:__

```ansible
---
- hosts: linuxservers
  become: yes

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
      state: latest

```

Save the playbook, Commit the changes and push to github

![Alt text](pics/004_vars_list_playbook.png?raw=true "ansible vars list in playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_vars.yml --ask-become-pass

```

![Alt text](pics/005_vars_list_playbook_run.png?raw=true "ansible vars list in playbook run")

## Task 2: Register and Conditions

[ansible docs - systemd module](https://docs.ansible.com/ansible/2.5/modules/systemd_module.html)

All Tasks in a playbook has an output, we can put this output into a variable and use in other tasks

Add a task to start the httpd service, register the output of systemd and show the output with debug

Add below to the playbook 01_vars.yml

__Type:__

```ansible

  - name: Enable httpd service
    ansible.builtin.systemd:
      name: httpd
      state: started
      enabled: yes
    register: httpd_status

  - name: Show Status
    debug:
      var: httpd_status

```

Save the playbook, Commit the changes and push to github

![Alt text](pics/001_register_playbook.png?raw=true "ansible register in playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_vars.yml --ask-become-pass

```

![Alt text](pics/002_register_playbook_run.png?raw=true "ansible register in playbook run")

The status from systemd contains alot of information, scroll to the top to see that the httpd service is now enabled and running

![Alt text](pics/003_register_playbook_status.png?raw=true "ansible register in playbook status")

We can use facts from the registered variable httpd_status in a condition

[ansible docs - conditionals](https://docs.ansible.com/ansible/latest/user_guide/playbooks_conditionals.html)

Add below to the playbook 01_vars.yml

__Type:__

```ansible

  - name: Is httpd running
    debug:
      msg: httpd is running
    when: httpd_status.state == "started"

```
Save the playbook, Commit the changes and push to github

![Alt text](pics/004_conditional_playbook.png?raw=true "ansible conditional in playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_vars.yml --ask-become-pass

```

![Alt text](pics/005_conditional_playbook_run.png?raw=true "ansible conditional in playbook run")

## Task 3: Handlers

[ansible docs - handlers](https://docs.ansible.com/ansible/latest/user_guide/playbooks_handlers.html)

[ansible docs - firewalld module](https://docs.ansible.com/ansible/latest/collections/ansible/posix/firewalld_module.html)

Handlers will run tasks on changes in other tasks

A handler is a task placed in a seperat section __handlers:__ in the playbook and run when a task __notify__ it to run

Add below to the playbook 01_vars.yml

First task configures the firewall and has the notify option sat

below is the handlers: section, we create the firewall reload handler

__Type:__

```ansible

  - name: Configure firewall
    ansible.posix.firewalld:
      zone: public
      service: http
      permanent: yes
      state: enabled
    notify: firewall reload

  handlers:
  - name: firewall reload
    ansible.builtin.systemd:
      name: firewalld
      state: reloaded

```

Save the playbook, Commit the changes and push to github

![Alt text](pics/001_handlers_playbook.png?raw=true "ansible handlers in playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_vars.yml --ask-become-pass

```

![Alt text](pics/002_handlers_playbook_run.png?raw=true "ansible handlers playbook run")

On the ansible server run the playbook again, note this time it will not run the handler

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_vars.yml --ask-become-pass

```

![Alt text](pics/003_handlers_playbook_run2.png?raw=true "ansible handlers playbook second run")

## Task 4: Facts and debug

[ansible docs - facts](https://docs.ansible.com/ansible/latest/user_guide/playbooks_vars_facts.html)

[ansible docs - setup module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/setup_module.html)

[ansible docs - debug module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/debug_module.html)

Per default ansible will collect facts from all hosts, this can be disabled in the playbook by setting __gather_facts: no__ this will speedup the playbook run, but facts will not be available for use in the playbook

you can run gather facts as a task in a playbook with module

ansible.builtin.setup

or just run a ansible -m setup

Lets get the facts of our linuxservers

__Type:__

```ansible

ansible linuxservers -m setup

```

![Alt text](pics/001_get_facts.png?raw=true "ansible setup")

We can use a filter to get a cleaner output

__Type:__

```ansible

ansible linuxservers -m setup -a "filter=*ipv4"

```

![Alt text](pics/002_get_facts_filter.png?raw=true "ansible setup filter")

We will use debug module to show the facts in a playbook

Debug will write any text including variables

Create a new playbook 01_facts.yml

__Type:__

```ansible
---
- hosts: linuxservers

  tasks:
  - name: Debug Facts
    ansible.builtin.debug:
      msg: "{{ ansible_facts }}"
```
Save the playbook, Commit the changes and push to github

![Alt text](pics/003_get_facts_playbook.png?raw=true "facts playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_facts.yml

```

![Alt text](pics/004_get_facts_playbook_run.png?raw=true "facts playbook run")

Facts can be in one of three type

* List (Array) - will have [ ] values which are seperated with a ,
* Dictionary - will have { } around the key value pairs
* Ansible UnSafe Text (Variable)

![Alt text](pics/005_ansible_facts.png?raw=true "ansible facts")

Lets get the nodename of our servers, nodename is an Ansible UnSafe Text

![Alt text](pics/006_ansible_facts_nodename.png?raw=true "ansible facts nodename")

Add the below task to the playbook 01_facts.yml

__Type:__

```ansible

  - name: Debug Facts Hostname
    ansible.builtin.debug:
      msg: "{{ ansible_facts['nodename'] }}"

```

Save, Commit and push

![Alt text](pics/007_ansible_facts_nodename_playbook.png?raw=true "ansible facts nodename playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_facts.yml

```

![Alt text](pics/008_ansible_facts_nodename_playbook_run.png?raw=true "ansible facts nodename playbook")

Now lets try getting output from a list and a dictionary

Add the below task to the playbook 01_facts.yml

__Type:__

```ansible

  - name: Debug Facts ipv4 - List
    ansible.builtin.debug:
      msg: "{{ ansible_facts['all_ipv4_addresses'][0] }}"

  - name: Debug Facts SeLinux Status - Dictionary
    ansible.builtin.debug:
      msg: "{{ ansible_facts['selinux']['status'] }}"

```

Save, Commit and push

![Alt text](pics/009_ansible_facts_list_dic_playbook.png?raw=true "ansible facts list and dic playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_facts.yml

```

![Alt text](pics/010_ansible_facts_list_dic_playbook_run.png?raw=true "ansible facts list and dic playbook run")

Next Lab

[Cloud Playbooks](../lab04/lab4.md)

## Task 5: Loops

[ansible docs - loops](https://docs.ansible.com/ansible/latest/user_guide/playbooks_loops.html)

[ansible docs - user module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/user_module.html)

[ansible docs - group module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/group_module.html)

In ansible we can use loops to repeat a task multiple times eg. creating users

Create a new file in Vscode 01_loop.yml

__Type:__

```ansible

---
- hosts: linuxservers
  become: yes

  tasks:
  - name: Ensure group developers exists
    group:
      name: Developers
      state: present

  - name: Create Users
    ansible.builtin.user:
      name: "{{ item }}"
      group: Developers
    loop:
      - homer
      - bart
      - lisa
      - ned
      - moe

```

Save, Commit and push

![Alt text](pics/001_ansible_loop_playbook.png?raw=true "ansible loop playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_loop.yml --ask-become-pass

```

![Alt text](pics/002_ansible_loop_playbook_run.png?raw=true "ansible loop playbook run")

We can iterate over a list of hashes

Change the file 01_loop.yml

__Type:__

```ansible

---
- hosts: linuxservers
  become: yes

  tasks:
  - name: Ensure group developers exists
    group:
      name: "{{ item }}"
      state: present
    loop:
      - It
      - Developers
      - Finance
      - Management

  - name: Create Users
    ansible.builtin.user:
      name: "{{ item.name }}"
      group: "{{ item.groups }}"
    loop:
      - { name: 'homer', groups: 'Developers' }
      - { name: 'bart', groups: 'It' }
      - { name: 'lisa', groups: 'Management' }
      - { name: 'ned', groups: 'Finance' }
      - { name: 'moe', groups: 'Developers' }

```

Save, Commit and push

![Alt text](pics/003_ansible_loop_hash_playbook.png?raw=true "ansible loop hash playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_loop.yml --ask-become-pass

```

![Alt text](pics/004_ansible_loop_hash_playbook_run.png?raw=true "ansible loop hash playbook run")

## Task 6: Loops Async

[Ansible docs - async](https://docs.ansible.com/ansible/latest/user_guide/playbooks_async.html)

[Ansible docs - get_url module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/get_url_module.html)

Ansible run tasks synchronously, keeping the connection open while running every task in the playbook one by one.

In some cases if tasks take to long or there are to many long running tasks the connection can timeout, or you just want the playbook to run faster - we can use async on the tasks

In the following playbook the first task will use get_url to download two files on each host, run them async and register the result in a variable, the second task will loop though the results get the job id and monitor for a finished result.

Create a new file in Vscode 02_loop.yml

__Type:__

```ansible

---
- hosts: linuxservers
  become: yes

  tasks:
    - name: Download files
      ansible.builtin.get_url:
        url: "{{ item }}"
        dest: /mnt/resource/
      loop:
        - https://github.com/git-for-windows/git/releases/download/v2.30.0.windows.1/Git-2.30.0-64-bit.exe
        - https://www.python.org/ftp/python/3.8.7/python-3.8.7-embed-amd64.zip
      async: 3
      poll: 0
      register: download_loop

    - name: Wait for downloads
      async_status:
        jid: "{{item.ansible_job_id}}"
        mode: status
      retries: 300
      delay: 1
      loop: "{{ download_loop.results }}"
      register: async_loop_jobs
      until: async_loop_jobs.finished

```

Save, Commit and push

![Alt text](pics/001_ansible_loop_async_playbook.png?raw=true "ansible loop async playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 02_loop.yml --ask-become-pass

```

![Alt text](pics/002_ansible_loop_async_playbook_run.png?raw=true "ansible loop async playbook run")

Lab done

[Ansible Linting](../lab04/lab4.md)
