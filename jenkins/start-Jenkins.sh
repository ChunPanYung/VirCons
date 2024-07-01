#!/bin/bash

podman-compose --file jenkins-compose.yaml up --force-recreate --detach --build --pull
