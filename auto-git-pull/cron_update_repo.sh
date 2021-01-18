# Get external parameters
while getopts k:f:r option
do
case "${option}"
in
k) KEY_NAME=${OPTARG};;
f) FILE_PATH=${OPTARG};;
r) REPO_PATH=${OPTARG};;
esac
done

# Logging all activity
echo "*** TURN: " >> $FILE_PATH

# Activating ssh-agent that will handle the ssh keys auth.
eval `ssh-agent -s`
echo "activated ssh-agent:" $SSH_AGENT_PID >> $FILE_PATH

# Added the ssh key
ssh-add ~/.ssh/$KEY_NAME && echo "added key to ssh_agent" >> $FILE_PATH

# Acess the SSH
./ssh_connect_github.expect

cd $REPO_PATH && git pull && echo "Did git pull" >> $FILE_PATH

# Killing the ssh agent subprocess
kill $SSH_AGENT_PID && echo "killed the ssh-agent" >> $FILE_PATH