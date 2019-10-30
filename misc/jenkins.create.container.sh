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
export JENKINS_CONTAINER_API_TOKEN="11e25dc946f8b77981f8ed90432fdb179e"
export JENKINS_PORT_HOST="49001"
export JENKINS_PORT_CONTAINER="8080"


function docker_create_jenkins_container() {

  IS_DOCKER_UP_RUNNING=$(check_docker_is_up_and_running)

  if [[ $IS_DOCKER_UP_RUNNING =~ 'docker daemon up' ]]; then

    echo "# launching jenkins docker container ..."

    JENKINS_CONTAINER_ID=$(docker run --name $JENKINS_CONTAINER_NAME \
      -p $JENKINS_PORT_HOST:$JENKINS_PORT_CONTAINER \
      -v $JENKINS_VOLUME_HOST:$JENKINS_VOLUME_CONTAINER \
      --restart=always \
      -d jenkins)

      if [ -n "$JENKINS_CONTAINER_ID" ]; then
        echo "# jenkins container is provisioning and will be ready soon"
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
  else
    echo "# unable to provision container: $IS_DOCKER_UP_RUNNING"
  fi
}



alias run-cmd-jenkins-devel="java -jar /usr/local/bin/jenkins-cli.jar -s http://localhost:$JENKINS_PORT_HOST/ -auth $JENKINS_CONTAINER_USER:$JENKINS_CONTAINER_API_TOKEN"
alias connectme-jenkins-devel="docker exec -it -u root $JENKINS_CONTAINER_NAME bash"
alias open-jenkins-devel="open http://localhost:$JENKINS_PORT_HOST"
