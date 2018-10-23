#!/bin/bash
# docker install script
# Author: shanyou@gmail.com
# Date: 2018/05/14
#

# install docker from get daocloud to speed up in china
# curl -sSL https://get.daocloud.io/docker | sh

# install docker from aliyun
# step 1: 安装必要的一些系统工具
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
# Step 2: 添加软件源信息
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# Step 3: 更新并安装Docker-CE
sudo yum makecache fast
sudo yum -y install docker-ce

# install docker compose
curl -L https://get.daocloud.io/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

# install docker registry mirror
curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s https://19oakk55.mirror.aliyuncs.com

# enable service
systemctl enable docker
systemctl start docker

# varify
docker pull centos
