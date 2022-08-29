---
title: Loops Async
weight: 60
---

## Task 6 Loops Async

[Ansible docs - async](https://docs.ansible.com/ansible/latest/user_guide/playbooks_async.html)

[Ansible docs - get_url module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/get_url_module.html)

Ansible run tasks synchronously, keeping the connection open while running every task in the playbook one by one.

In some cases if tasks take to long or there are to many long running tasks the connection can timeout, or you just want the playbook to run faster - we can use async on the tasks

In the following playbook the first task will use get_url to download two files on each host, run them async and register the result in a variable, the second task will loop though the results get the job id and monitor for a finished result.

Create a new file in Vscode 02_loop.yml

__Type:__

```ansible

---
- hosts: linuxservers
  become: yes

  tasks:
    - name: Create dir /mnt/resource/
      ansible.builtin.file:
        path: /mnt/resource/
        state: directory
        mode: '0755'

    - name: Download files
      ansible.builtin.get_url:
        url: "{{ item }}"
        dest: /mnt/resource/
      loop:
        - https://github.com/git-for-windows/git/releases/download/v2.30.0.windows.1/Git-2.30.0-64-bit.exe
        - https://www.python.org/ftp/python/3.8.7/python-3.8.7-embed-amd64.zip
      async: 3
      poll: 0
      register: download_loop

    - name: Wait for downloads
      async_status:
        jid: "{{item.ansible_job_id}}"
        mode: status
      retries: 300
      delay: 1
      loop: "{{ download_loop.results }}"
      register: async_loop_jobs
      until: async_loop_jobs.finished

```

Save, Commit and push

![Alt text](images/001_ansible_loop_async_playbook.png?raw=true "ansible loop async playbook")

On the ansible server pull the new playbook and run it

__Type:__

```bash
cd  ansibleclass

git pull

ansible-playbook 02_loop.yml --ask-become-pass

```

![Alt text](images/002_ansible_loop_async_playbook_run.png?raw=true "ansible loop async playbook run")
