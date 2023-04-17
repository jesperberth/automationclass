---
title: Create Public Ip, NIC and Security Group in Azure
weight: 40
---

## Task 4 Create Public Ip, NIC and Security Group in Azure

[Ansible Module azure_rm_publicipaddress](https://docs.ansible.com/ansible/latest/modules/azure_rm_publicipaddress_module.html#azure-rm-publicipaddress-module)

[Ansible Module azure_rm_securitygroup](https://docs.ansible.com/ansible/latest/modules/azure_rm_securitygroup_module.html#azure-rm-securitygroup-module)

[Ansible Module azure_rm_networkinterface](https://docs.ansible.com/ansible/latest/modules/azure_rm_networkinterface_module.html#azure-rm-networkinterface-module)

In VSCode add the next sections to the 02_azure.yml playbook

```ansible

    - name: Create a public ip address for webserver
      azure_rm_publicipaddress:
        resource_group: "{{ resource_group }}"
        name: public_ip_webserver
        allocation_method: static
        domain_name: "webserver{{ domain_sub }}"
        tags:
            solution: "webserver_{{ user }}"
            delete: ansibletraining
      register: webserver_pub_ip

    - name: Create Security Group for webserver
      azure_rm_securitygroup:
        resource_group: "{{ resource_group }}"
        name: "webserver_securitygroup"
        purge_rules: true
        rules:
            - name: Allow_SSH
              protocol: Tcp
              destination_port_range: 22
              access: Allow
              priority: 100
              direction: Inbound
            - name: Allow_HTTP
              protocol: Tcp
              destination_port_range: 80
              access: Allow
              priority: 101
              direction: Inbound
        tags:
            solution: "webserver_{{ user }}"
            delete: ansibletraining

    - name: Create a network interface for webserver
      azure_rm_networkinterface:
        name: "webserver_nic01"
        resource_group: "{{ resource_group }}"
        virtual_network: "{{ virtual_network_name }}"
        subnet_name: "{{ subnet }}"
        security_group: "webserver_securitygroup"
        ip_configurations:
          - name: "webserver_nic01_ipconfig"
            public_ip_address_name: "public_ip_webserver"
            primary: True
        tags:
            solution: "webserver_{{ user }}"
            delete: ansibletraining

```

![Alt text](images/014_azure_network.png?raw=true "azure nic playbook")

Save and commit to Git

Log on to server "ansible" using ssh

Use git to get the new azure playbook

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 02_azure.yml

```

![Alt text](images/015_azure_network_run.png?raw=true "azure nic playbook run")

[Ansible Module azure_rm_virtualmachine](https://docs.ansible.com/ansible/latest/modules/azure_rm_virtualmachine_module.html#azure-rm-virtualmachine-module)

[Ansible Module shell](https://docs.ansible.com/ansible/latest/modules/shell_module.html#shell-module)

[ANsible Module Wait_for](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/wait_for_module.html)

Add the virtualmachine task to the 02_azure.yml playbook

In VSCode add the next sections to the 02_azure.yml playbook

```ansible

    - name: Create a VM webserver
      azure_rm_virtualmachine:
        resource_group: "{{ resource_group }}"
        name: "webserver"
        os_type: Linux
        admin_username: "{{ user }}"
        ssh_password_enabled: false
        ssh_public_keys:
          - path: "/home/{{ user }}/.ssh/authorized_keys"
            key_data: "{{ ssh_public_key }}"
        managed_disk_type: Standard_LRS
        state: present
        image:
          offer: RHEL
          publisher: RedHat
          sku: "8_4"
          version: latest
        vm_size: Standard_A1_v2
        network_interfaces: "webserver_nic01"
        tags:
            solution: "webserver_{{ user }}"
            delete: ansibletraining

    - name: Show webserver public ip
      debug:
        msg: "{{ webserver_pub_ip.state.ip_address }}"

    - name: Wait for ssh on webserver
      ansible.builtin.wait_for:
        host: "{{ webserver_pub_ip.state.ip_address }}"
        port: 22
        delay: 10
        timeout: 600

    - name: Add webserver to ssh known_hosts
      shell: "ssh-keyscan -t ecdsa {{ webserver_pub_ip.state.ip_address }}  >> /home/{{ user }}/.ssh/known_hosts"

```

![Alt text](images/016_azure_vm.png?raw=true "azure vm playbook")

Save and commit to Git

Log on to server "ansible" using ssh

Use git to get the new azure playbook

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 02_azure.yml

```

![Alt text](images/017_azure_vm_run.png?raw=true "azure vm playbook run")

The new webserver is now deployed in Azure and we are able to ssh keyless to the webserver
