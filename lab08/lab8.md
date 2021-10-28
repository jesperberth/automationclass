# Lab 8: Ansible Cloud

In this session we will use ansible to setup and manage resources in Azure to deploy a virtual machine with a webserver installed and running

## Table of Contents

- [Prepare](#prepare)
- [Task 1 Install requirements for Azure](#task-1-install-requirements-for-azure)
- [Task 2 Create credentials for Azure](#task-2-create-credentials-for-azure)
- [Task 3 Create Network in Azure](#task-3-create-network-in-azure)
- [Task 4 Create Public Ip, NIC and Security Group in Azure](#task-4-create-public-ip-nic-and-security-group-in-azure)
- [Task 5 Create an ansible dynamic inventory for Azure RM](#task-5-create-an-ansible-dynamic-inventory-for-azure-rm)
- [Task 6 Install Apache Webserver and create the site - using ansible Azure dynamic inventory](#task-6-install-apache-webserver-and-create-the-site---using-ansible-azure-dynamic-inventory)

## Prepare

We will need the server, ansible to be up and running - by default they are started after creation

## Task 1 Install requirements for Azure

Log on to server "ansible" using ssh

Install ansible azure collection

Before installtion the collection we need to install several python modules, the requirements file is on the github project page

[https://github.com/ansible-collections/azure](https://github.com/ansible-collections/azure)

**Type:**

```bash
cd

wget https://raw.githubusercontent.com/ansible-collections/azure/dev/requirements-azure.txt

pip install -r requirements-azure.txt

ansible-galaxy collection install azure.azcollection

```

![Alt text](pics/002_download_requirements_pip_azure.png?raw=true "install azure")

![Alt text](pics/002_run_requirements_pip_azure.png?raw=true "install azure")

![Alt text](pics/001_install_pip_azure.png?raw=true "install azure")

## Task 2 Create credentials for Azure

We need to register an azure application to enable ansible automation

You can do it in the Cloud Shell thats our __preferred__ method or __OPTIONAL__ you can do it using the gui in the browser [Azure GUI](azure_gui.md)

In your browser log on to [https://portal.azure.com](https://portal.azure.com)

In the top bar, click the "cloudshell" icon marked with red

![Alt text](pics/01_start_cloud_shell.png?raw=true "Cloud Shell")

Select "Bash"

![Alt text](pics/02_start_cloud_shell_bash.png?raw=true "Cloud Shell")

Run the following command to create a new Service User

Set the user variable to your initials

```bash

USER=jesbe

az ad sp create-for-rbac --name ansible-$USER --role Contributor

```

Copy the JSON output to a notepad file we will need the information later

![Alt text](pics/02_create_sp.png?raw=true "Cloud Shell output")

We need to get the Subscription ID run the following in the Cloud Shell

```bash

az account show

```

![Alt text](pics/03_get_sub_id.png?raw=true "Cloud Shell sub id")

Copy the line id: "xxx-xxx" to the same notepad

__Below is for both command and GUI__ versions

Log on to server "ansible" using ssh

We will create the authentication file, you must start in your home dir

**Type:**

```bash
cd
mkdir .azure
vi .azure/credentials

```

![Alt text](pics/009_azure_credfile.png?raw=true "azure credentials")

In vi **type:**

Use the vaules you collected from the Azure portal

```bash
i (to toggle input)
```

```bash
[default]
subscription_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
client_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
secret=xxxxxxxxxxxxxxxxx
tenant=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

```bash

In the file 

subscription_id = id from the last command

client_id = appID in the first command

secret = Password in the first command

tenant = tenant in the first command

```

**Type:**

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](pics/010_azure_credfile_input.png?raw=true "azure credentials file input")

Lets test the connection to azure by creating a small playbook

[Ansible Module azure_rm_resourcegroup](https://docs.ansible.com/ansible/latest/modules/azure_rm_resourcegroup_module.html#azure-rm-resourcegroup-module)

In VSCode

create a new playbook file 01_azure.yml

add the following text to the file, change the name of the variable **user to your initials** use the same as you use to login to ansible server

```ansible
---
- hosts: localhost
  connection: local
  vars:
    user: write your username here
  tasks:
  - name: Create resource group
    azure_rm_resourcegroup:
      name: "webserver_{{ user }}"
      location: northeurope
      tags:
          solution: "webserver_{{ user }}"
          delete: ansibletraining
    register: rg
  - debug:
      var: rg
```

![Alt text](pics/011_azure_play.png?raw=true "azure play")

Log on to server "ansible" using ssh

Use git to get the new azure playbook

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 01_azure.yml

```

![Alt text](pics/011_azure_play_run.png?raw=true "azure play run")

## Task 3 Create Network in Azure

[Ansible Module azure_rm_virtualnetwork](https://docs.ansible.com/ansible/latest/modules/azure_rm_virtualnetwork_module.html#azure-rm-virtualnetwork-module)

[Ansible Module azure_rm_subnet](https://docs.ansible.com/ansible/latest/modules/azure_rm_subnet_module.html#azure-rm-subnet-module)

In VSCode

create a new playbook file 02_azure.yml

add the following text to the file, change the first variable **"user"** to your initials, use the same as in previous task, it will be used for creating resources and a login to the webserver

```ansible
---
- hosts: localhost
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
    azure_rm_virtualnetwork:
      resource_group: "{{ resource_group }}"
      name: "{{ virtual_network_name }}"
      address_prefixes_cidr: "10.99.0.0/16"
      tags:
          solution: "webserver_{{ user }}"
          delete: ansibletraining

  - name: Create a subnet
    azure_rm_subnet:
      resource_group: "{{ resource_group }}"
      virtual_network_name: "{{ virtual_network_name }}"
      name: "{{ subnet }}"
      address_prefix_cidr: "10.99.0.0/24"
```

![Alt text](pics/012_azure_net_playbook.png?raw=true "azure net playbook")

Save and commit to Git

Log on to server "ansible" using ssh

Use git to get the new azure playbook

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 02_azure.yml

```

![Alt text](pics/013_azure_net_playbook_run.png?raw=true "azure net playbook run")

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
      purge_rules: yes
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

![Alt text](pics/014_azure_network.png?raw=true "azure nic playbook")

Save and commit to Git

Log on to server "ansible" using ssh

Use git to get the new azure playbook

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 02_azure.yml

```

![Alt text](pics/015_azure_network_run.png?raw=true "azure nic playbook run")

[Ansible Module azure_rm_virtualmachine](https://docs.ansible.com/ansible/latest/modules/azure_rm_virtualmachine_module.html#azure-rm-virtualmachine-module)

[Ansible Module shell](https://docs.ansible.com/ansible/latest/modules/shell_module.html#shell-module)

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

  - name: Add webserver to ssh known_hosts
    shell: "ssh-keyscan -t ecdsa {{ webserver_pub_ip.state.ip_address }}  >> /home/{{ user }}/.ssh/known_hosts"

```

![Alt text](pics/016_azure_vm.png?raw=true "azure vm playbook")

Save and commit to Git

Log on to server "ansible" using ssh

Use git to get the new azure playbook

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 02_azure.yml

```

![Alt text](pics/017_azure_vm_run.png?raw=true "azure vm playbook run")

The new webserver is now deployed in Azure and we are able to ssh keyless to the webserver

## Task 5 Create an ansible dynamic inventory for Azure RM

We can either add the webserver in the ansible-hosts file or use an Inventory plugin

The Azure Resource Manager inventory plugin is part of ansible and can return a dynamic inventory grouped on tags

[Azure Resource Manager inventory plugin](https://docs.ansible.com/ansible/latest/plugins/inventory/azure_rm.html)

In VSCode create a new file webserver.azure_rm.yml

Note: The inventory file must end with .azure_rm.yml

```ansible
plugin: azure_rm
auth_source: auto
include_vm_resource_groups:
 - '*'
keyed_groups:
 - prefix: tag
   key: tags

```

![Alt text](pics/018_azure_inventory.png?raw=true "vscode create inventory file")

Save and commit to Git

Log on to server "ansible" using ssh

Use git to get the new azure inventory

And run a test against Azure

**Type:**

```bash

cd ansibleclass

git pull

ansible-inventory -i ./webserver.azure_rm.yml --graph

ansible-inventory -i ./webserver.azure_rm.yml --list

```

![Alt text](pics/019_azure_inventory_run.png?raw=true "azure inventory run")

![Alt text](pics/020_azure_inventory_run_list.png?raw=true "azure inventory run list")

--list will give a lot more information, --graph will consolidate output in a more viewable way

If we add another server in the Resource Group it will be included in the inventory

## Task 6 Install Apache Webserver and create the site - using ansible Azure dynamic inventory

Install apache webserver, setup the static website, allow http trafic on the local firewall

[Ansible Module dnf](https://docs.ansible.com/ansible/latest/modules/dnf_module.html)

[Ansible Module systemd](https://docs.ansible.com/ansible/latest/modules/systemd_module.html)

[Ansible Module firewalld](https://docs.ansible.com/ansible/latest/modules/firewalld_module.html)

[Ansible Module template](https://docs.ansible.com/ansible/latest/modules/template_module.html)

In VSCode create a new file 01_webserver_azure.yml

Change the websiteauthor to your name

And change the **- hosts: tag_solution_webserver_jesbe** so it matches your initials

```ansible
---
- hosts: tag_solution_webserver_jesbe
  become: yes
  vars:
    websiteheader: "Ansible Playbook"
    websiteauthor: "Jesper Berth"
  tasks:
  - name: Install Apache
    dnf:
      name: httpd
      state: latest

  - name: Enable Apache
    systemd:
      name: httpd
      enabled: yes
      state: started

  - name: Allow http in firewall
    firewalld:
      service: http
      permanent: true
      state: enabled
      immediate: yes
    notify:
      - reload firewall

  - name: Add index.html
    template:
      src: index.html.j2
      dest: /var/www/html/index.html
      owner: root
      group: root

  handlers:
  - name: reload firewall
    service:
      name: firewalld
      state: reloaded
```

![Alt text](pics/021_webserver_playbook.png?raw=true "azure install httpd playbook")

In VSCode create a new jinja file index.html.j2

```html
<html>
<header><title>{{ websiteheader }}</title></header>
<body>
<h1>Welcome to {{ websiteheader }}</h1>

<h3>This site was created with Ansible by {{ websiteauthor }}

</body>
</html>
```

![Alt text](pics/022_webserver_template.png?raw=true "azure template")

Save and commit to Git

Log on to server "ansible" using ssh

Use git to get the new azure playbook

Run the new playbook with the dynamic inventory

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 01_webserver_azure.yml -i ./webserver.azure_rm.yml

```

![Alt text](pics/023_webserver_run.png?raw=true "webserver playbook run")

Check the result in a browser

```code
http://<your webserver ip>
```

![Alt text](pics/024_webserver_site.png?raw=true "webserver site")

Lab Done

[Ansible Tower](../lab09/lab9.md)
