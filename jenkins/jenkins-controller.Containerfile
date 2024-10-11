# podman build --tag jenkins-controller:latest --file <this_file>
FROM docker.io/jenkins/jenkins:jdk17
USER root:root

ENV DEBIAN_FRONTEND=noninteractive
COPY jenkins_casc.yaml $JENKINS_HOME/jenkins.yaml
