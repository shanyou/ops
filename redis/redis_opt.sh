#!/bin/bash
#
# the script used to optimize kernel config for redis
# reference url http://www.tuicool.com/articles/VFVBFr
# author shanyou
#

# Background save may fail under low memory condition. To fix this issue add above
sysctl vm.overcommit_memory=1

# WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command
echo never > /sys/kernel/mm/transparent_hugepage/enabled

echo "echo never > /sys/kernel/mm/transparent_hugepage/enabled" >> /etc/rc.local

sysctl net.core.somaxconn=2048


