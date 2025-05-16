#!/bin/bash
HELM_OPTS="${HELM_OPTS:-}"
kubectl create ns k8tz || true
kubectl label ns k8tz k8tz.io/controller-namespace=true --overwrite=true
helm upgrade -i k8tz charts/k8tz -n k8tz --create-namespace --set timezone=Asia/Shanghai --set cronJobTimeZone=true ${HELM_OPTS}
