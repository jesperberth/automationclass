# Prepare

Login to Azure Portal

You have recieved an email from Microsoft "You're invited to the Team Redhat organization"

Click on the "Get Started" button

![Alt text](pics/01_invite_mail.png?raw=true "Invitation")

On the Microsoft login screen select "Personal Account" and login with your email and password

![Alt text](pics/02_microsoft_login.png?raw=true "Login")

Accept the invitation from Team RedHat

![Alt text](pics/03_microsoft_accept.png?raw=true "Accept")



In Azure Cloud Shell(Bash)

Note:

You need to type the name of your allocated Azure Resource Group

Type a uniq name for your dns string ()

Username cannot be root/administrator

Password must meet complexity requirements, 3 of 4 types and minumum 12 characters

``` bash
cd clouddrive

git clone https://github.com/jesperberth/automationclass_setup/

cd automationclass_setup

cd azure_class_playbooks

ansible-playbook 00_azure_class_setup.yml
```
