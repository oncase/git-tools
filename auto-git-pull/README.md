# Auto-Git-Pull

Library of shell scripts to create and set Github SSH keys in order to perform regularly _git pull_ command through cronjobs.

## Requirements

First, clone this repository wherever you wish. Then, install the expect package. This will help automatise the generation of SSH keys.

```{bash}
sudo apt update
sudo apt-get install -y expect
```

## Workflow

Here is a full quick example. Let's say that Tony Stark wants to update through
git pull the repository of his Jarvis project with every hour.

```{bash}
cd ~/git-tools/auto-git-pull

./create_github_ssh_key.sh -u tonystark@gmail.com -k my_pc10
#Add SSH Key in your Git account
./set_github_repo.sh -p ~/Projects/Jarvis -n tonystark/jarvis
./cron_set.sh -k my_pc10 -p ~/Projects/Jarvis -t "* 1 * * *" -f ~/logfiles/
```
If he had already a SSH key, he'd just use the two last commands, and if his repository
was already connected via SSH he'd just use the last command.

## Walkthrough

There are 2 parameterized scripts that create and set Github SSH Keys (**create_github_ssh_key.sh**, **set_github_repo.sh**) and another one that is meant to be used in the cronjob. (**cron_update_repo.sh**)

0. For starters, be sure to be in the "auto-git-pull" folder.

Example:

```{bash}
cd ~/git-tools/auto-git-pull
```

1. Create your SSH keys.

This function will create the ~/.ssh directory if it doesn't exist, generate and add the SSH keys into it.

```{bash}
./create_github_ssh_key.sh -u {USER_EMAIL_FOR_GITHUB} -k {KEY_NAME_OF_YOUR_DESIRE}
```

You see the last line of the output? Copy it, for it will be useful for later.

You can check the correct creation of your SSH key through the code below.

```{bash}
ls ~/.ssh
```

You ought to see the {KEY_NAME_OF_YOUR_DESIRE} and {KEY_NAME_OF_YOUR_DESIRE}.pub

Example:

```{bash}
./create_github_ssh_key.sh -u johndoe@gmail.com -k my_pc
```

2. Set your SSH keys in your Github account.

For a more visual guide and example, go to [the offical Github guide](https://docs.github.com/pt/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account).

Basically, on your Github account, follow this flow: 

Settings > SSH and GPG Keys > New/Add SSH Keys.

Then, enter the title you wish and on the 'key' section paste the last line of the output from the previous part. Click on "Add SSH Key".

3. Set your Github repo.

You need to change the url that your 'remote' in git is connecting, so that it can connect through SSH not HTTPS.

The default name for remote is 'origin', so if you don't know the name it is probably that.

```{bash}
./set_github_repo.sh -p {REPO_PATH} -r {REMOTE_NAME} -n {GITHUB_USER/REPO_NAME_IN_GITHUB}
```

To make it clear, you don't need to put the "-r" flag. The default value of it is "origin".

Example:

```{bash}
./set_github_repo.sh -p ~/cool_project_folder -n johndoe/cool_project
```

4. Set your cronjob.

The crontab command administrates your cronjobs.

Use the code below to edit the cronjobs. Each line is a separate job with a scheduled time. 

Each entry in a crontab file consists of six fields, specifying in the following order:

_minute(s) hour(s) day(s) month(s) weekday(s) command_

For the time part, I recommend using https://crontab.guru/ . It is a free website that helps in setting the correct time for cronjobs.

The following command installs the crontab with just the necessary parameters.

```{bash}
./cron_set.sh -k {KEY_NAME_OF_YOUR_DESIRE} -p {REPO_PATH} -t {TIME_SPAN_CRONTAB} -f {FOLDER_PATH_TO_SAVE_LOGS}
```

The log will be saved in the folder that you specify with the -f flag. It will first create the logs-auto-git-pull folder, then everyday it will create a new subfolder with the date and save the actual log inside it.

Example:

```{bash}
./cron_set.sh -k my_pc -p ~/cool_project_folder -t '0,30 * * * *' -f ~/cronlogs/
```

And that is it!