# Lab 3: Work with Playbooks

Running advanced playbooks with ansible

* Facts
* Debug
* Register
* set_fact
* Lists
* Variables
* Loops
* Loops Async
* Conditions
* Handlers

## Prepare

We will need the servers, ansible, server1, server2 and server3 to be up and running - by default they are started after creation

## Task 1: Facts and debug

[ansible docs - facts](https://docs.ansible.com/ansible/latest/user_guide/playbooks_vars_facts.html)

[ansible setup module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/setup_module.html)

[ansible debug module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/debug_module.html)

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
