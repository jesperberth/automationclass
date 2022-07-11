# Automationclass with Ansible

Class material for Automation class

Part of the GitOps training path

Site is build with Hugo - static website builder

## Build website with Hugo

```bash

hugo -D

```

## Build Docker image

```bash

docker build -t website:latest .

docker run -d -p 80:80 website

```
