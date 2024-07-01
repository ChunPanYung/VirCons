#!/bin/bash

if [[ $EUID != 0 ]] ; then
    echo "You have to be root for this operation."
    exit 1
fi

podman-compose --file jenkins-compose.yaml up --force-recreate --detach --build --pull
