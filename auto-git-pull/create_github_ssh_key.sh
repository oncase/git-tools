# Script to create pair of SSH Key automatically to be used in a Github repository.
# It follows the Github guide: https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/connecting-to-github-with-ssh 

# Get external parameters
while getopts u:k: option
do
case "${option}"
in
u) USER_EMAIL=${OPTARG};;
k) KEY_NAME=${OPTARG};;
esac
done

# Create dir. If it fails, that is okay.
mkdir ~/.ssh

# Create the SSH Key without passphrase.
echo ~/.ssh/$KEY_NAME | ssh-keygen -t ed25519 -C "$USER_EMAIL"

# Adding to the ssh-agent.
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/$KEY_NAME

# Printing the contents so you could copy and pastet it in Github.
cat ~/.ssh/$KEY_NAME.pub