#!/bin/bash

echo "Enter the username : " 
read user_name 

name=$user_name-info
test=$(grep $user_name /etc/passwd)


if [[ $? -ne 0 ]];then 

	echo "username does not exist !" 
	exit 1 
else

	if [[ -e $name || -L $name ]] ; then
		i=0
    		while [[ -e $name-$i || -L $name-$i ]] ; do
       			let i++
   		done
		name=$name-$i
	fi
	grep $user_name /etc/passwd | cut -d: -f1,3,4 >> "$name"

fi




