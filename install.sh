#!/bin/bash
echo "deb [trusted=yes] https://apt.fury.io/labring/ /" | sudo tee /etc/apt/sources.list.d/labring.list
apt update
apt install sealos

sealos -u cuisongliu -p $1 login ghcr.io

sealos pull ghcr.io/infra-kubernetes/kubernetes:v1.28-5.0.0
sealos pull ghcr.io/infra-kubernetes/gpu-operator:v25.3.0
sealos pull ghcr.io/infra-kubernetes/grafana-operator:v5.16.0-plugins
sealos pull ghcr.io/infra-kubernetes/cert-manager:v1.14.6
sealos pull ghcr.io/infra-kubernetes/cni-plugins:v1.5.1
sealos pull ghcr.io/infra-kubernetes/flannel:v0.26.0
sealos pull ghcr.io/infra-kubernetes/helm:v3.15.4
sealos pull ghcr.io/infra-kubernetes/init-tools:main
sealos pull ghcr.io/infra-kubernetes/k8tz:0.17.1
sealos pull ghcr.io/infra-kubernetes/minio:RELEASE.2024-01-11T07-46-16Z
sealos pull ghcr.io/infra-kubernetes/openebs:v3.9.0
sealos pull ghcr.io/infra-kubernetes/victoria-metrics-k8s-stack:v1.112.0
sealos pull ghcr.io/infra-kubernetes/kube-prometheus-stack:v0.63.0
sealos pull ghcr.io/infra-kubernetes/loki:2.9.3
sealos pull ghcr.io/infra-kubernetes/kubeblocks:v0.8.2
sealos pull ghcr.io/infra-kubernetes/kubeblocks-mysql:v0.8.2
sealos pull ghcr.io/infra-kubernetes/kubeblocks-redis:v0.8.2