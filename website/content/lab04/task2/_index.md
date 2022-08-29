---
title: Register and Conditions
weight: 20
---

## Task 2 Register and Conditions

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

![Alt text](images/001_register_playbook.png?raw=true "ansible register in playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_vars.yml --ask-become-pass

```

![Alt text](images/002_register_playbook_run.png?raw=true "ansible register in playbook run")

The status from systemd contains alot of information, scroll to the top to see that the httpd service is now enabled and running

![Alt text](images/003_register_playbook_status.png?raw=true "ansible register in playbook status")

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

![Alt text](images/004_conditional_playbook.png?raw=true "ansible conditional in playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_vars.yml --ask-become-pass

```

![Alt text](images/005_conditional_playbook_run.png?raw=true "ansible conditional in playbook run")
