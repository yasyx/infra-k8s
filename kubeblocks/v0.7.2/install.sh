#!/bin/bash
kubectl apply -f crds/
helm upgrade -i kubeblocks charts/kubeblocks --set snapshot-controller.enabled=false --insecure-skip-tls-verify -n kb-system --create-namespace
cp -rf opt/kbcli /usr/bin/
KB_OPTS=${KB_OPTS:-"--set kubeletPath=/var/lib/kubelet"}
kbcli addon enable apecloud-mysql
kbcli addon enable mysql
#https://github.com/apecloud/helm-charts/releases/download/csi-s3-0.31.4/csi-s3-0.31.4.tgz
kbcli addon enable csi-s3  ${KB_OPTS}
kbcli addon enable redis
kbcli addon enable postgresql
