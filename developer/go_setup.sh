#!/usr/bin/env bash
# bash script to help setup golang enviroment
WORK_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
GOPATH_DIR=$HOME/gopath
GOROOT_DIR=$HOME
mkdir -p $GOPATH_DIR $GOROOT_DIR
pushd $GOROOT_DIR 1>/dev/null 2>&1
wget https://dl.google.com/go/go1.11.1.linux-amd64.tar.gz
tar -xzf go1.11.1.linux-amd64.tar.gz
rm -f go1.11.1.linux-amd64.tar.gz
# set path
: ${BASH_RC="$HOME/.bashrc"}
_reg="\(\s\+\)go\\bin\s*$"
_reg_match="$(grep -e "${_reg}" ${BASH_RC}|| echo '')"
if [ "${_reg_match}" == "" ]; then
    echo -e "# golang env setup" >> ${BASH_RC}
    echo -e "export PATH=\$PATH:$GOROOT_DIR/go/bin" >> ${BASH_RC}
    echo -e "export GOPATH=$GOPATH_DIR" >> ${BASH_RC}
fi
popd 1>/dev/null 2>&1
