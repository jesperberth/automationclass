---
title: RestAPI
weight: 110
---

## Task 11 Rest API

[Ansible Docs - Rest API](https://docs.ansible.com/ansible-tower/latest/html/towerapi/)

AWX is Rest API based, every thing we do in the UI is a call to the API

We can work with AWX with out utilizing the UI, and call the Rest API directly

We have already created the OAUTH Token, we can use this to authenticate the API call

On Ansible

run the following to get a list of all Workflow Templates

```bash

curl -k -X GET -H "Authorization: Bearer $CONTROLLER_OAUTH_TOKEN" -H "Content-Type: application/json" $CONTROLLER_HOST/api/v2/workflow_job_templates/

```

![Alt text](images/01_runapi.png?raw=true "run rest api")

Output comes in JSON format, to ease the reading of the output add __| jq__

```bash

curl -s -k -X GET -H "Authorization: Bearer $CONTROLLER_OAUTH_TOKEN" -H "Content-Type: application/json" $CONTROLLER_HOST/api/v2/workflow_job_templates/ | jq

```

Take a look at the output

In the top look at __ID__ and __URL__

ID is the Workflow Templete ID

URL is the direct path to the Workflow

![Alt text](images/02_runapi_jq.png?raw=true "run rest api")

We can save the ID in a variable

```bash

ID=$(curl -s -k -X GET -H "Authorization: Bearer $CONTROLLER_OAUTH_TOKEN" -H "Content-Type: application/json" --data '{"limit" : "ansible"}' $CONTROLLER_HOST/api/v2/workflow_job_templates/ | jq -r '.results[].id')

echo $ID

```

![Alt text](images/03_runapi_jq_det_id.png?raw=true "run rest api")

Lets get the job with $ID

```bash

curl -s -k -X GET -H "Authorization: Bearer $CONTROLLER_OAUTH_TOKEN" -H "Content-Type: application/json" --data '{"limit" : "ansible"}' $CONTROLLER_HOST/api/v2/workflow_job_templates/$ID/ | jq

```

![Alt text](images/04_runapi_jq_with_id.png?raw=true "run rest api")

Now we will call the api with a POST method and launch the workflow template

```bash

curl -s -k -X POST -H "Authorization: Bearer $CONTROLLER_OAUTH_TOKEN" -H "Content-Type: application/json" --data '{ "extra_vars": {"websiteheader": "Ansible Rocks", "websiteauthor": "Ned Flanders"} }' $CONTROLLER_HOST/api/v2/workflow_job_templates/$ID/launch/

```

![Alt text](images/06_run_curl_post.png?raw=true "POST api")

In the AWX UI

In the left pane, click __Jobs__

Check the workflow job is running

![Alt text](images/07_workflow_running.png?raw=true "Workflow is running")

Go and check the website

![Alt text](images/08_website.png?raw=true "New Website")