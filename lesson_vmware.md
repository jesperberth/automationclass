# Lesson xx: Ansible VMware

In this session we will use ansible to manage a vmware esxi host, adding NFS storage, 

## Prepare


``` bash


```

## Task 1: Add NFS storage to ESXi host

```bash
vi add_nfs_to_vmware.yml

i for insert

---
- hosts: localhost
  vars:
    hostname: 192.168.130.242
    username: root
    password: password
    nfs_user: user1
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
      nfs_path: "/storage/{{ nfs_user }}"
      nfs_ro: no
      state: present
      validate_certs: False
    delegate_to: localhost

```

## Task 2: Add Network portgroup to ESXi host

```bash
vi add_portgroup_to_vmware.yml

i for insert

---
- hosts: localhost
  vars:
    hostname: 192.168.130.242
    username: root
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
