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

Use git to get the playbook

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
      switch_name: "vSwitch0"
      esxi_hostname: "{{ esxihostname }}"
      portgroup_name: "{{ portgroup_name }}"
      vlan_id: "{{ vlan_id }}"
    delegate_to: localhost

```

![Alt text](pics/04_add_portgroup_to_vmware.png?raw=true "portgroup playbook")

Save and commit to Git

Log on to server "ansibleserver.ansible.local" using ssh

Use git to get the playbook

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

```ansible

  - name: Clone fedora 30 to userxx webserver
    vmware_guest:
      hostname: "{{ hostname }}"
      username: "{{ username }}"
      password: "{{ password }}"
      validate_certs: "False"
      name: "webserver_{{ nfs_user }}"
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
        datastore: "datastore_{{ nfs_user }}"
      networks:
      - name: "{{ portgroup_name }}"
      wait_for_ip_address: "yes"
    register: "webserver_{{ nfs_user }}"

```

![Alt text](pics/07_add_vm.png?raw=true "add vm playbook")

Save and commit to Git

Log on to server "ansibleserver.ansible.local" using ssh

Use git to get the playbook

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

## Task 4: Configure webserver

[Ansible Module user](https://docs.ansible.com/ansible/latest/modules/user_module.html)

[Ansible Module set_fact](https://docs.ansible.com/ansible/latest/modules/set_fact_module.html)

[Ansible Module debug](https://docs.ansible.com/ansible/latest/modules/debug_module.html)

[Ansible Module add_host](https://docs.ansible.com/ansible/latest/modules/add_host_module.html?highlight=add_host)

[Ansible Module shell](https://docs.ansible.com/ansible/latest/modules/shell_module.html?highlight=shell)

[Ansible Module dnf](https://docs.ansible.com/ansible/latest/modules/dnf_module.html)

[Ansible Module systemd](https://docs.ansible.com/ansible/latest/modules/systemd_module.html)

[Ansible Module firewalld](https://docs.ansible.com/ansible/latest/modules/firewalld_module.html)

[Ansible Module template](https://docs.ansible.com/ansible/latest/modules/template_module.html)

In VSCode

add below task to the file 01_vmware.yml

```ansible
# Prepare ansible for webserver
   - name: Generate SSH keys
     user:
       name: "{{ ansible_user_id }}"
       generate_ssh_key: yes
       ssh_key_bits: 2048
       ssh_key_file: .ssh/id_rsa

   - name: IP address info webserver
     debug:
       msg: "{{ webserver.instance.ipv4 }}"

   - name: Set Fact webserver_ip_fact
     set_fact:
      webserver_ip_fact: "{{ webserver.instance.ipv4 }}"

   - name: IP address info
     debug:
       msg: "{{ webserver_ip_fact }}"

   - name: add webserver to ansible in memory host file
     add_host:
      name: "{{ webserver_ip_fact }}"
      groups: webserver

   - name: Copy SSH ID
     shell: |
      ssh-copy-id "root@{{ webserver_ip_fact }}"

-  hosts: webserver
   remote_user: "root"
   become: "yes"
   vars:
     ansible_python_interpreter: /usr/bin/python3
     websiteheader: "Ansible Playbook in vmware"
     websiteauthor: "Ansible trainee"
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

![Alt text](pics/10_configure_vm.png?raw=true "configure vm playbook")

Save and commit to Git

Log on to server "ansibleserver.ansible.local" using ssh

Use git to get the playbook

__Type:__

```bash
cd ansibleclass

git pull

ansible-playbook 01_vmware.yml

```

![Alt text](pics/11_configure_vm_run.png?raw=true "configure vm playbook run")

Check the result in a browser

```code
http://<your webserver ip>
```

![Alt text](pics/12_website.png?raw=true "website")
