# Lesson xx: Ansible Tower

In this session we will use Visual Studio Code and modules to work with ansible playbooks and create two playbooks, one for linux and one for windows

## Prepare

We need to start servers, ansible, server1 and server3

In Azure Cloud Shell(Bash)

``` bash
cd clouddrive
cd automationclass
cd azure_class_playbooks

ansible-playbook 0xx_azure_lessonxx_start.yml

```

## Task 1: Setup Visual Studio Code

```bash
wget https://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-latest.tar.gz

tar xvzf ansible-tower-setup-latest.tar.gz

cd ansible-tower-setup-<tower_version>
```

```bash
vi inventory

sudo ./setup.sh
```