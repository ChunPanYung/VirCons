#!/usr/bin/env bash

# onlyoffice setup with podman and quadlet
cp ./jenkins-pod.kube ./jenkins-pod.yaml /etc/containers/systemd/
# Generate ssh key
ssh-keygen -f ./ssh_key -t ed25519 -N ""

base64_data=$(base64 --wrap=0 ./ssh_key.pub)
sed --in-place "s/\(\s\sssh-pubkey:\s\).*$/\1${base64_data}/"

podman kube play jenkins-key.yml
