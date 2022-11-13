---
title: Install Apache Webserver and create the site - using ansible Azure dynamic inventory
weight: 60
---

## Task 6 Install Apache Webserver and create the site - using ansible Azure dynamic inventory

Install apache webserver, setup the static website, allow http trafic on the local firewall

[Ansible Module dnf](https://docs.ansible.com/ansible/latest/modules/dnf_module.html)

[Ansible Module systemd](https://docs.ansible.com/ansible/latest/modules/systemd_module.html)

[Ansible Module firewalld](https://docs.ansible.com/ansible/latest/modules/firewalld_module.html)

[Ansible Module template](https://docs.ansible.com/ansible/latest/modules/template_module.html)

In VSCode create a new file 01_webserver_azure.yml

Change the websiteauthor to your name

And change the **- hosts: tag_solution_webserver_jesbe** so it matches your initials

```ansible
---
- hosts: tag_solution_webserver_jesbe
  become: yes
  vars:
    websiteheader: "Ansible Playbook"
    websiteauthor: "Jesper Berth"
  tasks:
  - name: Install Apache
    dnf:
      name: httpd
      state: latest

  - name: Enable Apache
    systemd:
      name: httpd
      enabled: yes
      state: started

  - name: Allow http in firewall
    firewalld:
      service: http
      permanent: true
      state: enabled
      immediate: yes
    notify:
      - reload firewall

  - name: Add index.html
    template:
      src: index.html.j2
      dest: /var/www/html/index.html
      owner: root
      group: root

  handlers:
  - name: reload firewall
    service:
      name: firewalld
      state: reloaded
```

![Alt text](images/021_webserver_playbook.png?raw=true "azure install httpd playbook")

In VSCode create a new jinja file index.html.j2

```html
<html>
<header><title>{{ websiteheader }}</title></header>
<body>
<h1>Welcome to {{ websiteheader }}</h1>

<h3>This site was created with Ansible by {{ websiteauthor }}

</body>
</html>
```

![Alt text](images/022_webserver_template.png?raw=true "azure template")

Save and commit to Git

Log on to server "ansible" using ssh

Use git to get the new azure playbook

Run the new playbook with the dynamic inventory

**Type:**

```bash

cd ansibleclass

git pull

ansible-playbook 01_webserver_azure.yml -i ./webserver.azure_rm.yml

```

![Alt text](images/023_webserver_run.png?raw=true "webserver playbook run")

Check the result in a browser

```code
http://<your webserver ip>
```

![Alt text](images/024_webserver_site.png?raw=true "webserver site")