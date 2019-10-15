#!/bin/bash
# ----------------------------------------------------------
# Description:  check docker is up and running
# Author: Jaziel Lopez
# Date: October 2019
# ----------------------------------------------------------

function check_docker_is_up_and_running() {

  DOCKER_RESPONSE_DAEMON=$(docker system info)

  if [[ $DOCKER_RESPONSE_DAEMON =~ ID ]]; then
    echo "# docker is up and running [docker daemon up]"
  else
    echo "# docker daemon offline [docker not running]"
  fi
}


