#!/usr/bin/env bash

# onlyoffice setup with podman and quadlet
cp ./onlyoffice.kube ./onlyoffice.yaml /etc/containers/systemd/
podman secret create onlyoffice-secret ./onlyoffice-secret.yml
