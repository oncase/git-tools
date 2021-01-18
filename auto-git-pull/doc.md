# Auto-Git-Pull

Library of shell scripts to create and set Github SSH keys in order to perform regularly _git pull_ command through cronjobs.

## Requirements

First, make sure that all the files are executable.

```{shell}
chmod +x create_github_ssh_key.sh cron_update_repo.sh set_github_repo.sh ssh_connect_github.expect
```

Then, install the expect package.

```{shell}
sudo apt update
sudo apt-get install -y expect
```

## Workflow

There are 2 parameterized scripts that create and set Github SSH Keys (**create_github_ssh_key.sh**, **set_github_repo.sh**) and another one that is meant to be used in the cronjob. (**cron_update_repo.sh**)

For starters, be sure to be in the "auto-git-pull" folder.

1. Create your SSH keys.

This function will create the ~/.ssh directory if it doesn't exist, generate and add the SSH keys into it.

```{shell}
./create_github_ssh_key.sh -u {USER_EMAIL_FOR_GITHUB} -k {KEY_NAME_OF_YOUR_DESIRE}
```

You see the last line of the output? Copy it, for it will be useful for later.

You can check the correct creation of your SSH key through the code below.

```{shell}
ls ~/.ssh
```

You ought to see the {KEY_NAME_OF_YOUR_DESIRE} and {KEY_NAME_OF_YOUR_DESIRE}.pub

2. Set your SSH keys in your Github account.

For a more visual guide, go to [the offical Github guide](https://docs.github.com/pt/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account).

Basically, on your Github account, follow this flow: 

Settings > SSH and GPG Keys > New/Add SSH Keys.

Then, enter the title you wish and on the 'key' section paste the last line of the output from the previous part. Click on "Add SSH Key".

3. Set your Github repo.

You need to change the url that your 'remote' in git is connecting, so that it can connect through SSH not HTTPS.

The default name for remote is 'origin', so if you don't know the name it is probably that.

```{shell}
./set_github_repo.sh -p {REPO_PATH_IN_YOUR_MACHINE} -r {REMOTE_NAME} -n {GITHUB_USER/REPO_NAME_IN_GITHUB}
```

4. Set your cronjob.

The crontab command administrates your cronjobs.

Use the code below to edit the cronjobs. Each line is a separate job. 

Each entry in a crontab file consists of six fields, specifying in the following order:

_minute(s) hour(s) day(s) month(s) weekday(s) command_

For the time part, I recommend using https://crontab.guru/ . It is a free website that helps in setting the correct time for cronjobs.

Edit your cronjobs with the command below.

```{shell}
crontab -e
```

In the editor that was spawned add the following line:

```{shell}
* * * * * cd {PATH_TO_"auto-git-pull"_FOLDER} && ./update_repo.sh -k {KEY_NAME_OF_YOUR_DESIRE} -f {FILE_PATH_TO_STORE_LOG}
```

And that is it!