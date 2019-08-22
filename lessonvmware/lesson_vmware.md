# Lesson xx: Ansible VMware

In this session we will use ansible to manage a vmware esxi host, adding NFS storage, PortGroup to a virtual switch

## Prepare

``` bash


```

## Task 1: Add NFS storage to ESXi host

[Ansible VMware Datastore](https://docs.ansible.com/ansible/latest/modules/vmware_host_datastore_module.html#vmware-host-datastore-module)

__Type:__

```bash
vi add_nfs_to_vmware.yml

i for insert

---
- hosts: localhost
  vars:
    hostname: 192.168.130.242
    username: userx
    password: password
    nfs_user: NFS_userx
  tasks:
  - name: Add NFS Storage ESXi
    vmware_host_datastore:
      hostname: "{{ hostname }}"
      username: "{{ username }}"
      password: "{{ password }}"
      esxi_hostname: esxi.arrowdemo.local
      datastore_name: "{{ nfs_user }}"
      datastore_type: nfs
      nfs_server: 192.168.130.251
      nfs_path: "/storage/{{ user }}"
      nfs_ro: no
      state: present
      validate_certs: False
    delegate_to: localhost

```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

## Task 2: Add Network portgroup to ESXi host

__Type:__

```bash
vi add_portgroup_to_vmware.yml

i for insert

---
- hosts: localhost
  vars:
    hostname: 192.168.130.242
    username: userx
    password: password
    portgroup_name: vlan101
    vlan_id: 101
  tasks:
  - name: Add a PortGroup to VMware vSwitch
    vmware_portgroup:
      hostname: "{{ hostname }}"
      username: "{{ username }}"
      password: "{{ password }}"
      validate_certs: False
      switch_name: user_vswitch
      esxi_hostname: esxi.arrowdemo.local
      portgroup_name: "{{ portgroup_name }}"
      vlan_id: "{{ vlan_id }}"
    delegate_to: localhost

```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

## Task 3: Add a VM to ESXi host

[Ansible Vmware Guest](https://docs.ansible.com/ansible/latest/modules/vmware_guest_module.html#vmware-guest-module)