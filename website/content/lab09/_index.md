---
title: "Ansible Cloud"
weight: 90
chapter: false
pre: "<b>Lab 9. </b>"
---

In this session we will use ansible to setup and manage resources in Azure to deploy a virtual machine with a webserver installed and running

## Table of Contents

- [Prepare](#prepare)
- [Task 1 Install requirements for Azure](#task-1-install-requirements-for-azure)
- [Task 2 Create credentials for Azure](#task-2-create-credentials-for-azure)
- [Task 3 Create Network in Azure](#task-3-create-network-in-azure)
- [Task 4 Create Public Ip, NIC and Security Group in Azure](#task-4-create-public-ip-nic-and-security-group-in-azure)
- [Task 5 Create an ansible dynamic inventory for Azure RM](#task-5-create-an-ansible-dynamic-inventory-for-azure-rm)
- [Task 6 Install Apache Webserver and create the site - using ansible Azure dynamic inventory](#task-6-install-apache-webserver-and-create-the-site---using-ansible-azure-dynamic-inventory)
- [Task 7 Delete Resource Group Webserver](#task-7-delete-resource-group-Webserver)

## Prepare

We will need the server, ansible to be up and running - by default they are started after creation
