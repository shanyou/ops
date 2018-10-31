#!/usr/bin/env bash
# bash script to help setup ruby enviroment

set -e
RUBY_VERSION=2.4.4
# func
throw() {  eval 'cat <<< "Exception: $e ($*)" 1>&2; exit 1;'; }
get_dist() {
  local lsb_dist=""
  if [ -r /etc/os-release ]; then
          lsb_dist="$(. /etc/os-release && echo "$ID")"
  fi
  echo "$lsb_dist"
}
# init
command -v git > /dev/null 2>&1 || throw "need git installed !!!"
cd ~

# add missing dependence
lsb_dist=$( get_dist )
lsb_dist="$(echo "$lsb_dist" | tr '[:upper:]' '[:lower:]')"
case "$lsb_dist" in
  ubuntu)
  sudo apt install -y libssl-dev libreadline-dev zlib1g-dev
  ;;
  centos)
  sudo yum install -y openssl-devel readline-devel zlib-devel
  ;;
esac

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
# 用来编译安装 ruby
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
# 用来管理 gemset, 可选, 因为有 bundler 也没什么必要
git clone git://github.com/jamis/rbenv-gemset.git  ~/.rbenv/plugins/rbenv-gemset
# 通过 rbenv update 命令来更新 rbenv 以及所有插件, 推荐
git clone git://github.com/rkh/rbenv-update.git ~/.rbenv/plugins/rbenv-update
# 使用 Ruby China 的镜像安装 Ruby, 国内用户推荐
git clone git://github.com/AndorChen/rbenv-china-mirror.git ~/.rbenv/plugins/rbenv-china-mirror

# set path
: ${BASH_RC="$HOME/.bashrc"}
_reg="\(\s\+\)rbenv\s*$"
_reg_match="$(grep -e "${_reg}" ${BASH_RC}|| echo '')"
if [ "${_reg_match}" == "" ]; then
    echo >> ${BASH_RC}
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ${BASH_RC}
    echo 'eval "$(rbenv init -)"' >> ${BASH_RC}
fi

# install ruby
source $BASH_RC
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION
# gem install bundler
