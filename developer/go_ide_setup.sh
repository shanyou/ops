#!/usr/bin/env bash
# bash script to help setup go ide enviroment
WORK_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
command -v go || ([[ "$GOPATH" == "" ]] && echo "need go env setup !!!" &&  exit 1)
# get github golang tools mirrors
echo --> begin get tools
git clone https://github.com/golang/tools.git $GOPATH/src/golang.org/x/tools
# get lint
git clone https://github.com/golang/lint $GOPATH/src/golang.org/x/lint
# install go tools
go install golang.org/x/lint/golint
echo --> golint installed

go install golang.org/x/tools/cmd/guru
echo --> guru installed

go install golang.org/x/tools/cmd/gorename
echo --> gorename installed

go install golang.org/x/tools/cmd/goimports
echo --> goimports installed

go get -u github.com/nsf/gocode
echo --> gocode installed

go get -u github.com/alecthomas/gometalinter
echo --> gometalinter installed

go get -u github.com/rogpeppe/godef
echo --> godef installed

go get -u github.com/kisielk/errcheck
echo --> errcheck installed

go get -u github.com/jstemmer/gotags
echo --> gotags installed

go get -u github.com/klauspost/asmfmt/cmd/asmfmt
echo --> asmfmt installed

# install go vim ide
echo --> begin install go vim ide
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
_reg_match="$(grep -e "${_reg}" ${BASH_RC}|| echo '')"
if [ "${_reg_match}" == "" ]; then
    echo -e "set t_Co=256" >> ${BASH_RC}
fi

source ~/.bashrc
echo --> enjoin vim go ide use vimgo
