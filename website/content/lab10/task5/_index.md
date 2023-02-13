---
title: Create Azure Webserver template
weight: 50
---

## Task 5 Create Azure Webserver template

In VSCode

Create a copy of 02_azure.yml -> 02_azure_tower.yml

Change the variable user: - so it matches the variable in the 01_azure_tower.yml

to __your initials eg. "jesbe"__

Remove the following lines from the playbook:

First line is under the vars section

```bash
ssh_public_key: "{{lookup('file', '~/.ssh/id_rsa.pub') }}"
```

and __Remove__ the two last lines in the playbook

```bash

  - name: Add webserver to ssh known_hosts
    shell: "ssh-keyscan -t ecdsa {{ webserver_pub_ip.state.ip_address }}  >> /home/{{ user }}/.ssh/known_hosts"
```

Save and Commit

![Alt text](images/10_ansible_tower_playbook_webserver.png?raw=true "Tower playbook")

In Tower go to project and __refresh__ your project, this will do a "git pull"

![Alt text](images/07_ansible_tower_refresh.png?raw=true "Refresh project")

We need the public ssh key from server ansible

Log on to server "ansible" using ssh

and retrive your public key

__Type:__

```bash

cd

cat ~/.ssh/id_rsa.pub

```

Mark the key and copy it to the clipboard, you will need it when we create the next Job Template

![Alt text](images/08_cat_public_key.png?raw=true "cat public key")

Back in the Tower UI

In the left pane, click __Templates__

Click on __Add__ to create a new Template select the __Job template__ type

Type

__Name:__ webserver

__Job Type:__ Run

__Inventory:__ Select Inventory

__Project:__ Select Project

__Playbook:__ 02_azure_tower.yml

__Credentials:__ Select credential type "Microsoft Azure Resource Manager" and Azure Credential

__In the Extra Vars:__ add the ssh_public_key make sure you have " __before__ and __after__ the key

```bash
---
ssh_public_key: "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCl/myugJcFI/2XmWcLd5P+tKVtbsGf83G/POHH3vc4p3fyLaGKUqaX8YBOLohJ5XFB9t25Tg8wZleCsbDm0s081jx4tdvudRhdqUMbA+n3oHRB3SHD7BLm7d13VgGlM6SCxnkIgrePFaSWsX+J5kk3rhxpo0LEEiGDgTdUDYz3wNypEBsal+eoFp1WHXArnkbl6FkEhOC8iZSJY2KKsJlv6xFXN1NlM/KWkgFdlB+tWps49Cl44IAMHgcjku+Xx+00trgWX89isK54MHWUXHTTPzOykaagLQXcwZZmZvy/84qdDBcRhehSwg7LxHAMjFEYCSpAE78AWoBNpB3lhR0r jesbe@ansible"

```

![Alt text](images/11_ansible_tower_webserver_template_pubkey.png?raw=true "template")

Leave the rest as default and click __Save__

![Alt text](images/11_ansible_tower_webserver_template.png?raw=true "template")

In the left pane click on __Templates__

Locate your webserver template and click on the __Rocket__ to lauch it

![Alt text](images/12_launch_template.png?raw=true "launch template")

Wait for template to finish

![Alt text](images/13_launch_template_run.png?raw=true "launch template")
