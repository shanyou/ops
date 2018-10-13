#!/usr/bin/env bash
# bash script to help setup golang enviroment
WORK_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
TOOLS_DIR=$HOME/tools
mkdir -p $TOOLS_DIR
pushd $TOOLS_DIR 1>/dev/null 2>&1
wget https://dl.google.com/go/go1.11.1.linux-amd64.tar.gz
tar -xzf go1.11.1.linux-amd64.tar.gz
rm -f go1.11.1.linux-amd64.tar.gz
# set path
: ${BASH_RC="$HOME/.bashrc"}
_reg="\(\s\+\)go\\bin\s*$"
_reg_match="$(grep -e "${_reg}" ${BASH_RC}|| echo '')"
if [ "${_reg_match}" == "" ]; then
    echo -e "# golang env setup" >> ${BASH_RC}
    echo -e "export PATH=\$PATH:$TOOLS_DIR/go/bin" >> ${BASH_RC}
    echo -e "export GOPATH=$TOOLS_DIR" >> ${BASH_RC}
fi
popd 1>/dev/null 2>&1
