#!/usr/bin/env sh
#
# AUTHOR: Aleksei Solovev <lelkaklel@gmail.com>
#
# USAGE:
#    .

. ./settings.sh

if [ -z "$1" ]; then
    echo 
    echo 
    echo "ERROR: No argument supplied."
    echo 
    echo "You must log in to registry before run this script."
    echo 
    echo "USAGE: "
    echo "    ./install.sh TAG"
    echo 
    echo 
    exit 1
fi

AIRFLOWSTACK_TAG="$1"
export AIRFLOWSTACK_TAG
export AIRFLOWSTACK_TAG_BASE

docker build --platform $AIRFLOWSTACK_DOCKER_PLATFORM -t $AIRFLOWSTACK_TAG_BASE:$AIRFLOWSTACK_TAG .
docker push $AIRFLOWSTACK_TAG_BASE --all-tags

cat docker-compose.yml > docker-compose-build.yml

if [ "$AIRFLOWSTACK_CREATE_DB" = "true" ]; then
    cat mssql-service.yml >> docker-compose-build.yml
fi

docker stack deploy $AIRFLOWSTACK_NAME -c ./docker-compose-build.yml
