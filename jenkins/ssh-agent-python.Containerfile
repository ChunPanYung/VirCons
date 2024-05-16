# podman build --tag ssh-agent-python:latest --file <this_file>
FROM jenkins/ssh-agent:latest
USER root:root

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install --yes python3 pipx micro && \
    apt clean

# Install packages via pipx
ENV PIPX_HOME=/opt/pipx
ENV PIPX_BIN_DIR=/usr/local/bin
ENV PIPX_MAN_DIR=/usr/local/share/man

RUN pipx install --include-deps ansible

COPY ssh_config /etc/ssh/sshd_config.d/localKeyChecking
