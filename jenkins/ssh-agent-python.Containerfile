# podman build --tag ssh-agent-python:latest --file <this_file>
FROM python:3.11-slim as python-compiler
ENV PYTHONUNBUFFERED 1

ENV ANSIBLE_VENV=/opt/ansible
RUN python3 -m venv ${ANSIBLE_VENV}

# Enable venv
ENV PATH="${ANSIBLE_VENV}/bin:${PATH}"
RUN pip3 install ansible

FROM jenkins/ssh-agent:latest
USER root:root

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install --yes python3 micro && \
    apt clean

ENV ANSIBLE_VENV=/opt/ansible
COPY --from=python-compiler ${ANSIBLE_VENV} /opt/ansible/

ENV PATH="${ANSIBLE_VENV}/bin:${PATH}"
RUN echo "PATH=${PATH}" >> /etc/environment
