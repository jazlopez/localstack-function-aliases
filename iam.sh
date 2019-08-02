#!/bin/bash

# ----------------------------------------------------------
# Description: localstack IAM user defined wrapper functions
# Author: Jaziel Lopez
# Date: 2019 July
# ----------------------------------------------------------

export LOCALSTACK_IAM_PORT=4593        # see localstack port mapping
                                       # at localstack README.md


function localstack_iam_list_users() {
  echo "Localstack, listing IAM users... please wait..."
  echo "..............................................."
  aws --endpoint-url=http://localhost:$LOCALSTACK_IAM_PORT iam list-users
}

function localstack_iam_create_user() {

  echo "Localstack, create IAM users... please wait..."
  echo "..............................................."

  if [ -z $1 ]; then
    echo "[ERROR] unable to continue due to missing username argument.\n\n\tUsage:\t$0 :username"
  else
    aws --endpoint-url=http://localhost:$LOCALSTACK_IAM_PORT iam create-user --user-name $1;
  fi;
}

function localstack_iam_create_access_key() {


  echo "Localstack, create IAM access key... please wait..."
  echo "..............................................."

  if [ -z $1 ]; then
    echo "[ERROR] unable to continue due to missing user argument.\n\n\tUsage:\t$0 :user"
  else
      aws --endpoint-url=http://localhost:$LOCALSTACK_IAM_PORT iam create-access-key --user $1;
  fi
}
