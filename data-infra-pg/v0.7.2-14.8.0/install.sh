#!/bin/bash
set -e
kbcli addon enable postgresql
NAME=${NAME:-"postgresql"}
NAMESPACE=${NAMESPACE:-"postgresql"}
CHARTS=${CHARTS:-"./charts/postgresql"}
HELM_OPTS=${HELM_OPTS:-""}

helm upgrade -i ${NAME} ${CHARTS} -n ${NAMESPACE} --create-namespace ${HELM_OPTS}
