---
title: Loops
weight: 50
---

## Task 5 Loops

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

![Alt text](images/001_ansible_loop_playbook.png?raw=true "ansible loop playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_loop.yml --ask-become-pass

```

![Alt text](images/002_ansible_loop_playbook_run.png?raw=true "ansible loop playbook run")

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

![Alt text](images/003_ansible_loop_hash_playbook.png?raw=true "ansible loop hash playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_loop.yml --ask-become-pass

```

![Alt text](images/004_ansible_loop_hash_playbook_run.png?raw=true "ansible loop hash playbook run")
