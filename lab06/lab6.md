# Lab 6: Ansible VMware

In this session we will use ansible to manage a vmware esxi host, adding NFS storage, PortGroup to a virtual switch a virtual machine from template and install http inside the virtual machine.

## Task 1: Install Ansible on ansible2.demo.local

Logon to ansibleserver.ansible.local with ssh

Use your "userxx" account and password

We need to install the python modules for vmware

__Type:__

```bash
pip3 install pyvmomi --user

ansible --version
```

![Alt text](pics/00_install_pyvmomi.png?raw=true "nfs playbook")

## Task 2: Add NFS storage to ESXi host

[Ansible VMware Datastore](https://docs.ansible.com/ansible/latest/modules/vmware_host_datastore_module.html#vmware-host-datastore-module)

In VSCode

create a new playbook file 01_vmware.yml and add below

Change "username", "nfs_user", "portgroup_name" and "vlan_id"

```ansible
---
- hosts: localhost
  vars:
    hostname: "vcenter.ansible.local"
    esxihostname: "esxi.ansible.local"
    username: "userxx@vsphere.local"
    password: "Password1!"
    nfs_user: "userxx"
    portgroup_name: "vlan10x"
    vlan_id: "10x"
  tasks:
  - name: Add NFS Storage ESXi
    vmware_host_datastore:
      hostname: "{{ hostname }}"
      username: "{{ username }}"
      password: "{{ password }}"
      esxi_hostname: "{{ esxihostname }}"
      datastore_name: "datastore_{{ nfs_user }}"
      datastore_type: "nfs"
      nfs_server: "storage.ansible.local"
      nfs_path: "/storage/{{ nfs_user }}"
      nfs_ro: "no"
      state: "present"
      validate_certs: "False"
    delegate_to: "localhost"
```

![Alt text](pics/01_add_nfs_to_vmware.png?raw=true "nfs playbook")

Save and commit to Git

Log on to server "ansibleserver.ansible.local" using ssh

Use git to get the new network playbook

__Type:__

```bash
cd ansibleclass

git pull

ansible-playbook 01_vmware.yml

```

![Alt text](pics/02_add_nfs_to_vmware_play.png?raw=true "nfs playbook run")

Open Vcenter in a browser [vcenter.ansible.local](https://vcenter.ansible.local)

Use your userxx@vsphere.local and password

In the vmware webconsole check under storage that your nfs share is connected

![Alt text](pics/03_add_nfs_to_vmware_connect.png?raw=true "nfs vmware")

## Task 2: Add Network portgroup to ESXi host

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
      switch_name: "VM Network"
      esxi_hostname: "{{ esxihostname }}"
      portgroup_name: "{{ portgroup_name }}"
      vlan_id: "{{ vlan_id }}"
    delegate_to: localhost

```

![Alt text](pics/04_add_portgroup_to_vmware.png?raw=true "portgroup playbook")

Save and commit to Git

Log on to server "ansibleserver.ansible.local" using ssh

Use git to get the new network playbook

__Type:__

```bash
cd ansibleclass

git pull

ansible-playbook 01_vmware.yml

```

![Alt text](pics/05_add_portgroup_to_vmware_run.png?raw=true "portgroup playbook run")

Open Vcenter in a browser [vcenter.ansible.local](https://vcenter.ansible.local)

Use your userxx@vsphere.local and password

In the vmware webconsole check under networking/port groups that your vlan is created

![Alt text](pics/06_add_portgroup_to_vmware_created.png?raw=true "nfs vmware")

## Task 3: Add a VM to ESXi host

[Ansible Vmware Guest](https://docs.ansible.com/ansible/latest/modules/vmware_guest_module.html#vmware-guest-module)

In VSCode

add below task to the file 01_vmware.yml

Change the following

- "name"
- "datastore"
- "name" on the second disk
- "name" for the network
- "register"

```ansible

  - name: Clone fedora 30 to userxx webserver
    vmware_guest:
      hostname: "{{ hostname }}"
      username: "{{ username }}"
      password: "{{ password }}"
      validate_certs: "False"
      name: "webserver_{{ nfsuser }}"
      template: "_TEMP_fedora30"
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
        datastore: "datastore_{{ nfsuser }}"
      networks:
      - name: "{{ portgroup_name }}"
      wait_for_ip_address: "yes"
    register: "webserver_{{ nfsuser }}"

```

![Alt text](pics/07_add_vm.png?raw=true "add vm playbook")

Save and commit to Git

Log on to server "ansibleserver.ansible.local" using ssh

Use git to get the new network playbook

__Type:__

```bash
cd ansibleclass

git pull

ansible-playbook 01_vmware.yml

```

![Alt text](pics/08_add_vm_run.png?raw=true "add vm playbook run")

Open Vcenter in a browser [vcenter.ansible.local](https://vcenter.ansible.local)

Use your userxx@vsphere.local and password

In the vmware webconsole check under virtual machines that your vm is created

![Alt text](pics/09_add_vm_vmware_created.png?raw=true "add vm in vmware")
