# podman build --tag ssh-agent-python:latest --file <this_file>
FROM jenkins/ssh-agent:latest
USER root:root

ENV DEBIAN_FRONTEND=noninteractive
ENV ANSIBLE_VENV=/opt/ansible
RUN apt update && \
    apt install --yes python3 micro && \
    apt clean

RUN source ${ANSIBLE_VENV}/bin/activate && \
    python3 -m venv ${ANSIBLE_VENV} && \
    python3 -m pip3 install ansible && \

ENV PATH="${ANSIBLE_VENV}/bin:${PATH}"
RUN echo "PATH=${PATH}" >> /etc/environment
