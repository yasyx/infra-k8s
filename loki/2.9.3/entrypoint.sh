#!/usr/bin/env bash

set -e
cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1

NAMESPACE=${NAMESPACE:-"loki-system"}
HELM_OPTS=${HELM_OPTS:-""}
PROMTAIL_HELM_OPTS=${PROMTAIL_HELM_OPTS:-""}
helm upgrade -i loki ./charts/loki -n ${NAMESPACE} --create-namespace -f default.values.yaml --set loki.auth_enabled=false --set minio.enabled=false --set write.replicas=1 --set read.replicas=1 --set backend.replicas=1 --set loki.commonConfig.replication_factor=1 ${HELM_OPTS}
helm upgrade -i promtail ./charts/promtail -n ${NAMESPACE} --create-namespace -f promtail.values.yaml  ${PROMTAIL_HELM_OPTS}
