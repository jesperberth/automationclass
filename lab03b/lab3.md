# Lab 3: Work with Playbooks

Running advanced playbooks with ansible

* Variables
* Lists
* Register
* Conditions
* Handlers
* Facts
* Debug
* set_fact
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
