#!/bin/bash
set -e

NAME=${NAME:-"redis"}
NAMESPACE=${NAMESPACE:-"redis"}
CHARTS=${CHARTS:-"./charts/redis"}
HELM_OPTS=${HELM_OPTS:-""}

kubectl delete GrafanaDashboard -n grafana-operator grafana-dashboard-v1-redis-redis || true

helm upgrade -i ${NAME} ${CHARTS} -n ${NAMESPACE} --create-namespace ${HELM_OPTS}
helm delete -n grafana-operator ${NAME} || true
helm upgrade -i ${NAME} ./charts/redis-grafana -n grafana-operator