---
title: Encryptet inventory
weight: 30
---

## Task 3 Encryptet inventory

In this task we will encrypt the password for the windows servers and place it in the new yaml inventory file

On

![ansible](/images/ansible.png)

Encrypt you password

__Type:__

```bash

ansible-vault encrypt_string 'SomeThingSimple8' --name ansible_password

```

![Alt text](images/040_ansible_vault_string.png?raw=true "Encrypt string")

Copy the string

![Alt text](images/041_ansible_vault_string_copy.png?raw=true "Encrypt string copy")

Paste the encryptet string into ansible-hosts.yml

When copied you might need to indent the lines with spaces so it placed under the first S in password, se the picture

```bash

cd

vi ansible-hosts.yml

Hit Esc-key

:set paste <Hit Enter>

Hit Esc-key

i (to toggle insert)

```

Save the inventory file

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](images/042_inventory_encrypt.png?raw=true "inventory encryptet string")

Lets do a test with win_ping

```bash

ansible windowsservers -m win_ping --ask-vault-pass

```

![Alt text](images/043_win_ping.png?raw=true "win ping")
