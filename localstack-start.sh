#!/bin/bash

# -----------------------------------------------------
# Description: launch localstack (locally) as docker daemon
#              with docker compose
# Author: Jaziel Lopez
# Date: 2019 Aug
# Requirement: clone localstack project from github
#              https://github.com/localstack/localstack
# Support:oSX as is; for linux do not overwrite TMPDIR; ignore line 19
clear

echo "
odddddddddddddddddddddddddddddddyhdddddddddddddddddddddddddddddd+
oddy........................................................./ddd+
odds                 .:///////:.                             -ddd+
odds               :o/.\`    \`\`./o:                           -ddd+
odds             \`s/\`           \`/o:::::-\`                   -ddd+
odds             y:               ..\`\`\`.-++:                 -ddd+
odds           \`:y            \`...\`       \`:o-...\`           -ddd+
odds        -/+//-        \`...\`\`  \`...\`     \`/:::/++/.       -ddd+
odds      :o:.          .-.\`         \`\`--          \`.+o.     -ddd+
odds     ++\`             \`...\`     \`...\`              .s.    -ddd+
odds    -s              .-\` \`\`.....\`\` \`--              .y    -ddd+
odds    o:               \`..\`\`  \`  \`\`..\`                y.   -ddd+
odds    ++              .-\` \`\`.....\`\` \`--               y.   -ddd+
odds    \`y.              \`\`..\`\` \` \`\`...\`               /o    -ddd+
odds     .s:                 \`.....\`\`                \`++\`    -ddd+
odds      \`/+:-\`\`               \`                \`.-/+-      -ddd+
odds         .:/+///////////////////////////////+//-.        -ddd+
odds\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`\`:ddd+
oddhyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyhddd+

...................................................................
            Run localstack in your environment
...................................................................

See:        https://github.com/localstack/localstack
Author:     Jaziel Lopez < jaziel.lopez @ thermofisher.com > 
Date:       2019 
Repository: https://github.com/jaziel-lopez/localstack-function-aliases.git
"

echo "[INFO] STEP 1/2: VERIFY LOCALSTACK INSTALLATION"

if [ -z $LOCALSTACK_INSTALLATION_PATH ]; then

    HERE=$PWD/localstack

    if [ ! -d $HERE ]; then
        mkdir $HERE
        echo "[INFO] localstack will be cloned at $HERE ..."
        git clone https://github.com/localstack/localstack $HERE
    else
        echo "[INFO] localstack already cloned at $HERE"
    fi

    if [ $? == 0 ]; then

        export LOCALSTACK_INSTALLATION_PATH=$HERE
        WHICH_PROFILE=$HOME/.bashrc

        if [[ $SHELL == *"zsh"* ]]; then
            WHICH_PROFILE=$HOME/.zshrc
        fi

        echo "export LOCALSTACK_INSTALLATION_PATH=$HERE" >> $WHICH_PROFILE
        echo "[INFO] Written LOCALSTACK_INSTALLATION_PATH to $WHICH_PROFILE"

    else
        echo "[ERROR] localstack git clone failed with errors"
        exit 1
    fi
fi

echo "[INFO] STEP 2/2: LAUNCH LOCALSTACK SERVICES"

echo "[INFO] stand by..."

cd $LOCALSTACK_INSTALLATION_PATH

echo "[INFO] valueof LOCALSTACK_INSTALLATION_PATH: $LOCALSTACK_INSTALLATION_PATH"

TMPDIR=/private/$TMPDIR
DOCKER_COMPOSE_UP=$(docker-compose up -d 2>&1)

if [ $? -ne 0 ]; then
    echo "[ERROR] $DOCKER_COMPOSE_UP"
    exit $?
fi;
echo "[INFO] $DOCKER_COMPOSE_UP"
echo "[INFO] good bye..."

exit 0
