#!/bin/bash
set -e

NAME=${NAME:-"mongo"}
NAMESPACE=${NAMESPACE:-"mongo"}
CHARTS=${CHARTS:-"./charts/mongo"}
HELM_OPTS=${HELM_OPTS:-""}

helm upgrade -i ${NAME} ${CHARTS} -n ${NAMESPACE} --create-namespace ${HELM_OPTS}