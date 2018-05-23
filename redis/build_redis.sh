#!/bin/bash
VERSION=4.0.9
if [ ! -d /data/redis ]; then
    mkdir -p /data/redis
    mkdir -p /data/redis/bin
fi
# install jemalloc-devel
yum install jemalloc-devel -y

echo -- begin get redis from official web site.
pushd /data/app
if [ ! -d redis-${VERSION} ]; then
    wget http://download.redis.io/releases/redis-${VERSION}.tar.gz
    tar zxvf redis-${VERSION}.tar.gz
fi

pushd redis-${VERSION}
make
cp redis.conf /data/redis/
cp src/redis-benchmark /data/redis/bin/
cp src/redis-check-aof /data/redis/bin/
cp src/redis-check-dump /data/redis/bin/
cp src/redis-cli /data/redis/bin/
cp src/redis-server /data/redis/bin/
cp src/redis-sentinel /data/redis/bin/
popd
popd
