#!/bin/bash

if [[ ! -v ZSH_CUSTOM ]]; then
    printf "[ERROR] %s\n" "ZSH_CUSTOM environment variable could not be found: is ZSH installed on your system?"
    exit 1
fi

# CONFIGURE REQUIRED VARIABLE ENVIRONMENT
# export AWS dummy values (if not already set)
if [ -z "${AWS_ACCESS_KEY_ID}" ]; then
    export AWS_ACCESS_KEY_ID="test" 
fi
if [ -z "${AWS_SECRET_ACCESS_KEY}" ]; then
    export AWS_SECRET_ACCESS_KEY="test" 
fi

if [ -z "${AWS_DFAULT_REGION}" ]; then
    export AWS_DEFAULT_REGION="us-east-1" 
fi


export LOCALSTACKHOST="http://localhost"
export LOCALSTACKPORT=4566
export LOCALSTACKURL="${LOCALSTACKHOST}:${LOCALSTACKPORT}"

function _contactme_(){
  local CONTACTME="Jaziel Lopez jazlopez@github.com"
  local CONTACTURL="https://jlopez.mx"

  printf "\n%s\n" ".................................................."
  printf "%s\n" "Contact:"
  printf "  %s\n" $CONTACTME
  printf "  %s\n" $CONTACTURL
}

printf "%s\n" "creating symlinks for aliases under $ZSH_CUSTOM"
ln -s s3.alias.sh $ZSH_CUSTOM/localstack.s3.aliases.zsh

LOCALSTACK_S3_ALIAS_FILE="$PWD/s3.alias.sh"

if [ -f ${LOCALSTACK_S3_ALIAS_FILE} ]; then
    printf "[INFO] sourcing %s\n" ${LOCALSTACK_S3_ALIAS_FILE}
    source ${LOCALSTACK_S3_ALIAS_FILE}
fi
