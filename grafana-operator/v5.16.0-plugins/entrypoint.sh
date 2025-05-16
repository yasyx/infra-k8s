#!/usr/bin/env bash

set -e
cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1

NAME=${NAME:-"grafana-operator"}
NAMESPACE=${NAMESPACE:-"grafana-operator"}
HELM_OPTS="${HELM_OPTS:-}"
GF_HELM_OPTS="${GF_HELM_OPTS:-}"

helm upgrade -i ${NAME} ./hcharts/${NAME} -n ${NAMESPACE} --create-namespace ${HELM_OPTS} --wait
helm upgrade -i grafana ./hcharts/grafana -n ${NAMESPACE} --create-namespace ${GF_HELM_OPTS}