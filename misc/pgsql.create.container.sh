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


function docker_create_pgsql_container() {

  echo ""
  echo "# launching pgsql docker container ..."

  PGSQL_CONTAINER_ID=$(docker run --name $PGSQL_CONTAINER_NAME \
    -e POSTGRES_USER=$PGSQL_DEFAULT_USER \
    -e POSTGRES_PASSWORD=$PGSQL_DEFAULT_PASSWORD \
    -e POSTGRESS_DB=$PGSQL_DEFAULT_DB \
    -e PGDATA=$PGSQL_VOLUME_CONTAINER \
    -v $PGSQL_VOLUME_HOST:$PGSQL_VOLUME_CONTAINER \
    -d postgres)

  if [ -n "$PGSQL_CONTAINER_ID" ]; then
    echo "# pgsql launch done"
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
}
