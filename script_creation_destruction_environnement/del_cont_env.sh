#!/bin/bash

echo " --********* Delete package *********-- "
echo 

apt-get --purge remove lxc -y

echo 
echo "uninstalling 'lxc' done ... "
echo 

apt-get --purge remove lxctl -y

echo 
echo "uninstalling  'lxctl' done ..."
echo 

apt-get --purge remove openvswitch-common -y

echo 
echo "uninstalling 'openvswitch-common' done ..."
echo 

sudo apt-get --purge remove openvswitch-switch -y

echo 
echo "uninstalling 'openvswitch-switch' done ... "
echo 

echo
echo " --********* Delete of All packege Done *********-- "
echo




