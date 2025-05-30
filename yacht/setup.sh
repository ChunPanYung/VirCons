#!/usr/bin/env bash

cp ./yacht.image ./yacht.kube ./yacht.yaml \
	/etc/containers/systemd/
# sudo required
podman play kube ./yacht.yaml
