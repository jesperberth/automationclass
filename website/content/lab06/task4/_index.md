---
title: Pre and Post task
weight: 40
---

## Task 4 Pre and post task

[Ansible Docs - Task Delgation](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_delegation.html)

```ansible
---
- name: Task Delegation
  hosts: linuxservers

  tasks:
    - name: Debug Facts Hostname
      ansible.builtin.debug:
        msg: "{{ ansible_facts['nodename'] }}"

    - name: Write File
      ansible.builtin.command:
        cmd: ~/ansibleclass/set_server_offline.sh "{{ ansible_facts['nodename'] }}" "{{ ansible_facts['all_ipv4_addresses'][0] }}"
      register: output
      changed_when: output.rc == 0
      delegate_to: localhost

```

Save, Commit and push

![Alt text](images/002_ansible_delegate_code.png?raw=true "ansible delegate playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_delegate.yml

```

![Alt text](images/003_ansible_delegate_playbook_run.png?raw=true "ansible delegate playbook run")
