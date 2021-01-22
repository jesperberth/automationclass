# Lab 6: Ansible Vmware

In this session we will use ansible to manage a vmware esxi host, adding NFS storage, create a virtual machine from template and install http inside the virtual machine.

We will use the present SOAP based SDK to manage Vmware and guests, and we will take a sneak peak on the new REST API based module which will replace the SOAP modules

## Login vmware lab

In your browser go to [https://vclass.dk](https://vclass.dk)

Username and password will be given by the instructor

![Alt text](pics/001_vclass_login.png?raw=true "vclass login")

Click Detect Receiver

![Alt text](pics/002_vclass_login_detect.png?raw=true "vclass login detect")

Click Open to Launch the Citrix Workspace Launcher

![Alt text](pics/003_vclass_login_open_plugin.png?raw=true "vclass login open plugin")

Start the Remote Desktop clientxxx

![Alt text](pics/004_vclass.png?raw=true "vclass")

You will get a Windows 10 Desktop with Windows Terminal and Google Chrome installed

![Alt text](pics/005_desktop.png?raw=true "desktop")

Launch the Windows Terminal you should be able to run ssh from it

![Alt text](pics/006_ssh.png?raw=true "ssh")

## Task 1: Prepare ansibleserver for vmware

Logon to ansible.ansible.local with ssh

Username is __"user"__

Create a new Python Virtualenv

We need to install the python modules for vmware for the SOAP SDK

Lets create a Python virtualenv for our ansible installation

__Type:__

```bash

virtualenv ansible

```

![Alt text](pics/003_create_virtualenv.png?raw=true "create virtualenv Ansible")

To activate our virtualenv ansible run the following

which python - is just to check that were using the correct python

__Type:__

```bash

source ansible/bin/activate

which python
```

Note: That when you are in a virtualenv, the name of the environment will be in the beginning of you command prompt like (ansible)

If you need to exit the virtualenv, you type "deactivate"

![Alt text](pics/003_activate_virtualenv.png?raw=true "active virtualenv Ansible")

__Type:__

```bash
pip install ansible
```

![Alt text](pics/003_install_ansible.png?raw=true "Install Ansible")

__Type:__

```bash

pip install pyvmomi

```

![Alt text](pics/00_install_pyvmomi.png?raw=true "install pyvmomi")

## Task 2: Add NFS storage to ESXi host

[Ansible VMware Datastore](https://docs.ansible.com/ansible/latest/modules/vmware_host_datastore_module.html#vmware-host-datastore-module)

First we will add a NFS share to our esxi host, the storage is exoported from our ansible server

In VSCode

create a new playbook file 01_vmware.yml and add below

```ansible
---
- hosts: localhost
  vars:
    hostname: "vcenter.ansible.local"
    esxihostname: "esxi.ansible.local"
    username: "administrator@vsphere.local"
    password: "Passw0rd!"
    nfs_user: "user"
    portgroup_name: "webserver"
    vlan_id: "1"

  tasks:
  - name: Add NFS Storage ESXi
    vmware_host_datastore:
      hostname: "{{ hostname }}"
      username: "{{ username }}"
      password: "{{ password }}"
      esxi_hostname: "{{ esxihostname }}"
      datastore_name: "datastore_{{ nfs_user }}"
      datastore_type: "nfs"
      nfs_server: "ansible.ansible.local"
      nfs_path: "/storage/{{ nfs_user }}"
      nfs_ro: "no"
      state: "present"
      validate_certs: "False"
    delegate_to: "localhost"
```

![Alt text](pics/01_add_nfs_to_vmware.png?raw=true "nfs playbook")

Save and commit to Git

Log on to server "ansible.ansible.local" using ssh

Use git to clone the repository

__Change__ to your own repo

__Type:__

```bash

git clone https://github.com/jesperberth/ansibleclass.git

cd ansibleclass

ansible-playbook 01_vmware.yml

```

![Alt text](pics/02_add_nfs_to_vmware_play.png?raw=true "nfs playbook run")

Open Vcenter in a browser [https://vcenter.ansible.local/ui](https://vcenter.ansible.local/ui)

Use administrator@vsphere.local and password

In the vmware webconsole check under storage that your nfs share is connected

![Alt text](pics/03_add_nfs_to_vmware_connect.png?raw=true "nfs vmware")

## Task 3: Add Network portgroup to ESXi host

[Ansible VMware PortGroup](https://docs.ansible.com/ansible/latest/modules/vmware_portgroup_module.html#vmware-portgroup-module)

In VSCode

add below task to the file 01_vmware.yml

```ansible
  - name: Add a PortGroup to VMware vSwitch
    vmware_portgroup:
      hostname: "{{ hostname }}"
      username: "{{ username }}"
      password: "{{ password }}"
      validate_certs: False
      switch_name: "vSwitch0"
      esxi_hostname: "{{ esxihostname }}"
      portgroup_name: "{{ portgroup_name }}"
    delegate_to: localhost

```

![Alt text](pics/04_add_portgroup_to_vmware.png?raw=true "portgroup playbook")

Save and commit to Git

Log on to server "ansible.ansible.local" using ssh

Use git to get the playbook

__Type:__

```bash
cd ansibleclass

git pull

ansible-playbook 01_vmware.yml

```

![Alt text](pics/05_add_portgroup_to_vmware_run.png?raw=true "portgroup playbook run")

Open Vcenter in a browser [vcenter.ansible.local](https://vcenter.ansible.local/ui)

Use your administrator@vsphere.local and password

 In the vmware webconsole check under networking/port groups that your vSwitch webserver is created

![Alt text](pics/06_add_portgroup_to_vmware_created.png?raw=true "portgroup vmware")

## Task 4: Add a VM to ESXi host

[Ansible Vmware Guest](https://docs.ansible.com/ansible/latest/modules/vmware_guest_module.html#vmware-guest-module)

In VSCode

add below task to the file 01_vmware.yml

```ansible
  - name: Clone Centos 8 to webserver
    vmware_guest:
      hostname: "{{ hostname }}"
      username: "{{ username }}"
      password: "{{ password }}"
      validate_certs: "False"
      name: "webserver"
      template: "Temp_Centos8"
      datacenter: "Datacenter"
      folder: "/"
      state: "poweredon"
      hardware:
        memory_mb: "1024"
        num_cpus: "1"
      disk:
      - size_gb: "16"
        type: "thin"
        datastore: "datastore1"
      - size_gb: "2"
        type: "thin"
        datastore: "datastore_{{ nfs_user }}"
      networks:
      - name: "{{ portgroup_name }}"
        connected: true
      wait_for_ip_address: "yes"
    register: "webserver"
```

![Alt text](pics/07_add_vm.png?raw=true "add vm playbook")

Save and commit to Git

Log on to server "ansible.ansible.local" using ssh

Use git to get the playbook

__Type:__

```bash
cd ansibleclass

git pull

ansible-playbook 01_vmware.yml

```

![Alt text](pics/08_add_vm_run.png?raw=true "add vm playbook run")

Open Vcenter in a browser [vcenter.ansible.local](https://vcenter.ansible.local/ui)

Use your administrator@vsphere.local and password

In the vmware webconsole check under virtual machines that your vm is created

![Alt text](pics/09_add_vm_vmware_created.png?raw=true "add vm in vmware")

## Task 5: Prepare ssh for webserver

[Ansible Module set_fact](https://docs.ansible.com/ansible/latest/modules/set_fact_module.html)

[Ansible Module debug](https://docs.ansible.com/ansible/latest/modules/debug_module.html)

[Ansible Module shell](https://docs.ansible.com/ansible/latest/modules/shell_module.html?highlight=shell)

In VSCode

add below task to the file 01_vmware.yml

```ansible

  - name: Set Fact webserver_ip_fact
    set_fact:
     webserver_ip_fact: "{{ webserver.instance.ipv4 }}"

  - name: IP address info
    debug:
      msg: "{{ webserver_ip_fact }}"

  - name: Add ansibleserver to ssh known_hosts
    shell: "ssh-keyscan -t ecdsa {{ webserver_ip_fact }}  >> /home/{{ ansible_user_id }}/.ssh/known_hosts"

```

![Alt text](pics/10_add_webserver_ssh.png?raw=true "add vm in vmware")

Save and commit to Git

Log on to server "ansible.ansible.local" using ssh

Use git to get the playbook

__Type:__

```bash
cd ansibleclass

git pull

ansible-playbook 01_vmware.yml

```

![Alt text](pics/11_add_webserver_ssh_run.png?raw=true "configure vm playbook run")

## Task 6: Configure Dynamic Inventory for Vmware

[Ansible Vmware Inventory](https://docs.ansible.com/ansible/latest/scenario_guides/vmware_scenarios/vmware_inventory.html)

In this task we will configure Dymanic Inventory for Vmware

To support tags in Vmware we need to install Vmware Automation SDK - this SDK is not OpenSource and cannot be in the pypi repo so we need to install from github

[Vmware Automation SDK](https://github.com/vmware/vsphere-automation-sdk-python#installing-required-python-packages)

Logon to ansible.ansible.local with ssh

Username "user" and password

__Type:__

```bash
cd

pip install --upgrade pip setuptools

pip install --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git

```

![Alt text](pics/12_install_vmware_sdk.png?raw=true "install vmware sdk")

Create the inventory file in your root directory, the inventory file must end with .vmware.yml

```bash
cd

vi webserver.vmware.yml

```

In vi __type:__ below

Change __username__

```bash
i (to toggle input)
```

```bash
plugin: community.vmware.vmware_vm_inventory
strict: False
hostname: "vcenter.ansible.local"
username: "administrator@vsphere.local"
password: "Passw0rd!"
validate_certs: False
with_tags: yes
hostnames:
- config.name
keyed_groups:
- key: 'tags'
  separator: ''
filters:
- summary.runtime.powerState == "poweredOn"
```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](pics/13_create_inventoryfile.png?raw=true "create inventory file")

Test the inventory

__type:__

```bash
cd

ansible-inventory -i webserver.vmware.yml --graph
```

![Alt text](pics/14_run_inventoryfile.png?raw=true "run inventory file")

Try change --graph to --list, the output will change

Alot more information is then available for each vm

The dynamic inventory module supports custom vmware tags

We need to add our own tag to our VM to use in the inventory

"tag_webserver"

[Ansible Module vmware_category](https://docs.ansible.com/ansible/latest/modules/vmware_category_module.html#vmware-category-module)

[Ansible Module vmware_tag](https://docs.ansible.com/ansible/latest/modules/vmware_tag_module.html)

[Ansible Module vmware_tag_manager](https://docs.ansible.com/ansible/latest/modules/vmware_tag_manager_module.html)

In VSCode

add below task to the file 01_vmware.yml

```ansible
  - name: Create a category
    vmware_category:
      hostname: "{{ hostname }}"
      username: "{{ username }}"
      password: "{{ password }}"
      validate_certs: no
      category_name: "ansible_managed"
      category_description: "Category for Ansible"
      category_cardinality: 'multiple'
      state: present
    register: category

  - name: Create a tag
    vmware_tag:
      hostname: "{{ hostname }}"
      username: "{{ username }}"
      password: "{{ password }}"
      validate_certs: no
      category_id: "{{ category.category_results.category_id }}"
      tag_name: "tag_webserver"
      tag_description: "Web Server"
      state: present
    delegate_to: localhost

  - name: Create a tag
    vmware_tag:
      hostname: "{{ hostname }}"
      username: "{{ username }}"
      password: "{{ password }}"
      validate_certs: no
      category_id: "{{ category.category_results.category_id }}"
      tag_name: "tag_dbserver"
      tag_description: "Database Server"
      state: present
    delegate_to: localhost

  - name: Add tags to webserver
    vmware_tag_manager:
      hostname: "{{ hostname }}"
      username: "{{ username }}"
      password: "{{ password }}"
      validate_certs: no
      tag_names:
        - "tag_webserver"
      object_name: "webserver"
      object_type: VirtualMachine
      state: add
    delegate_to: localhost

```

![Alt text](pics/15_add_tags.png?raw=true "add tags")

Save and commit to Git

Log on to server "ansible.ansible.local" using ssh

Use git to get the playbook

__Type:__

```bash
cd ansibleclass

git pull

ansible-playbook 01_vmware.yml

```

![Alt text](pics/16_add_tags_run.png?raw=true "add tags run")

Open Vcenter in a browser [vcenter.ansible.local](https://vcenter.ansible.local/ui)

Use your administrator@vsphere.local and password

Click on your vm and locate the Tags settings in the right pane

You should have a tag "tag_webserver"

![Alt text](pics/17_show_tag_in_vmware.png?raw=true "show tags")

Test your inventory again

__Type:__

```bash
cd

ansible-inventory -i webserver.vmware.yml --graph
```

Look for @tag_webserver

![Alt text](pics/18_show_tag_in_inventory.png?raw=true "show tags in inventory")

Lets test the tag before changing the webserver

__Type:__

```bash
cd

ansible -i webserver.vmware.yml tag_webserver -m ping -u user
```

![Alt text](pics/18_test_tag_inventory.png?raw=true "test tags in inventory")

## Task 7: Configure webserver

[Ansible Module dnf](https://docs.ansible.com/ansible/latest/modules/dnf_module.html)

[Ansible Module systemd](https://docs.ansible.com/ansible/latest/modules/systemd_module.html)

[Ansible Module firewalld](https://docs.ansible.com/ansible/latest/modules/firewalld_module.html)

[Ansible Module template](https://docs.ansible.com/ansible/latest/modules/template_module.html)

First we need to install the el_httpd role

```bash

ansible-galaxy install jesperberth.el_httpd

```

![Alt text](pics/20_install_role.png?raw=true "install role")

In VSCode

create a new playbook file 02_vmware.yml and add below


```ansible
---
- hosts: tag_webserver
  remote_user: "user"
  become: "yes"
  vars:
    websiteheader: "Ansible Playbook in vmware"
    websiteauthor: "Ansible trainee"

  roles:
  - jesperberth.el_httpd

  tasks:
  - name: Add index.html
    template:
      src: index.html.j2
      dest: /var/www/html/index.html
      owner: root
      group: root

```

![Alt text](pics/19_configure_webserver.png?raw=true "configure webserver playbook")

Save and commit to Git

Log on to server "ansible.ansible.local" using ssh

Use git to get the playbook

__Type:__

```bash
cd ansibleclass

git pull

ansible-playbook 02_vmware.yml -i ../webserver.vmware.yml --ask-become-pass

```

![Alt text](pics/20_configure_vm_run.png?raw=true "configure vm playbook run")

Check the result in a browser

```code
http://<your webserver ip>
```

![Alt text](pics/21_website.png?raw=true "website")

## Task 8: Use REST API to manage Vmware

[Vmware REST API](https://github.com/ansible-collections/vmware.vmware_rest)

First we need to install the vmware collection and one python module

```bash

ansible-galaxy collection install vmware.vmware_rest

pip install aiohttp

```

![Alt text](pics/22_install_collection.png?raw=true "install vmware collection")

Create a new file 03_vmware.yml

The vmware_rest module uses environment variables to define vmware user/password

```ansible

---
- hosts: localhost
  vars:

  vars_prompt:
    - name: password
      prompt: Password
      private: no

  environment:
    VMWARE_USER: administrator@vsphere.local
    VMWARE_HOST: vcenter.ansible.local
    VMWARE_VALIDATE_CERTS: no
    VMWARE_PASSWORD: "{{ password }}"

  tasks:
  - name: Collect the list of the existing VM
    vmware.vmware_rest.vcenter_vm_info:
    register: existing_vms
    until: existing_vms is not failed

  - name: Show All Vms
    debug:
      msg: "{{ existing_vms }}"

```

Save and Commit

![Alt text](pics/23_test_vmware_rest.png?raw=true "vmware rest collection")

Log on to server "ansible.ansible.local" using ssh

Use git to get the playbook

__Type:__

```bash
cd ansibleclass

git pull

ansible-playbook 03_vmware.yml

```

![Alt text](pics/24_test_vmware_rest_run.png?raw=true "vmware rest collection run")

Lab done

[Ansible Automation](../lab07/lab7.md)
