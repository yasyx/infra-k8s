#!/bin/bash
NAMESPACE=${NAMESPACE:-"monitoring"}
HELM_OPTS=${HELM_OPTS:-""}

kubectl delete GrafanaDashboard -n grafana-operator grafana-dashboard-v1-kube-k8s-resource || true
kubectl delete GrafanaDashboard -n grafana-operator grafana-dashboard-v1-kube-kubernetes || true
kubectl delete GrafanaDashboard -n grafana-operator grafana-dashboard-v1-kube-namespace || true
kubectl delete GrafanaDashboard -n grafana-operator grafana-dashboard-v1-kube-node || true
kubectl delete GrafanaDashboard -n grafana-operator grafana-dashboard-v1-kube-node-exporter-cluster || true
kubectl delete GrafanaDashboard -n grafana-operator grafana-dashboard-v1-kube-node-exporter-node || true
kubectl delete GrafanaDashboard -n grafana-operator grafana-dashboard-v1-kube-pod || true

helm upgrade -i prometheus ./hcharts/kube-prometheus-stack -n ${NAMESPACE} --create-namespace -f ./hcharts/kube-prometheus-stack.values.yaml ${HELM_OPTS}

helm delete -n grafana-operator prometheus || true
helm upgrade -i prometheus -n grafana-operator hcharts/prometheus-grafana