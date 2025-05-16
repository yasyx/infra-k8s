#!/usr/bin/env bash

set -e
cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1

NAMESPACE=${NAMESPACE:-"vls-system"}
HELM_OPTS=${HELM_OPTS:-""}
ENABLE_CONSOLE=${ENABLE_CONSOLE:-"false"}
if [ "$ENABLE_CONSOLE" = "true" ]; then
  helm upgrade -i vls ./charts/victoria-logs-single -n ${NAMESPACE} --create-namespace -f default.values.yaml -f console.yaml ${HELM_OPTS}
else
  helm upgrade -i vls ./charts/victoria-logs-single -n ${NAMESPACE} --create-namespace -f default.values.yaml  ${HELM_OPTS}
fi