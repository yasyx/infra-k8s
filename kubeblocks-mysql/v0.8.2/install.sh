#!/bin/bash
set -e

NAME=${NAME:-"mysql"}
NAMESPACE=${NAMESPACE:-"mysql"}
CHARTS=${CHARTS:-"./charts/mysql"}
HELM_OPTS=${HELM_OPTS:-""}

helm upgrade -i ${NAME} ${CHARTS} -n ${NAMESPACE} --create-namespace ${HELM_OPTS}
helm delete -n grafana-operator ${NAME} || true
helm upgrade -i ${NAME} ./charts/mysql-grafana -n grafana-operator

kbcli backuprepo create backuprepo-mysql \
  --provider minio \
  --endpoint minio.minio.svc:9000 \
  --bucket backuprepo \
  --access-key-id admin \
  --secret-access-key admin123 \
  --access-method Tool \
  --default

kbcli backuprepo list