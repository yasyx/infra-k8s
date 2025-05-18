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