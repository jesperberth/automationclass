---
title: Adding tasks to the playbook
weight: 40
---

## Task 4 Adding tasks to the playbook

In

![vscode](/images/student-vscode.png)

Lets add a second task in the playbook 01_linux.yml

In VSCode add the following text to the file

```ansible

  - name: Add line in file
    lineinfile:
      path: /root/testfile.txt
      line: Ansible was here...

```

![Alt text](images/024_secondtask_code.png?raw=true "Add second task to playbook")

Save the file

Ansible lint detects a new error, FCQN is missing again

Change __lineinfile:__ to __ansible.builtin.lineinfile:__

Notice that Git detects the changed file, do a commit add a comment "Second Edition" and Sync to Git

![Alt text](images/025_secondtask_commit.png?raw=true "Second Commit to playbook")

On

![ansible](/images/ansible.png)

Pull the updated git repository

__Type:__

```bash
git pull
```

![Alt text](images/026_git_pull.png?raw=true "git pull")

Run the playbook

__Type:__

```bash
ls

ansible-playbook 01_linux.yml --ask-become-pass
```

![Alt text](images/027_run_playbook_secondtask.png?raw=true "Run playbook")

Run the playbook again, the second task will become green as the line is already there, this is the idempotency

The "Create File" task will be changed every time as we use the touch command on the file

__Type:__

```bash
ansible-playbook 01_linux.yml --ask-become-pass
```

![Alt text](images/028_run_playbook_secondtask_idempodent.png?raw=true "Run playbook")
