#!/usr/bin/env

# Example of generating self-host certificate and copying it to container
mkcert -key-file selfhost.key -cert-file selfhost.crt localhost 127.0.0.1 ::1

# replace container_id with acutal container_id of actual server
podman cp selfhost.key container_id:/data/
podman cp selfhost.crt container_id:/data/
