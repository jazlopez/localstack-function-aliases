#!/bin/bash

# CONFIGURE REQUIRED VARIABLE ENVIRONMENT
export AWS_ACCESS_KEY_ID="test" 
export AWS_SECRET_ACCESS_KEY="test"
export AWS_DEFAULT_REGION="us-east-1"
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

LOCALSTACK_S3_ALIAS_FILE="$PWD/s3.alias.sh"

if [ -f ${LOCALSTACK_S3_ALIAS_FILE} ]; then
    printf "[INFO] sourcing %s\n" ${LOCALSTACK_S3_ALIAS_FILE}
    source ${LOCALSTACK_S3_ALIAS_FILE}
fi
