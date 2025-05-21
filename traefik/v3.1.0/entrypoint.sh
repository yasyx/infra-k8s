#!/usr/bin/env bash

set -e
cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1
HELM_OPTS=${HELM_OPTS:-""}
helm upgrade --install traefik charts/traefik -n traefik --create-namespace ${HELM_OPTS}