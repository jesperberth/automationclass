---
title: Create Webserver credential
weight: 70
---

## Task 7 Create Webserver credential

We need the __private__ ssh key from server ansible

Log on to server "ansible" using ssh

and retrive your public key

__Type:__

```bash

cd

cat ~/.ssh/id_rsa

```

Mark the key and copy it to the clipboard, you will need it when we create the next Job Template

![Alt text](images/16_ssh_key.png?raw=true "cat private key")

Create a new credential matching the webservers public key

Click on Credentials in the left pane

Click on Add to create a new credential

__Name:__ webserver

__Organization:__ Default

Credential Type: Machine

__Username:__ __jesbe__ <---- Change to your initials

__SSH Private Key:__ --- the key you copied ---

Leave the rest as default and click __Save__

![Alt text](images/17_create_ssh_cred.png?raw=true "create cred")
