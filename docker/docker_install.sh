#!/bin/bash
# docker install script
# Author: shanyou@gmail.com
# Date: 2018/05/14
#

# install docker from get daocloud to speed up in china

curl -sSL https://get.daocloud.io/docker | sh

# install docker compose
curl -L https://get.daocloud.io/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

# install docker registry mirror
curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://e617eb29.m.daocloud.io

# enable service
systemctl enable docker
systemctl start docker

# varify
docker pull centos
