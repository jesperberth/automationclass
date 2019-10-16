# Windows Server with Certificate

## Task 4: Connect Windows Host

Connect to server3 using RDP, you can get the link in the Azure Portal

User name is __username__ as entered when we created the lab environement

We need to enable Windows Remote Management on the server

Start a powershell console with elevated rights (Run As Administrator) and run the following commands

__Type:__

```powershell
$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

powershell.exe -ExecutionPolicy ByPass -File $file
```

![Alt text](pics/018_enable_winrm.png?raw=true "enable winRm")

Lets add the windows server to our ansible hosts file

Log on to server "ansible" using ssh

We need to install pywinrm before being able to connect to windows servers from ansible

__Type:__

```bash
pip3 install pywinrm --user
```

![Alt text](pics/019_install_pywinrm.png?raw=true "enable winRm")

Yes the password is in clear text, we will look into this later

__Note:__

Change ansible_user and ansible_password to your username and password

__Type:__

```bash
vi ansible-hosts

i (for input)

[windowsservers]
server3

[windowsservers:vars]
ansible_user=jesbe
ansible_password=SomeThingSimple8
ansible_port=5986
ansible_connection=winrm
ansible_winrm_server_cert_validation=ignore
```

__Type:__

```bash
Hit Esc-key

:wq (: for a command w for write and q for quit vi)
```

![Alt text](pics/020_winrm_hostsfile.png?raw=true "hosts file winRm")

Lets test connection to the Windows server

__Type:__

```bash
ansible windowsservers -m win_ping
```

![Alt text](pics/021_ansible_win_ping.png?raw=true "win_ping")
