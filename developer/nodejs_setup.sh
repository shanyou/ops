#!/usr/bin/env bash
# bash script to help setup nodejs enviroment
NODE_VERSION=v8.12.0
# install nvm
# make a clean nvm install for current user
export NVM_DIR=
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
source ~/.bashrc
# install node
nvm install $NODE_VERSION
# install cnpm
npm install -g cnpm --registry=https://registry.npm.taobao.org

# install yarn
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo

sudo yum install -y yarn
