#!/bin/bash

# ----------------------------------------------------------
# Description: create jenkins docker container
# Author: Jaziel Lopez
# Date: October 2019
# ----------------------------------------------------------
export JENKINS_CONTAINER_USER="jenkins_devel"
export JENKINS_CONTAINER_PASSWORD="123456"
export JENKINS_VOLUME_HOST="/opt/jenkins"
export JENKINS_VOLUME_CONTAINER="/var/jenkins_home/"
export JENKINS_CONTAINER_NAME="jenkins_devel"
export JENKINS_PORT_HOST="49001"
export JENKINS_PORT_CONTAINER="8080"


function docker_create_jenkins_container() {

  echo ""
  echo "# launching jenkins docker container ..."

  JENKINS_CONTAINER_ID=$(docker run --name $JENKINS_CONTAINER_NAME \
    -p $JENKINS_PORT_HOST:$JENKINS_PORT_CONTAINER \
    -v $JENKINS_VOLUME_HOST:$JENKINS_VOLUME_CONTAINER \
    --restart=always \
    -d jenkins)

  if [ -n "$JENKINS_CONTAINER_ID" ]; then
    echo "# jenkins launch done"
    echo ".........................................\n"
    echo "- logs jenkins container:"
    echo "  docker logs $JENKINS_CONTAINER_ID"
    echo "- stop jenkins container:"
    echo "  docker stop $JENKINS_CONTAINER_ID"
    echo "- remove jenkins container:"
    echo "  docker rm $JENKINS_CONTAINER_ID"
    echo ""
    echo ""
    echo "Contact:"
    echo "Jaziel Lopez <jaziel.lopez @ thermofisher.com>"
  fi
}
