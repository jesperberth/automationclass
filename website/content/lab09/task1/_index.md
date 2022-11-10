---
title: Install requirements for Azure
weight: 10
---

## Task 1 Install requirements for Azure

Log on to server "ansible" using ssh

Install ansible azure collection

Before installtion the collection we need to install several python modules, the requirements file is on the github project page

[https://github.com/ansible-collections/azure](https://github.com/ansible-collections/azure)

**Type:**

```bash

cd

ansible-galaxy collection install azure.azcollection

pip install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt

```

![Alt text](images/002_download_requirements_pip_azure.png?raw=true "install azure")

![Alt text](images/002_run_requirements_pip_azure.png?raw=true "install azure")

![Alt text](images/001_install_pip_azure.png?raw=true "install azure")
