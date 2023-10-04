---
title: Run ansible command
weight: 20
---

## Task 2 Run ansible command

On

![ansible](/images/ansible.png)

We can see the ansible version and the python package versions installed

__Type:__

```bash
ansible --version

pip freeze

```

![Alt text](images/004_install_ansible_version.png?raw=true "Ansible --version")

--help Will give you other options for ansible command

__Type:__

```bash
ansible --help

```

![Alt text](images/004_ansible_help.png?raw=true "Ansible --help")

Run ansible against localhost with module ping

[Ansible Ping Module](https://docs.ansible.com/ansible/latest/modules/ping_module.html)

```bash
ansible localhost -m ping

```

![Alt text](images/005_install_ansible_localhost_ping.png?raw=true "Ansible localhost ping")

[Ansible File Module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/file_module.html)

__Type:__

```bash
ansible localhost -m file -a "path=/home/jesbe/testfile.txt state=touch"
```

change __jesbe__ with your username

The ansible command:

ansible __hosts__ -m __module__ -a __module arguments__

__hosts__ can be localhost or a group from the inventory file or all

__module__ any ansible module, here file

__module arguments__ arguments for module if needed, here path=/home/jesbe/testfile.txt and state=touch

![Alt text](images/006_install_ansible_localhost_file.png?raw=true "Ansible localhost ping")
