---
title: Create Network in Azure
weight: 30
---

## Task 3 Create Network in Azure

[Ansible Module azure_rm_virtualnetwork](https://docs.ansible.com/ansible/latest/modules/azure_rm_virtualnetwork_module.html#azure-rm-virtualnetwork-module)

[Ansible Module azure_rm_subnet](https://docs.ansible.com/ansible/latest/modules/azure_rm_subnet_module.html#azure-rm-subnet-module)

In

![vscode](/images/student-vscode.png)

Create a new playbook file 02_azure.yml

add the following text to the file, change the first variable __"user"__ to your initials, use the same as in previous task, it will be used for creating resources and a login to the webserver

```ansible
---
- name: Azure Webserver
  hosts: localhost
  connection: local
  vars:
    user: write your username here
    location: northeurope
    virtual_network_name: "webserver_{{ user }}"
    subnet: Webserver
    resource_group: "webserver_{{ user }}"
    domain_sub: "domain{{ user }}"
    ssh_public_key: "{{lookup('file', '~/.ssh/id_rsa.pub') }}"

  tasks:
    - name: Create a virtual network
      azure.azcollection.azure_rm_virtualnetwork:
        resource_group: "{{ resource_group }}"
        name: "{{ virtual_network_name }}"
        address_prefixes_cidr: "10.99.0.0/16"
        tags:
            solution: "webserver_{{ user }}"
            delete: ansibletraining

    - name: Create a subnet
      azure.azcollection.azure_rm_subnet:
        resource_group: "{{ resource_group }}"
        virtual_network_name: "{{ virtual_network_name }}"
        name: "{{ subnet }}"
        address_prefix_cidr: "10.99.0.0/24"

```

![Alt text](images/012_azure_net_playbook.png?raw=true "azure net playbook")

Save and commit to Git

On

![ansible](/images/ansible.png)

Pull the new playbook and run it

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 02_azure.yml

```

![Alt text](images/013_azure_net_playbook_run.png?raw=true "azure net playbook run")
