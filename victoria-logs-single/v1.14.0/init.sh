#!/bin/bash

set -e

rm -rf charts images/shim && mkdir -p manifests images/shim

helm template victoria-logs-single hcharts/victoria-logs-single  --values hcharts/victoria-logs-single/values.yaml   --debug > manifests/victoria-logs-single.yaml