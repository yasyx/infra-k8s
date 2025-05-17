#!/bin/bash

set -e

mkdir -p manifests images/shim

helm template victoria-metrics-k8s-stack hcharts/victoria-metrics-k8s-stack  --values hcharts/victoria-metrics-k8s-stack/values.yaml   --debug > manifests/victoria-metrics-k8s-stack.yaml