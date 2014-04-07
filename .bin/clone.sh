#!/bin/bash

SRC_DIR="$HOME/src"

# ensure src directory exists
if [ ! -d "$SRC_DIR" ]; then
    echo "Creating source directory..."
    mkdir $SRC_DIR
fi

# ensure git is installed
if ! which git > /dev/null; then
    echo "Please install Git..."
    exit 0
fi

# fetch repo svn_url's
REPOS=$(curl -s "https://api.github.com/users/$USER/repos" \
    | python -mjson.tool \
    | grep svn_url \
    | cut -d'"' -f4)

# convert to array
REPOS=($REPOS)

# clone each repo if target directory doesn't exist
for URL in "${REPOS[@]}"
do
    REPO_NAME=$(echo $URL | grep -Eo '[^/]+/?$' | cut -d / -f1)
    TARGET_DIR=$SRC_DIR/$REPO_NAME

    if [ ! -d "$TARGET_DIR" ]; then
        git clone $URL $TARGET_DIR
    fi
done
