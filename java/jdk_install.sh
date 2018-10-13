#!/bin/bash
# Install Oracle JDK 8
# Author: shanyou@gmail.com
# Date: 2018/05/14
WORK_DIR=/data/app
mkdir -p $WORK_DIR
pushd $WORK_DIR

wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.rpm

rpm -ivh jdk-8u171-linux-x64.rpm


# install Gradle
wget -c -t 0 https://downloads.gradle.org/distributions/gradle-4.6-bin.zip

unzip gradle-4.6-bin.zip
echo "PATH=\$PATH:${PWD}/gradle-4.6-bin/bin" | tee -a ~/.bash_profile
popd
