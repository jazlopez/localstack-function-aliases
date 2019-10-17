#!/bin/bash

# ----------------------------------------------------------
# Description: create nginx docker container
# Author: Jaziel Lopez
# Date: October 2019
# ----------------------------------------------------------

export NGINX_CONTAINER_NAME=nginx_devel
export NGINX_CONTAINER_PORT=80
export NGINX_HOST_PORT=18080

function docker_create_nginx_container() {

  echo " 
  ----------------------------------------------------------------------
                PROVISION NGINX DOCKER CONTAINER
  ----------------------------------------------------------------------

  Jaziel Lopez,                   MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
                                  MMMMMMMMMMMMMMMMMMmyo/:/sdNMMMMMMMMMMMMMMMMMM
  Software Engineer               MMMMMMMMMMMMMMNds/:::::::::oymMMMMMMMMMMMMMMM
                                  MMMMMMMMMMMmyo/:::::::::::::::/sdNMMMMMMMMMMM
  Tijuana Area, BC, Mexico        MMMMMMMMds/:::::::::::::::::::::::oymMMMMMMMM
                                  MMMMmho/:::::::::::::::::::::::::::::/sdNMMMM
  jlopez.mx.                      Mds/::::::::::::::::::::::::::::::::::::/oymM
                                  /:::::::::::::::::::::::::::::::::::::::::::s
                                  :::::::::::ymNNmy/::::::::::/hNNmo::::::::::/
                                  ::::::::::+MMMMMMNs:::::::::oMMMMm::::::::::/
                                  ::::::::::+MMMMMMMMm+:::::::oMMMMm::::::::::/
                                  ::::::::::+MMMMMMMMMMh/:::::oMMMMm::::::::::/
                                  ::::::::::oMMMMN/dMMMMNs::::oMMMMm::::::::::/
                                  ::::::::::oMMMMN::omMMMMm+::oMMMMm::::::::::/
                                  ::::::::::oMMMMN:::/yNMMMMh/oMMMMm::::::::::/
                                  ::::::::::oMMMMN:::::/hMMMMNdMMMMm::::::::::/
                                  ::::::::::oMMMMN:::::::omMMMMMMMMm::::::::::/
                                  ::::::::::oMMMMN:::::::::sNMMMMMMm::::::::::/
                                  ::::::::::/NMMMh::::::::::/hMMMMMh::::::::::/
                                  :::::::::::/oo+:::::::::::::/+oo/:::::::::::+
                                  do/:::::::::::::::::::::::::::::::::::::::+yN
                                  MMMdy+::::::::::::::::::::::::::::::::/ohNMMM
                                  MMMMMMNho/:::::::::::::::::::::::::+sdMMMMNNM
                                  MMMMMMMMMMdy+::::::::::::::::::/ohNMMMMMMNmmm
                                  MMMMMMMMMMMMMNho/:::::::::::/sdMMMMMMMMMMMNNN
                                  MMMMMMMMMMMMMMMMMdy+::::/ohmMMMMMMMMMMMMMMMMM
                                  MMMMMMMMMMMMMMMMMMMMNhhdMMMMMMMMMMMMMMMMMMMMM
  "


  IS_DOCKER_UP_RUNNING=$(check_docker_is_up_and_running)
  
  if [[ $IS_DOCKER_UP_RUNNING =~ 'docker daemon up' ]]; then
  
   echo "# launching nginx docker container ..."

    NGINX_CONTAINER_ID=$(docker run --name $NGINX_CONTAINER_NAME \
      --restart=always \
      -p $NGINX_HOST_PORT:$NGINX_CONTAINER_PORT \
      -d nginx)

    if [ -n "$NGINX_CONTAINER_ID" ]; then
      echo ""
      echo "# nginx container is provisioning and will be ready soon"
      echo ""
      echo "# your nginx webserver can be found at:"
      echo "# http://localhost:$NGINX_HOST_PORT"
      echo ".........................................\n"
      echo "- logs nginx container:"
      echo "  docker logs $NGINX_CONTAINER_ID"
      echo "- stop nginx container:"
      echo "  docker stop $NGINX_CONTAINER_ID"
      echo "- remove nginx container:"
      echo "  docker rm $NGINX_CONTAINER_ID"
      echo ""
      echo ""
      echo "Contact:"
      echo "Jaziel Lopez <jaziel.lopez @ thermofisher.com>"
    fi
  else
    echo "# unable to provision container: $IS_DOCKER_UP_RUNNING"
  fi

}
