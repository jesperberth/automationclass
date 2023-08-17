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

In

![vscode](/images/student-vscode.png)

Create a new file 01_webserver_azure.yml

Change the websiteauthor to your name

And change the __- hosts: tag_solution_webserver_jesbe__ so it matches your initials

```ansible
---
- name: Configure Webserver
  hosts: tag_solution_webserver_jesbe
  become: true
  vars:
    websiteheader: "Ansible Playbook"
    websiteauthor: "Jesper Berth"

  tasks:
    - name: Install Apache
      ansible.builtin.dnf:
        name: httpd
        state: present

    - name: Enable Apache
      ansible.builtin.systemd:
        name: httpd
        enabled: true
        state: started

    - name: Allow http in firewall
      ansible.posix.firewalld:
        service: http
        permanent: true
        state: enabled
        immediate: true
      notify:
        - Reload firewall

    - name: Add index.html
      ansible.builtin.template:
        src: index.html.j2
        dest: /var/www/html/index.html
        owner: root
        group: root
        mode: "0755"

  handlers:
    - name: Reload firewall
      ansible.builtin.service:
        name: firewalld
        state: reloaded

```

![Alt text](images/021_webserver_playbook.png?raw=true "azure install httpd playbook")

In VSCode create a new jinja file index.html.j2

```html
<html>
    <header>
        <title>{{ websiteheader }}</title></header>

        <body>
            <h1>Welcome to {{ websiteheader }}</h1>

            <h3>This site was created with Ansible by {{ websiteauthor }}

            <p>Hosted on {{ inventory_hostname }} running {{ ansible_facts['os_family'] }}<p>

        </body>
</html>
```

![Alt text](images/022_webserver_template.png?raw=true "azure template")

Save and commit to Git

On

![ansible](/images/ansible.png)

Pull the new playbook and run it with the dynamic inventory

__Type:__

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
