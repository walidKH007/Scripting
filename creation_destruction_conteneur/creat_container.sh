#!/bin/bash

if [ $# -ne 6 ]
then 
	echo " Arguments manquants ! "
	echo "./creat_contaner.sh template nomMachine addrIP ram cpu mdpRoot"
	exit 1
fi

# creation du container 

echo "creation du container ..."
lxc-create -n $2 -t $1
if [ $? -ne 0 ] 
then
	echo " la creation de container a echoue ! "
	exit 1
fi
echo "creation du container : ok "

# configuration systeme 
echo "---- configuration systeme ----- " 


echo " demarrage de la machine ... " 
lxc-start -n $2
if [ $? -ne 0 ] 
then
	echo " erreur lors du demarrage de la machine ! "
	exit 1
fi
sleep 3


# ----------- CPU ------------------
#lxc-cgroup -n $2 cpuset.cpus $5
if [ $? -ne 0 ] 
then
	echo " l\'attribution des cpu  a echoue ! "
	exit 1
fi
echo " vous avez attribue cpu :"
lxc-cgroup -n $2 cpuset.cpus


#------------------- RAM------------------------

echo "GRUB_CMDLINE_LINUX=\"cgroup_enable=memory\"" >> /etc/default/grub
update-grub 
if [ $? -ne 0 ] 
then
	echo "la mise a jour du grub a echoue! "
	exit 1
fi
echo "grub mis a jour "

lxc-cgroup -n $2 memory.limit_in_bytes $4
if [ $? -ne 0 ] 
then
	echo " erreur lors de la modification de la memoire allouee ! "
	exit 1
fi


echo "...... demarrage ok ! "

echo " vous avez affecte en RAM :" 
#lxc-attach -n $2 --more /proc/meminfo
if [ $? -ne 0 ] 
then
	echo " la verification de la memoire a echoue! "
	exit 1
fi

echo "------- Configuration system ------- "
echo -e $6"\n"$6 | lxc-attach -n $2 passwd root

if [ $? -ne 0 ]
then
	echo "changement mot de passe a echoue! "
	exit 1
fi

echo "------ Fin configuration systeme --- "

echo "---- configuration reseau ---- " 

echo "lxc.network.ipv4 = $3" >> /var/lib/lxc/$2/config

if [ $? -ne 0 ]
then
	echo "attribution d addrese a echoue!"
	exit 1
fi

lxc-stop -n $2
lxc-ls --fancy
echo "------- Fin configuration -------"
