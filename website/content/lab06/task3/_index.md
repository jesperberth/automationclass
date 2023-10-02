---
title: Task Delegation
weight: 30
---

## Task 3 Task Delegation

[Ansible Docs - Task Delgation](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_delegation.html)

[Ansible Docs - Command Module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/command_module.html)

Ansible always run gather facts and tasks on server nodes from the hosts variable in the playbook. With delegate_to we can force ansible to run a task on another server or on localhost.

This could be to set a server in or out off maintenance mode, add or remove a server to a loadbalancer.

In

![vscode](/images/student-vscode.png)

Create a new file __set_server_offline.sh__

__Type:__

```bash
#!/bin/bash

FILE="../offline.txt"
if [ ! -f "$FILE" ]; then
    touch $FILE
fi

echo $1 $2 >> $FILE

echo 0
```

![Alt text](images/001_bash_script.png?raw=true "bash script")

In

![vscode](/images/student-vscode.png)

Create a new file __01_delegate.yml__

```ansible
---
- name: Task Delegation
  hosts: linuxservers

  tasks:
    - name: Debug Facts Hostname
      ansible.builtin.debug:
        msg: "{{ ansible_facts['nodename'] }}"

    - name: Set x on set_server_offline.sh
      ansible.builtin.file:
        path: ~/ansibleclass/set_server_offline.sh
        state: touch
        mode: +x
      delegate_to: localhost

    - name: Write File
      ansible.builtin.command:
        cmd: ~/ansibleclass/set_server_offline.sh "{{ ansible_facts['nodename'] }}" "{{ ansible_facts['all_ipv4_addresses'][0] }}"
      register: output
      changed_when: output.rc == 0
      delegate_to: localhost

```

Save, Commit and push

![Alt text](images/002_ansible_delegate_code.png?raw=true "ansible delegate playbook")

On

![ansible](/images/ansible.png)

Pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_delegate.yml

```

![Alt text](images/003_ansible_delegate_playbook_run.png?raw=true "ansible delegate playbook run")

Take a look at the output file

__Type:__

```bash

cat ../offline.txt

```

![Alt text](images/004_delegate_playbook_run_cat.png?raw=true "ansible delegate playbook run cat offline.txt")
