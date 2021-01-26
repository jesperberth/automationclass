Enable ansible extention for our project folder

Create a new folder .vscode (the . is important)

![Alt text](pics/014_vscode_create_folder.png?raw=true "create .vscode")

In the new folder .vscode create a new file settings.yml, make sure the folder arrow points down

![Alt text](pics/014_vscode_create_settings.png?raw=true "create settings.yml")

Copy this config into the file and save

```json
{
"files.associations": {
        "**/*.yml": "ansible"
    }
}
```

![Alt text](pics/014_vscode_add_settings.png?raw=true "add settings.yml")

We don't wont the settings.yml file to be synced with github so we add it to .gitignore

Go to the source control button in the left menu

Right click on the settings.yml file

![Alt text](pics/014_vscode_git_ignore.png?raw=true "git ignore")