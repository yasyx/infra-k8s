#!/usr/bin/env bash
set -e

NAME=${NAME:-"victoria-metrics-k8s-stack"}
NAMESPACE=${NAMESPACE:-"vm"}
CHARTS=${CHARTS:-"./charts/victoria-metrics-k8s-stack"}
HELM_OPTS=${HELM_OPTS:-" \
--set grafana.service.type=NodePort \
"}
#rm -rf charts/victoria-metrics-k8s-stack/templates/grafana/dashboards/k8s-system-coredns.yaml
mkdir -p charts/victoria-metrics-k8s-stack/files/certs/etcd
cp /etc/kubernetes/pki/etcd/healthcheck-client.crt charts/victoria-metrics-k8s-stack/files/certs/etcd/healthcheck-client.crt
cp /etc/kubernetes/pki/etcd/healthcheck-client.key charts/victoria-metrics-k8s-stack/files/certs/etcd/healthcheck-client.key
cp /etc/kubernetes/pki/etcd/ca.crt charts/victoria-metrics-k8s-stack/files/certs/etcd/ca.crt
helm upgrade -i ${NAME} ${CHARTS} -n ${NAMESPACE} --create-namespace ${HELM_OPTS}

helm delete -n grafana-operator containerd || true
helm upgrade -i containerd ./charts/metrics-grafana -n grafana-operator