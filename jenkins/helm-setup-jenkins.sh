#!/usr/bin/env bash

# Setup Jenkins @ Kubernetes using helm, kind, and kubectl command.

# Create kind cluster
kind create cluster --name kind || echo "Cluster with this name is already created."
kubectl cluster-info --context kind-kind

# Get Repository and install jenkins chart
helm repo add jenkins https://charts.jenkins.io
helm repo update
helm install jenkins/jenkins --generate-name
