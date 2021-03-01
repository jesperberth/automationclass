# Lab 4: Ansible Lint

Install and run ansible-lint on playbooks

## Prepare

We will need the servers, ansible to be up and running - by default it is started after creation

## Task 1: Install Ansible Lint

[Ansible Docs - ansible-lint](https://ansible-lint.readthedocs.io/en/latest/)

Log on to server "ansible" using ssh

We need to install ansible-lint using pip

__Type:__

```bash
pip install "ansible-lint[community,yamllint]"
```

![Alt text](pics/001_install_ansible_lint.png?raw=true "install ansible lint")

## Task 2: Run ansible-lint

Lets test our playbooks

__Type:__

```bash
cd

cd ansibleclass

ansible-lint

```

![Alt text](pics/002_run_ansible_lint.png?raw=true "run ansible lint")

Lets take a look on the last three errors - all on 02_loop.yml

* The first in line 3: is a true/false it could be with a capital letter or yes/no (whitch works)

* The Second in line 17: missing space before and after in var

* The third in line 25: missing a new line in the end of document

Change the errors in VSCode

![Alt text](pics/003_ansible_lint_correct.png?raw=true "ansible lint corrections")

Save, Commit and push

on server ansible

__Type:__

```bash
git pull

ansible-lint

```

![Alt text](pics/004_ansible_lint_second.png?raw=true "ansible lint second runs")


Lab done

[Ansible Roles](../lab05/lab5.md)