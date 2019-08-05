#!/bin/bash

# ----------------------------------------------------------
# Description: localstack IAM user defined wrapper functions
# Author: Jaziel Lopez
# Date: 2019 July
#
# Support alias functions:
# > localstack_iam_list_users
# > localstack_iam_create_user
# > localstack_iam_create_access_key
# > localstack_iam_delete_access_key
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


function localstack_iam_delete_access_key() {


  echo "Localstack, delete IAM access key... please wait..."
  echo "..............................................."

  if [ -z $1 ]; then
      echo "[ERROR] unable to continue due to missing argument(s).\n\n\tUsage:\t$0 :user :access-key-id"
  else
      aws --endpoint-url=http://localhost:$LOCALSTACK_IAM_PORT iam delete-access-key \
      --user $1 --access-key-id $2
  fi
}

function localstack_iam_list_access_key() {

  echo "Localstack, list IAM access key... please wait..."
  echo "..............................................."

  if [ -z $1 ]; then
      echo "[ERROR] unable to continue due to missing argument(s).\n\n\tUsage:\t$0 :user"
  else
      aws --endpoint-url=http://localhost:$LOCALSTACK_IAM_PORT iam list-access-keys --user $1
  fi
}




