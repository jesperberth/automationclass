# Lab 9: Ansible Exercise

In this session we will use ansible to create some scenarios

## Task 1: Active Directory

Use the servers in Azure to create a new domain controller on server3 and domain join server4 to the new domain

Following modules are needed

[Ansible module win_feature](https://docs.ansible.com/ansible/latest/modules/win_feature_module.html)

[Ansible module win_domain](https://docs.ansible.com/ansible/latest/modules/win_domain_module.html)

[Ansible module win_reboot](https://docs.ansible.com/ansible/latest/modules/win_reboot_module.html)

[Ansible module win_domian_membership](https://docs.ansible.com/ansible/latest/modules/win_domain_membership_module.html)

You need to change the Azure Network DNS from Azure managed to the ip of your new domain controller before trying to join server4 to the domain.

[Ansible module Azure_rm_virtualnetwork](https://docs.ansible.com/ansible/latest/modules/azure_rm_virtualnetwork_module.html)

Look for the dns_servers

## Task 2: Load balanced webserver Azure

Create a new website in azure, with two Red Hat linux servers, an Azure loadbalancer and The Tomato Monkey website running

[Tomato Monkey Git repo](https://github.com/jesperberth/tomato-monkey)

[Ansible module Azure_rm_virtualnetwork](https://docs.ansible.com/ansible/latest/modules/azure_rm_virtualnetwork_module.html)

[Ansible module azure_rm_loadbalancer](https://docs.ansible.com/ansible/latest/modules/azure_rm_loadbalancer_module.html)
