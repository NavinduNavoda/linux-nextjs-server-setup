#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <GIT_REPO_URL> <GIT_SSH_KEY_PATH>"
    exit 1
fi

# Variables from arguments
GIT_REPO_URL=$1
GIT_SSH_KEY_PATH=$2

# Clone the Git repository
GIT_SSH_COMMAND="ssh -i $GIT_SSH_KEY_PATH" git clone $GIT_REPO_URL
