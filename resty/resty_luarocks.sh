#!/bin/bash
# build resty with luarocks support using for centos or other redhat system.
#

# version for resty
RESTY_VERSION=1.13.6.1
LUAROCKS_VERSION=2.4.4
# 编译工作目录
WORKDIR=/data/app
PREFIX_DIR=/data/openresty
mkdir -p ${WORKDIR}

echo -- begin get openresty from official web site with version ${RESTY_VERSION}
pushd ${WORKDIR}

if [ ! -d openresty-${RESTY_VERSION} ]; then
    wget http://openresty.org/download/openresty-${RESTY_VERSION}.tar.gz
    tar xzvf openresty-${RESTY_VERSION}.tar.gz
    yum install -y readline-devel pcre-devel openssl-devel
fi

pushd openresty-${RESTY_VERSION}/
./configure --prefix=${PREFIX_DIR} \
--with-pcre-jit \
--with-cc-opt="-I/usr/local/include" \
--with-ld-opt="-L/usr/local/lib" \
--with-http_stub_status_module \
--with-http_v2_module
make && make install
popd

echo -- begin install luarocks with luajit prefix
if [ ! -d luarocks-${LUAROCKS_VERSION}.tar.gz ]; then
    wget https://luarocks.org/releases/luarocks-${LUAROCKS_VERSION}.tar.gz
    tar xzvf luarocks-${LUAROCKS_VERSION}.tar.gz
fi
pushd luarocks-${LUAROCKS_VERSION}
./configure --prefix=${PREFIX_DIR}/luajit/ \
    --with-lua=${PREFIX_DIR}/luajit/ \
    --lua-suffix=jit \
    --with-lua-include=${PREFIX_DIR}/luajit/include/luajit-2.1
make build && make install
popd

# install busted
ROCKS_EXEC=${PREFIX_DIR}/luajit/bin/luarocks
${ROCKS_EXEC} install busted
# change busted file
BUSTED_EXEC=${PREFIX_DIR}/luajit/bin/busted
mv ${BUSTED_EXEC} ${BUSTED_EXEC}.bak
cat > ${BUSTED_EXEC} <<EOF
#!${PREFIX_DIR}/bin/resty
if ngx ~= nil then
  ngx.exit = function()end
end

-- Busted command-line runner
require 'busted.runner'({ standalone = false })
EOF
chmod +x ${BUSTED_EXEC}
echo -- end with install busted in ${BUSTED_EXEC}
popd
