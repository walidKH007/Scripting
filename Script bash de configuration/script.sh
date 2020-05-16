#!/bin/bash


#./Script.sh nomMachine nomInterface adresseIP passerelle dns

echo " -*****- Change Hostname -*****- "
echo

hostn=$(cat /etc/hostname)

#change hostname in /etc/hosts & /etc/hostname
sed -i "s/$hostn/$1/g" /etc/hosts
sed -i "s/$hostn/$1/g" /etc/hostname

new_hostn=$(cat /etc/hostname)

echo " The new hostname \" $new_hostn \" assigned successfully. "

###############################################################

echo
###echo " -*****- Check network interface -*****- "
echo

if [[ ! -d /sys/class/net/${2} ]]; 
	then
		echo No such interface: $2
		exit 1
	else
###############################################################

		echo 
		echo " -*****- disabling the network interface -*****-"

		ifconfig $2 down

		echo
		echo "interface $2 is disabled"
		echo

###############################################################

		echo " -*****- Modification @IP & @DNS -*****-"
		echo

		echo   "auto $2
			iface $2 inet static
				address $3
				netmask 255.255.255.0
			 	gateway $4" > /etc/network/interfaces

		echo "nameserver $5" > /etc/resolv.conf
		echo "configuration done !"
		/etc/init.d/networking restart
		echo "restart service ...."
		echo
fi


echo "-***** Test *****-"
echo "tested connection google" 

if ping -c2 www.google.fr
	then
		echo "successful ping !"
		echo " **** configuration completed !! *** " 
		exit 0
	else
		echo " ping failed !" 
		exit 1
fi
