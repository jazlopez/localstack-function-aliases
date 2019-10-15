#!/bin/bash

# ----------------------------------------------------------
# Description: create postgres docker container
# Author: Jaziel Lopez
# Date: October 2019
# ----------------------------------------------------------

export PGSQL_VOLUME_HOST="/opt/pgsql"
export PGSQL_VOLUME_CONTAINER="/var/lib/postgresql/data/db-files/"
export PGSQL_CONTAINER_NAME="pgsql_devel"
export PGSQL_DEFAULT_USER="admin"
export PGSQL_DEFAULT_PASSWORD="secret"
export PGSQL_DEFAULT_DB="pgsql_devel"
export PGSQL_CONTAINER_PORT=5432
export PGSQL_HOST_PORT=15432

function docker_create_pgsql_container() {

  echo " 
  ----------------------------------------------------------------------
                PROVISION POSTGRES DOCKER CONTAINER
  ----------------------------------------------------------------------

  Jaziel Lopez,                 MMMXkolcccccoxOOdlc:::::::::cc::::lONMMM
  Software Engineer             WKxoooooooooooddoooooooodk0OxdoooooooxKW
  Tijuana Area, BC, Mexico      Oloxoc:;;;;:ck0xl:;;;;;;:coxkdc;;:codolx
  jlopez.mx.                    cdx:;;;;;;;:xOl;;;;;;;;;;;;;cdkd:;;;:xd;
                                :kl;;;;;;;;dOo;;;;;;;;;;;;;;;;lkx:;;;ok;
                                :kl;;;;;;;:kOooddl:;;;;;;;;:lodOKx;;;dx;
                                :ko;;;;;;;c00xdk00kc;;;;;;:dOOOk0k:;:kl:
                                :dx;;;;;;;cOx;;cloOd:;;;;;:kkc:lOd;;dx:x
                                llkc;;;;;;cOx;;;;ckkc:;;;;;oOd;lOd;lkclX
                                Ocdd;;;;;;lOd;;;;cOx::;;;;;:dOocOxlxlcKM
                                Nockl;;;;;cOx:;;:dOl;;;;;;;;:dOkOOkoc0MM
                                MKcoxc;;;;;oOxl:dOd;;;;;;;;;;:oKX0l,oO0K
                                MWkcdx:;;;;lkxldKKkoc:;;;;;;;;lOKOllodo;
                                MMWkcdxc:cdkdccdxdO0kl;;;;;;;:kKxxOOOxlc
                                MMMWOlloooc:x0Oxdok0Oo;;;;;;;lOxloododON
                                MMMMMNOxdxkxdddddcckOo;;;;;;;oxcdXXNWMMM
                                MMMMMMMMMMMMMWWWWOoxOo;;;;;;;xdc0MMMMMMM
                                MMMMMMMMMMMMMMMMMKoxKd;;;;;;:kolXMMMMMMM
                                MMMMMMMMMMMMMMMMMNxdKkc;;;;:dxlkMMMMMMMM
                                MMMMMMMMMMMMMMMMMMXdcodddoooodOWMMMMMMMM
                                MMMMMMMMMMMMMMMMMMMXko::ccccxXMMMMMMMMMM
  "


  IS_DOCKER_UP_RUNNING=$(check_docker_is_up_and_running)
  
  if [[ $IS_DOCKER_UP_RUNNING =~ 'docker daemon up' ]]; then
  
   echo "# launching pgsql docker container ..."

    PGSQL_CONTAINER_ID=$(docker run --name $PGSQL_CONTAINER_NAME \
      -e POSTGRES_USER=$PGSQL_DEFAULT_USER \
      -e POSTGRES_PASSWORD=$PGSQL_DEFAULT_PASSWORD \
      -e POSTGRESS_DB=$PGSQL_DEFAULT_DB \
      -e PGDATA=$PGSQL_VOLUME_CONTAINER \
      -v $PGSQL_VOLUME_HOST:$PGSQL_VOLUME_CONTAINER \
      --restart=always \
      -p $PGSQL_HOST_PORT:$PGSQL_CONTAINER_PORT \
      -d postgres)

    if [ -n "$PGSQL_CONTAINER_ID" ]; then
      echo "# pgsql launch done"
      echo "# you can connect at:"
      echo "# host: localhost"
      echo "# port: $PGSQL_HOST_PORT"
      echo ".........................................\n"
      echo "- logs pgsql container:"
      echo "  docker logs $PGSQL_CONTAINER_ID"
      echo "- stop pgsql container:"
      echo "  docker stop $PGSQL_CONTAINER_ID"
      echo "- remove pgsql container:"
      echo "  docker rm $PGSQL_CONTAINER_ID"
      echo ""
      echo ""
      echo "Contact:"
      echo "Jaziel Lopez <jaziel.lopez @ thermofisher.com>"
    fi
  else
    echo "# unable to provision container: $IS_DOCKER_UP_RUNNING"
  fi

}
