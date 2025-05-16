#!/bin/bash

HELM_OPTS="${HELM_OPTS:-}"
NAMESPACE="${NAMESPACE:-higress-system}"

kubectl delete GrafanaDashboard -n grafana-operator grafana-dashboard-v1-higress-higress || true
kubectl delete GrafanaDashboard -n grafana-operator higress-dashboard || true
kubectl delete GrafanaDashboard -n ${NAMESPACE} higress-dashboard || true
helm upgrade --install higress -n ${NAMESPACE} charts/higress --create-namespace  -f default.values.yaml  -f nginx.values.yaml   ${HELM_OPTS}
helm upgrade --install higress -n grafana-operator charts/higress-grafana
