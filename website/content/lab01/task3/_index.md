---
title: Run ansible command
weight: 30
---

## Task 3 Run ansible command

Log on to server "ansible" using ssh

__Type:__

```bash
ansible --version
```

![Alt text](images/004_install_ansible_version.png?raw=true "Ansible --version")

__Type:__

```bash
ansible --help
```

Will give you other options for ansible command

[Ansible Ping Module](https://docs.ansible.com/ansible/latest/modules/ping_module.html)

```bash
ansible localhost -m ping
```

Will run ansible against localhost with module ping

![Alt text](images/005_install_ansible_localhost_ping.png?raw=true "Ansible localhost ping")

[Ansible File Module](https://docs.ansible.com/ansible/latest/modules/list_of_files_modules.html)

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
