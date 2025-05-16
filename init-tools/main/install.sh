#!/bin/bash
chmod a+x opt/mc
cp -rf opt/mc /usr/bin/mc
chmod a+x opt/ipvsadm_1_1.28-3ubuntu0.16.04.1_amd64.deb
dpkg -i opt/ipvsadm_1_1.28-3ubuntu0.16.04.1_amd64.deb || echo "安装过程中发生错误，但继续执行后续操作"
