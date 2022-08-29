---
title: "Ansible Windows"
weight: 70
chapter: false
pre: "<b>Lab 7. </b>"
---

In this session we will use ansible to setup and manage Active Directory, add users and groups and join a second server to the domain.

Server3 will act as Domain controller, server4 will join as a member

## Table of Contents

- [Prepare](#prepare)
- [Task 1 Task 1 Add new host groups](#task-1-add-new-host-groups)
- [Task 2 Create Domain controller](#task-2-create-domain-controller)
- [Task 3 Create user and group](#task-3-create-user-and-group)
- [Task 4 Change DNS for Domainmember](#task-4-change-dns-for-domainmember)
- [Task 5 Add member server to AD](#task-5-add-member-server-to-ad)

## Prepare

We will need the servers, __ansible__, __server3__ and __server4__ to be up and running - by default they are started after creation
