# Lab 3: Ansible Lint

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
