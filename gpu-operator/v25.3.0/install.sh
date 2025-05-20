#!/bin/bash
set -e

NAME=${NAME:-"gpu-operator"}
NAMESPACE=${NAMESPACE:-"gpu-operator"}
CHARTS=${CHARTS:-"./charts/gpu-operator"}
HELM_OPTS=${HELM_OPTS:-""}

helm upgrade --wait -i ${NAME} ${CHARTS} -n ${NAMESPACE} --create-namespace -f values.yaml ${HELM_OPTS}