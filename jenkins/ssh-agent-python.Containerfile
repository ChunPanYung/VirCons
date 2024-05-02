# podman build --tag ssh-agent-python:latest --file <this_file>
FROM jenkins/ssh-agent:latest
USER root:root

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install --yes python3 python3-pip micro && \
    apt clean && \


ENV ANSIBLE_VENV=/opt/ansible
ENV PATH="${ANSIBLE_VENV}/bin:${PATH}"
RUN python3 -m venv ${ANSIBLE_VENV} && \
    pip3 install ansible

RUN echo "PATH=${PATH}" >> /etc/environment
