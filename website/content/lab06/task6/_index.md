---
title: Tags
weight: 60
---

## Task 6 Tags

[Ansible Docs - Tags](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_tags.html)

With tag: we can enable or disable tagged tasks

In

![vscode](/images/student-vscode.png)

Open the file __01_vars.yml__

We will modify this to use tags

Add following to the __block:__ we created

```ansible
      tags:
        - install
        - config
```

![Alt text](images/001_tag1_playbook.png?raw=true "ansible tag playbook")

and this to the __Configure firewall__ task

```ansible
      tags:
        - firewall
        - config
```

Save, Commit and push

![Alt text](images/002_tag2_playbook.png?raw=true "ansible tag playbook")

and this to the __Is Httpd not started__ task

```ansible
      tags:
        - config
```

Save, Commit and push

![Alt text](images/003_tag3_playbook.png?raw=true "ansible tag playbook")

On

![ansible](/images/ansible.png)

Pull the playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 01_vars.yml --tags "firewall"

ansible-playbook 01_vars.yml --tags "config"

ansible-playbook 01_vars.yml --skip-tags "config"

```

![Alt text](images/003_tags_playbook_run_firewall.png?raw=true "ansible block playbook run")

![Alt text](images/004_tags_playbook_run_config.png?raw=true "ansible block playbook run")

![Alt text](images/005_tags_playbook_skip_tags.png?raw=true "ansible block playbook run")
