#!/bin/bash

# -----------------------------------------------------
# Description: launch localstack (locally) as docker daemon
#              with docker compose
# Author: Jaziel Lopez
# Date: 2019 Aug
# Requirement: clone localstack project from github
#              https://github.com/localstack/localstack
# Support: OSX as is; for linux do not overwrite TMPDIR; ignore line 19


export LOCALSTACK_INSTALLATION_PATH=;  # enter path where was localstack cloned in

echo "=============================================="
echo "[INFO] starting localstack services...."
echo "[INFO] stand by..."
cd $LOCALSTACK_INSTALLATION_PATH

echo "[INFO] localstack installation path: $LOCALSTACK_INSTALLATION_PATH"

TMPDIR=/private/$TMPDIR
DOCKER_COMPOSE_UP=$(docker-compose up -d 2>&1)

if [ $? -ne 0 ]; then
    echo "[ERROR] $DOCKER_COMPOSE_UP"
    exit $?
fi;
echo "[INFO] $DOCKER_COMPOSE_UP"
echo "[INFO] good bye..."
echo "=============================================="
exit 0
