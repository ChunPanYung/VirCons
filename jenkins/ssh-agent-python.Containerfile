# podman build --tag ssh-agent-python:latest --file <this_file>
FROM python:3.12-slim as python-compiler
ENV PYTHONUNBUFFERED 1

ENV ANSIBLE_VENV=/opt/ansible
RUN python3 -m venv ${ANSIBLE_VENV}

# Enable venv
ENV PATH="${ANSIBLE_VENV}/bin:${PATH}"
RUN pip3 install ansible

# Install python3 and copy vircutlenv to this image
FROM jenkins/ssh-agent:latest
USER root:root

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install --yes python3 micro && \
    apt clean

ENV ANSIBLE_VENV=/opt/ansible
COPY --from=python-compiler ${ANSIBLE_VENV} /opt/

ENV PATH="${ANSIBLE_VENV}/bin:${PATH}"
