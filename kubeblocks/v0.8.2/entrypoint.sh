#!/usr/bin/env bash

set -e

kubectl create -f charts/kubeblocks/crds/kubeblocks_crds.yaml || kubectl replace -f charts/kubeblocks/crds/kubeblocks_crds.yaml
sleep 2
helm upgrade -i kubeblocks charts/kubeblocks --set snapshot-controller.enabled=false --insecure-skip-tls-verify -n kb-system --create-namespace
cp -rf opt/kbcli /usr/bin/
kbcli addon enable apecloud-mysql
kbcli addon enable csi-s3
kbcli addon enable redis
kbcli addon enable postgresql
kbcli addon enable mongodb

mc mb --ignore-existing local/backuprepo

kbcli backuprepo create backuprepo-default \
  --provider minio \
  --endpoint minio.minio.svc:9000 \
  --bucket backuprepo \
  --access-key-id admin \
  --secret-access-key admin123 \
  --access-method Tool \
  --default

kbcli backuprepo list