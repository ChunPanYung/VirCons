# podman build --build-arg key=<value> --tag ssh-agent-python:latest --file <this_file>
FROM jenkins/ssh-agent:latest
USER root:root

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install --yes python3 python3-pip pipx && \
    apt clean

ENV JENKINS_AGENT_HOME=/home/jenkins
# Add new location to PATH variable
ENV PATH="${JENKINS_AGENT_HOME}/.local/bin:${PATH}"
RUN echo "PATH=${PATH}" >> /etc/environment

USER jenkins:jenkins
RUN pipx install --include-deps ansible

ARG JENKINS_AGENT_CONFIG=/usr/local/etc/jenkins
COPY ${JENKINS_AGENT_CONFIG}/ssh/* ${JENKINS_AGENT_HOME}/.ssh/

