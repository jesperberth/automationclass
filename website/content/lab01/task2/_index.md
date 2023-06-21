---
title: Connect to Student
weight: 20
---


## Task 2 Connect to Student

Log on to your workstation __student__ using rdp

On the Azure portal click Virtual Machines

![Alt text](images/000_azure_portal.png?raw=true "Azure Portal")

Select your Resource Group, it's named __ansible-initials__

![Alt text](images/000_azure_portal_resourcegroup.png?raw=true "Azure Portal")

Click on the student vm

![Alt text](images/000_azure_portal_vm.png?raw=true "Azure Portal VMs")

Get the ansible servers external ip, click on the "Copy to ClipBoard"

![Alt text](images/000_azure_portal_vm_ip.png?raw=true "Azure Portal VM ip")

Start a Remote Desktop Client (On windows run __mstsc__) paste the public IP and connect

![Alt text](images/000_azure_portal_vm_mstsc.png?raw=true "mstsc")

Click "More choises" type your username/initials and password click __Ok__

![Alt text](images/000_azure_portal_vm_mstsc_login.png?raw=true "mstsc login")

Select the "Don't ask me again for connections to this computer and click __Yes__

![Alt text](images/000_azure_portal_vm_mstsc_login_yes.png?raw=true "mstsc login")

On the student vm click __Accept__

![Alt text](images/000_student_accept.png?raw=true "Student accept")
