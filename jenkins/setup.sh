#!/usr/bin/env bash

# onlyoffice setup with podman and quadlet
cp ./jenkins-pod.kube ./jenkins-pod.yaml /etc/containers/systemd/
podman secret create jenkins-secret ./jenkins-secret.yml
