#!/bin/bash

set -e

echo "ghcr.io/infra-kubernetes/base:grafana_plugins_v1" > images/shim/v1.txt
echo "ghcr.io/infra-kubernetes/base:grafana_plugins_v2" > images/shim/v2.txt
