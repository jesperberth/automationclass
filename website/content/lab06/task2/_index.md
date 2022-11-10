---
title: Run ansible-lint
weight: 20
---

## Task 2 Run ansible-lint

Lets test our playbooks

__Type:__

```bash
cd

cd ansibleclass

ansible-lint

```

![Alt text](images/002_run_ansible_lint.png?raw=true "run ansible lint")

Lets take a look on the last three errors - all on 02_loop.yml

* The first in line 3: is a true/false it could be with a capital letter or yes/no (whitch works)

* The Second in line 25: missing space before and after in var

* The third in line 31: missing a new line in the end of document

Change the errors in VSCode

![Alt text](images/003_ansible_lint_correct.png?raw=true "ansible lint corrections")

Save, Commit and push

on server ansible

__Type:__

```bash
git pull

ansible-lint

```

![Alt text](images/004_ansible_lint_second.png?raw=true "ansible lint second runs")
