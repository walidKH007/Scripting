#!/bin/bash

echo " --********* package installation *********-- "

#echo "installation / mise à jour de sudo ..."
#apt-get install sudo

echo
echo " installation de lxc ..."
echo

apt-get install lxc -y

echo
echo "installation de lxctl ..." 
echo

apt-get install lxctl -y 

echo
echo "installation de openvswitch-common ..."
echo

apt-get install openvswitch-common -y

echo
echo " installation de openvswitch-switch ..."
echo

apt-get install openvswitch-switch -y

echo
echo " --********* End of installation *********-- "
echo
