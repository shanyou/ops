#!/bin/sh
# redis monitor script

CLI=/data/redis/bin/redis-cli
watch -d -n 1 $CLI info