#!/usr/bin/env bash
# bash script to help setup go ide enviroment
WORK_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
command -v go || ([[ "$GOPATH" == "" ]] && echo "need go env setup !!!" &&  exit 1)
# get github golang tools mirrors
git clone https://github.com/golang/tools.git $GOPATH/src/golang.org/x/tools
# get lint
git clone https://github.com/golang/lint $GOPATH/src/golang.org/x/lint
# install go tools
go install golang.org/x/lint/golint
go install golang.org/x/tools/cmd/guru
go install golang.org/x/tools/cmd/gorename
go install golang.org/x/tools/cmd/goimports
go get github.com/nsf/gocode
go get github.com/alecthomas/gometalinter
go get github.com/rogpeppe/godef
go get github.com/kisielk/errcheck
go get github.com/jstemmer/gotags
go get github.com/klauspost/asmfmt/cmd/asmfmt
# install go vim ide
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/farazdagi/vim-go-ide.git ~/.vim_go_runtime
sh ~/.vim_go_runtime/bin/install
# set path
: ${BASH_RC="$HOME/.bashrc"}
_reg="vimrc.go"
_reg_match="$(grep -e "${_reg}" ${BASH_RC}|| echo '')"
if [ "${_reg_match}" == "" ]; then
    echo -e "# vim ide setup" >> ${BASH_RC}
    echo -e "alias vimgo='vim -u ~/.vimrc.go'" >> ${BASH_RC}
fi

# change vimgo rc
_reg="t_Co=256"
_reg_match="$(grep -e "${_reg}" ~/.vimrc.go|| echo '')"
if [ "${_reg_match}" == "" ]; then
    echo -e "set t_Co=256" >> ~/.vimrc.go
fi

source ~/.bashrc
echo enjoin vim go ide use vimgo
