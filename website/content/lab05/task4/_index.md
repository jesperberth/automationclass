---
title: Facts and debug
weight: 40
---

## Task 4 Facts and debug

[ansible docs - facts](https://docs.ansible.com/ansible/latest/user_guide/playbooks_vars_facts.html)

[ansible docs - setup module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/setup_module.html)

[ansible docs - debug module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/debug_module.html)

Per default ansible will collect facts from all hosts, this can be disabled in the playbook by setting __gather_facts: false__ this will speedup the playbook run, but facts will not be available for use in the playbook

you can run gather facts as a task in a playbook with module

ansible.builtin.setup

or just run a ansible -m setup

Lets get the facts of our linuxservers

__Type:__

```ansible

ansible linuxservers -m setup

```

![Alt text](images/001_get_facts.png?raw=true "ansible setup")

We can use a filter to get a cleaner output

__Type:__

```ansible

ansible linuxservers -m setup -a "filter=*ipv4"

```

![Alt text](images/002_get_facts_filter.png?raw=true "ansible setup filter")

We will use debug module to show the facts in a playbook

Debug will write any text including variables

Create a new playbook 01_facts.yml

__Type:__

```ansible
---
- name: Facts
  hosts: linuxservers

  tasks:
    - name: Debug Facts
      ansible.builtin.debug:
        msg: "{{ ansible_facts }}"

```

Save the playbook, Commit the changes and push to github

![Alt text](images/003_get_facts_playbook.png?raw=true "facts playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_facts.yml

```

![Alt text](images/004_get_facts_playbook_run.png?raw=true "facts playbook run")

Facts can be in one of three type

* List (Array) - will have [ ] values which are seperated with a ,
* Dictionary - will have { } around the key value pairs
* Ansible UnSafe Text (Variable)

![Alt text](images/005_ansible_facts.png?raw=true "ansible facts")

Lets get the nodename of our servers, nodename is an Ansible UnSafe Text

![Alt text](images/006_ansible_facts_nodename.png?raw=true "ansible facts nodename")

Add the below task to the playbook 01_facts.yml

__Type:__

```ansible

    - name: Debug Facts Hostname - Unsafe Text
      ansible.builtin.debug:
        msg: "{{ ansible_facts['nodename'] }}"

```

Save, Commit and push

![Alt text](images/007_ansible_facts_nodename_playbook.png?raw=true "ansible facts nodename playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_facts.yml

```

![Alt text](images/008_ansible_facts_nodename_playbook_run.png?raw=true "ansible facts nodename playbook")

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

![Alt text](images/009_ansible_facts_list_dic_playbook.png?raw=true "ansible facts list and dic playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_facts.yml

```

![Alt text](images/010_ansible_facts_list_dic_playbook_run.png?raw=true "ansible facts list and dic playbook run")
