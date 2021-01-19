# Script to set the already existing Github SSH Key on a Github repo,
# In order to acess the git's repo without credentials.

# Get external parameters
while getopts p:r:n: option
do
case "${option}"
in
p) REPO_PATH=${OPTARG};;
r) REPO_REMOTE=${OPTARG};;
n) REPO_NAME=${OPTARG};;
esac
done

# Setting up your Github repository
echo $REPO_PATH
echo $REPO_REMOTE
echo $REPO_NAME
cd $REPO_PATH && git remote set-url $REPO_REMOTE git@github.com:$REPO_NAME.git
echo "git remote set-url $REPO_REMOTE git@github.com:$REPO_NAME.git"