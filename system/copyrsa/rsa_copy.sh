#!/bin/bash
# copy ssh id
#

echo Please input login user:
read USER

echo Please input login password:
read -s PASSWD

if [ ! -f hosts ]; then
  echo please create hosts file with hostname in it for copy
  exit
fi

cat hosts | while read host
do

#statements
#ssh-copy-id -i ~/.ssh/id_rsa root@$host
/usr/bin/expect <<SCRIPT
spawn ssh-copy-id  -i ${USER}@${host}
expect {
"yes/no"  {exp_send "yes\r";exp_continue}
"*password:" {exp_send  "$PASSWD\r"}
}
expect eof
SCRIPT

done
