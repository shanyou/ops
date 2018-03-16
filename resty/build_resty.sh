#!/bin/bash
# build script using for centos or other redhat system.
#

# version for resty
VERSION=1.13.6.1
# 编译工作目录
WORKDIR=/data/app
PREFIX_DIR=/data/openresty
mkdir -p ${WORKDIR}

echo -- begin get openresty from official web site with version ${VERSION}
pushd ${WORKDIR}
if [ ! -d ngx_openresty-${VERSION} ]; then
    wget http://openresty.org/download/openresty-${VERSION}.tar.gz
    tar xzvf openresty-${VERSION}.tar.gz
fi

pushd openresty-${VERSION}/
yum install -y readline-devel pcre-devel openssl-devel
./configure --prefix=${PREFIX_DIR} \
--with-pcre-jit \
--with-cc-opt="-I/usr/local/include" \
--with-ld-opt="-L/usr/local/lib" \
--with-http_stub_status_module
make && make install
popd
