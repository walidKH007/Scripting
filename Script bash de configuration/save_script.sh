#!/bin/bash

tar cvf $1.tar $2 

curl  -k -c -u $4:$5 -T /home/user/scripts/$1.tar sftp://$3/home/root/upload
