# Azure App Registration with gui

In your browser log on to [https://portal.azure.com](https://portal.azure.com)

In the left pane, click "Azure Active Directory" and "App Registrations"

In the top click "New registration"

![Alt text](pics/002_azure_app_registration.png?raw=true "new azure app")

Type a Name, Call it "ansible-yourname" so its possible to ID it later

Select the:

**Note:** The Tenant name will be different than AzureADFS

"Accounts in this organizational directory only (AzureADFS only - Single tenant)"

Should be default

Click Register

![Alt text](pics/003_azure_app_registration_name.png?raw=true "register azure app")

Copy the "Tenant ID" and "Client ID" save them in a text file for now

![Alt text](pics/004_azure_app_tenent_id.png?raw=true "get tenant id client id")

Click "Certificates & Secrets" and "New client secret"

![Alt text](pics/005_azure_app_client_secret.png?raw=true "new secret")

Copy the "Client Secret" save it in the text file

![Alt text](pics/006_azure_app_client_secret_value.png?raw=true "secret value")

We need to assign rights to the application

In the left pane go to "All Services"

In the right pane select "Subscribtions"

![Alt text](pics/006_azure_subscribtion.png?raw=true "secret value")

Select the Subscribtion, only one should be available

![Alt text](pics/006_azure_select_subscribtion.png?raw=true "secret value")

Click "Access Control IAM"

Click "Add" Select "Add role assignment"

Under "Role" select "Contributor"

In the Select box, search for the application name **ansible-userx**

Select your application and click Save

![Alt text](pics/007_azure_assign_rights.png?raw=true "azure role assignment")

Still in the Subscribtion pane, click the "Overview"

Copy the "Subscribtion ID" to the text file

![Alt text](pics/008_azure_sub_id.png?raw=true "azure sub id")

Go back to the lab

[Back to Lab 06](lab6.md)
