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
  else
      echo "[INFO] found previous localstack installation"
fi

echo "[INFO] STEP 2/2: LAUNCH LOCALSTACK SERVICES"

echo "[INFO] stand by..."

cd $LOCALSTACK_INSTALLATION_PATH

echo "[INFO] valueof LOCALSTACK_INSTALLATION_PATH: $LOCALSTACK_INSTALLATION_PATH"

TMPDIR=/private/$TMPDIR

# user preference
DATADIR=$HOME/localstack-data/            # Local directory for saving persistent data 
                                          # (currently only supported for these services: Kinesis, DynamoDB, Elasticsearch, S3).

PORT_WEB_UI=8888                          # Port for localstack web UI (do not use default 8080)
START_WEB=1                               # Localstack web UI should start (0/1)
SERVICES="s3"                             # Services to start, use comma separator,
                                          # comment line entirely to start all by default
HOSTNAME="localstack.local"               # Hostname, do not forget to add localstack.local to your hosts file
DEFAULT_REGION="us-east-1"                # Region, change accordingly if required

# verify path(s) exists
if [ ! -d $DATADIR ]; then
  mkdir $DATADIR
fi

# write .env file on the fly
echo "export DATA_DIR=$DATADIR" > .env
echo "export PORT_WEB_UI=$PORT_WEB_UI" >> .env
echo "export START_WEB=$START_WEB" >> .env
echo "export SERVICES=$SERVICES" >> .env
echo "export HOSTNAME=$HOSTNAME" >> .env
echo "export DEFAULT_REGION=$DEFAULT_REGION" >> .env


# source .env file before compose
DOCKER_COMPOSE_UP=$(source .env && docker-compose up -d 2>&1)

# clean up env
rm -f .env

if [ $? -ne 0 ]; then
    echo "[ERROR] $DOCKER_COMPOSE_UP"
    exit 1
fi;
echo "[INFO] $DOCKER_COMPOSE_UP"
echo "[INFO] good bye..."

exit 0
