---
title: Block
weight: 50
---

## Task 5 Block

[Ansible Docs - Block](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_blocks.html)

With block: we can manage multiple tasks as one, and have a fallback task with rescue:

Open the file 01_vars.yml

We will modify this to use blocks

From __tasks:__ and the following 4 tasks

Install Packages, Enable httpd service, Show Status, Is httpd running

Change to the following code snippet

```ansible
  tasks:
    - name: Install and configure Webserver
      when: ansible_facts['distribution'] == 'RedHat'
      block:
        - name: Install Packages
          ansible.builtin.package:
            name: "{{ package }}"
            state: present

        - name: Enable httpd service
          ansible.builtin.systemd:
            name: httpd
            state: started
            enabled: true
          register: httpd_status

        - name: Show Status
          ansible.builtin.debug:
            var: httpd_status

        - name: Is httpd running
          ansible.builtin.debug:
            msg: httpd is running
          when: httpd_status.state == "started"

      rescue:
        - name: Print when errors
          ansible.builtin.debug:
            msg: 'There is an error in this block)'

      always:
        - name: Always do this
          ansible.builtin.debug:
            msg: "Will always run"

```

Save, Commit and push

![Alt text](images/001_add_block.png?raw=true "ansible block playbook")

On

![ansible](/images/ansible.png)

Pull the playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_vars.yml

```

![Alt text](images/002_run_block.png?raw=true "ansible block playbook run")
