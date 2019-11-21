#!/bin/bash

# -----------------------------------------------------
# Description: launch localstack (locally) as docker daemon
#              with docker compose
# Author: Jaziel Lopez
# Date: 2019 Aug
# Requirement: clone localstack project from github
#              https://github.com/localstack/localstack
# Support: OSX as is; for linux do not overwrite TMPDIR; ignore line 19

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
        
        if [[ $SHELL == *"bash"* ]]; then
            echo "export LOCALSTACK_INSTALLATION_PATH=$HERE" >> $HOME/.bashrc
            export LOCALSTACK_INSTALLATION_PATH=$HERE
            echo "[INFO] Written LOCALSTACK_INSTALLATION_PATH to $HOME/.bashrc"
        fi
        
        if [[ $SHELL == *"zsh"* ]]; then
            echo "export LOCALSTACK_INSTALLATION_PATH=$HERE" >> $HOME/.zshrc
            export LOCALSTACK_INSTALLATION_PATH=$HERE
            echo "[INFO] Written LOCALSTACK_INSTALLATION_PATH to $HOME/.zshrc"
        fi
    else
        echo "[ERROR] localstack git clone failed with errors"
        exit 1
    fi
fi

# export LOCALSTACK_INSTALLATION_PATH=;  # enter path where was localstack cloned in

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
