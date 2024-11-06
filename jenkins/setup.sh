#!/usr/bin/env bash

echo "This will help you setup SSH key and create kubernete secret via podman."

# Create directory for storing container data
tmp_dir=/tmp/jenkins-container.${RANDOM}
mkdir ${tmp_dir}

# Generate ssh key
ssh-keygen -f ${tmp_dir}/ssh_key -t ed25519 -N ""

base64_data=$(base64 --wrap=0 ${tmp_dir}/ssh_key.pub)
secret_file_path=${tmp_dir}/jenkins-key.yml

cat <<EOF >${secret_file_path}
---
apiVersion: v1
kind: Secret
metadata:
  name: jenkins-key
data:
  ssh-pubkey: ${base64_data}
EOF

podman kube play ${secret_file_path}

private_key=$(cat ${tmp_dir}/ssh_key)
echo "SSH private key are:"
echo "${private_key}"
echo "All the output files are in ${tmp_dir}"
echo ""
echo "Please remove directory and its content when you are done."

cp jenkins-pod.kube jenkins-pod.yaml jenkins-ssh-agent.build \
  jenkins-ssh-agent.Containerfile /etc/container/systemd/

cp jenkins-ssh-agent-build.timer /etc/systemd/system/
