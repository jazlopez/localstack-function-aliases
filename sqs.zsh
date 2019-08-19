#!/bin/bash

# ----------------------------------------------------------
# Description: localstack IAM user defined wrapper functions
# Author: Jaziel Lopez
# Date: 2019 July
#
# Support alias functions:
# > localstack_sqs_list_queues
# > localstack_sqs_create_queue
# ----------------------------------------------------------

export LOCALSTACK_SQS_PORT=4576        # see localstack port mapping
                                       # at localstack README.md


function localstack_sqs_list_queues() {
  echo "Localstack, listing sqs queues... please wait..."
  echo "..............................................."
  aws --endpoint-url=http://localhost:$LOCALSTACK_SQS_PORT sqs list-queues
}

function localstack_sqs_create_queue() {
   echo "Localstack, create sqs queue... please wait..."
   echo "..............................................."

   if [ -z $1 ]; then
     echo "[ERROR] unable to continue due to missing queue name argument.\n\n\tUsage:\t$0 :queue-name"
   else
     aws --endpoint-url=http://localhost:$LOCALSTACK_SQS_PORT sqs create-queue --queue-name $1;
   fi;
}

