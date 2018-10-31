#!/usr/bin/env bash
# bash script to help setup vim enviroment
# add lua supported
WORK_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# clean yum default vim
yum -y remove vim-*
# tips: when uninstall vim may remove sudo. try to install back using `yum install -y sudo` by root
# install requirement
sudo yum -y groupinstall 'Development tools'
sudo yum install -y ncurses ncurses-devel lua lua-devel

# compile
# git clone https://github.com/vim/vim.git
wget ftp://ftp.vim.org/pub/vim/unix/vim-8.1.tar.bz2
cd vim*
./configure --prefix=/usr --with-features=huge --enable-rubyinterp --enable-pythoninterp --enable-luainterp --with-lua-prefix=/usr
sudo make && sudo make install

exit 0
# uninstall
cd $WORK_DIR/vim*
make uninstall
make clean
