#!/usr/bin/env bash

# onlyoffice setup with podman and quadlet
cp ./jenkins-pod.kube ./jenkins-pod.yaml /etc/containers/systemd/
# Generate ssh key
ssh-keygen -f ./ssh_key -t ed25519 -N ""

base64_data=$(base64 --wrap=0 ./ssh_key.pub)
# sed --in-place "s/\(\s\sssh-pubkey:\s\).*$/\1${base64_data}/" ./jenkins-key.yml

file_path=/tmp/jenkins-key.yml
cat <<EOF >${file_path}
---
apiVersion: v1
kind: Secret
metadata:
  name: jenkins-key
data:
  ssh-pubkey: ${base64_data}
EOF

podman kube play ${file_path}
rm ${file_path}
