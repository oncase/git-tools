#!/bin/bash
# Disable wildcard expansion
set -f
# Get external parameters
while getopts k:f:p:t: option
do
    case "${option}"
    in
    k) KEY_NAME=${OPTARG};;
    f) FILE_PATH=${OPTARG};;
    p) REPO_PATH=${OPTARG};;
    t) TIME_SPAN=${OPTARG};;
    esac
done
# Current directory, the dir of auto-git-pull
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Command to install into the crontab
commd="$TIME_SPAN $DIR/cron_update_repo.sh -k $KEY_NAME -p $REPO_PATH -f $FILE_PATH"
# Installing appended crontab
echo "$(crontab -l ; echo $commd)" | crontab -