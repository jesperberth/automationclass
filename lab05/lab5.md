# Lesson 05: Network

In this session we configure a Fortigate firewall with address objects, vlan interface and firewall policies

## Prepare

## Task 1: Prepare ansibleserver

Logon to ansibleserver.ansible.local with ssh

Use your "userxx" account and password

We need to install ansible and python modules for fortios

Until ansible 2.9 is released, we need to use devel version

``` bash
pip3 install git+https://github.com/ansible/ansible.git@devel --user
pip3 install fortiosapi --user

```
